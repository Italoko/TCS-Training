CREATE DATABASE italocesarpiovanrocha_t2_tcs;
USE italocesarpiovanrocha_t2_tcs;

-- Arquitetura da base
CREATE TABLE Produto (
  id_produto INT UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao_produto VARCHAR(45) NOT NULL,
  quantidade_produto INT UNSIGNED NOT NULL,
  quantidade_minima_produto INT UNSIGNED NULL,
  preco_produto DECIMAL NOT NULL,
  PRIMARY KEY (id_produto))
ENGINE = InnoDB;

CREATE TABLE Usuario (
  id_usuario INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome_usuario VARCHAR(45) NOT NULL,
  login_usuario VARCHAR(10) NOT NULL,
  senha_usuario VARCHAR(16) NOT NULL,
  PRIMARY KEY (id_usuario))
ENGINE = InnoDB;

CREATE TABLE Fornecedor (
  id_fornecedor INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome_fornecedor VARCHAR(45) NOT NULL,
  email_fornecedor VARCHAR(45) NOT NULL,
  telefone_fornecedor VARCHAR(12) NOT NULL,
  PRIMARY KEY (id_fornecedor))
ENGINE = InnoDB;

CREATE TABLE EntradaProduto (
  id_entrada INT NOT NULL AUTO_INCREMENT,
  total_nf_entrada DECIMAL NOT NULL,
  usuario_entrada INT UNSIGNED NOT NULL,
  fornecedor_entrada INT UNSIGNED NOT NULL,
  PRIMARY KEY (id_entrada),
  CONSTRAINT fk_EntradaProduto_Usuario FOREIGN KEY (usuario_entrada) REFERENCES Usuario (id_usuario),
  CONSTRAINT fk_EntradaProduto_Fornecedor FOREIGN KEY (fornecedor_entrada) REFERENCES Fornecedor (id_fornecedor))
ENGINE = InnoDB;

CREATE TABLE Cliente (
  id_cliente INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome_cliente VARCHAR(45) NOT NULL,
  email_cliente VARCHAR(45) NOT NULL,
  telefone_cliente VARCHAR(12) NOT NULL,
  PRIMARY KEY (id_cliente))
ENGINE = InnoDB;

CREATE TABLE Venda (
  id_venda INT UNSIGNED NOT NULL AUTO_INCREMENT,
  total_venda DECIMAL NOT NULL,
  cliente_venda INT UNSIGNED NULL,
  usuario_venda INT UNSIGNED NOT NULL,
  PRIMARY KEY (id_venda),
  CONSTRAINT fk_Venda_Cliente FOREIGN KEY (cliente_venda) REFERENCES Cliente (id_cliente),
  CONSTRAINT fk_Venda_Usuario FOREIGN KEY (usuario_venda) REFERENCES Usuario (id_usuario))
ENGINE = InnoDB;

CREATE TABLE ItensVenda (
  venda_id INT UNSIGNED NOT NULL,
  produto_id INT UNSIGNED NOT NULL,
  quantidade_iten INT UNSIGNED NOT NULL,
  preco_iten DECIMAL NOT NULL,
  subtotal_iten DECIMAL NOT NULL,
  PRIMARY KEY (venda_id, produto_id),
  CONSTRAINT fk_ItensVenda_Produto FOREIGN KEY (produto_id) REFERENCES Produto (id_produto),
  CONSTRAINT fk_ItensVenda_Venda FOREIGN KEY (venda_id) REFERENCES Venda (id_venda))
  ENGINE = InnoDB;

CREATE TABLE ItensEntrada (
  entrada_id INT NOT NULL,
  produto_id INT UNSIGNED NOT NULL,
  quantidade_iten INT UNSIGNED NOT NULL,
  preco_iten DECIMAL NOT NULL,
  subtotal_iten DECIMAL NOT NULL,
  PRIMARY KEY (entrada_id, produto_id),
  CONSTRAINT fk_ItensEntrada_Produto FOREIGN KEY (produto_id) REFERENCES Produto (id_produto),
  CONSTRAINT fk_ItensEntrada_EntradaProduto FOREIGN KEY (entrada_id) REFERENCES EntradaProduto (id_entrada))
ENGINE = InnoDB;

DELIMITER //
CREATE PROCEDURE Venda (IN cliente INT, IN usuario INT, IN produtos JSON, IN qtd_produto JSON)
BEGIN
	DECLARE estoque_indisponivel TINYINT DEFAULT FALSE;
	START TRANSACTION;
	INSERT INTO venda (total_venda, cliente_venda, usuario_venda) VALUES (0, cliente, usuario);
	SET @venda = (SELECT LAST_INSERT_ID() venda);
	
	SET @i = 0;
	WHILE ( @i < JSON_LENGTH(produtos))
	DO 
		SET @produto = CAST(JSON_EXTRACT(produtos, CONCAT("$[", @i, "]")) AS UNSIGNED INTEGER);
		SET @qtd = CAST(JSON_EXTRACT(qtd_produto, CONCAT("$[", @i, "]")) AS UNSIGNED INTEGER); 
		
		SELECT quantidade_produto INTO @estoque FROM produto WHERE id_produto = @produto;
		
		IF @estoque >= @qtd THEN
			SELECT preco_produto INTO @preco FROM produto WHERE id_produto = @produto;
		
			SET @subtotal = @preco * @qtd;
			
			INSERT INTO ItensVenda (venda_id, produto_id, quantidade_iten, preco_iten, subtotal_iten) 
			VALUES (@venda, @produto, @qtd, @preco, @subtotal);
			
			UPDATE venda SET total_venda = venda.total_venda + @subtotal WHERE id_venda = @venda;
			UPDATE produto p SET quantidade_produto = p.quantidade_produto - @qtd WHERE id_produto = @produto;
		ELSE
			SELECT descricao_produto INTO @desc_prod FROM produto WHERE id_produto = @produto;
			SELECT @desc_prod AS Produto, "Estoque insuficiente" AS Mensagem;
            SET @i = JSON_LENGTH(produtos); -- Para forçar a parada do WHILE.
            SET estoque_indisponivel = TRUE; -- será feito rollback. 
		END IF;
		SET @i = @i + 1;
   END WHILE;
   
   IF estoque_indisponivel THEN 
	ROLLBACK; 
   ELSE 
	COMMIT;
   END IF;
END //

DELIMITER //
CREATE PROCEDURE entrada_produto (IN fornecedor INT, IN usuario INT, IN produtos JSON, IN qtd_produto JSON)
BEGIN
	START TRANSACTION;
		INSERT INTO EntradaProduto (total_nf_entrada, usuario_entrada, fornecedor_entrada) VALUES (0, usuario, fornecedor);
		SET @entrada = (SELECT LAST_INSERT_ID() entradaproduto);
		
		SET @i = 0;
		WHILE ( @i < JSON_LENGTH(produtos))
		DO 
			SET @produto = CAST(JSON_EXTRACT(produtos, CONCAT("$[", @i, "]")) AS UNSIGNED INTEGER);
			SET @qtd = CAST(JSON_EXTRACT(qtd_produto, CONCAT("$[", @i, "]")) AS UNSIGNED INTEGER); 
			SELECT preco_produto INTO @preco FROM produto WHERE id_produto = @produto;
			
			SET @subtotal = @preco * @qtd;
			
			INSERT INTO ItensEntrada (entrada_id, produto_id, quantidade_iten, preco_iten, subtotal_iten) 
			VALUES (@entrada, @produto, @qtd, @preco, @subtotal);
			
			UPDATE EntradaProduto SET total_nf_entrada = EntradaProduto.total_nf_entrada + @subtotal WHERE id_entrada = @entrada;
			UPDATE produto p SET quantidade_produto = p.quantidade_produto + @qtd WHERE id_produto = @produto;

			SET @i = @i + 1;
	   END WHILE;
	COMMIT;
END //
DELIMITER ;

 -- População da base
INSERT INTO usuario (nome_usuario, login_usuario, senha_usuario) VALUES ('Italo', 'italoko', '12345');
INSERT INTO usuario (nome_usuario, login_usuario, senha_usuario) VALUES ('Willian', 'italoko', '98765');
INSERT INTO usuario (nome_usuario, login_usuario, senha_usuario) VALUES ('Jose', 'seuze', '54321');
 
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_0', 'cliente_0@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_1', 'cliente_1@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_2', 'cliente_2@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_3', 'cliente_3@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_4', 'cliente_4@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_5', 'cliente_5@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_6', 'cliente_6@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_7', 'cliente_7@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_8', 'cliente_8@cliente.com', '9 9999-9999');
INSERT INTO cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('cliente_9', 'cliente_9@cliente.com', '9 9999-9999');

INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_0', 'fornecedor_0@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_1', 'fornecedor_1@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_2', 'fornecedor_2@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_3', 'fornecedor_3@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_4', 'fornecedor_4@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_5', 'fornecedor_5@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_6', 'fornecedor_6@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_7', 'fornecedor_7@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_8', 'fornecedor_8@fornecedor.com', '9 9999-9999');
INSERT INTO fornecedor (nome_fornecedor, email_fornecedor, telefone_fornecedor) VALUES ('fornecedor_9', 'fornecedor_9@fornecedor.com', '9 9999-9999');

INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_0', 50, 5, 100);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_1', 50, 5, 110);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_2', 5, 5, 210);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_3', 50, 5, 310);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_4', 50, 5, 410);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_5', 50, 5, 510);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_6', 50, 5, 610);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_7', 50, 5, 710);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_8', 50, 5, 810);
INSERT INTO produto (descricao_produto, quantidade_produto, quantidade_minima_produto, preco_produto) VALUES ('descricao_produto_9', 50, 5, 910);

-- ENTRADA PRODUTO ---------------------

SET @produtos = '[6]';
SET @quantidade_cada_produto = '[5]';
SET @usuario = 1;
SET @fornecedor = 7;
CALL entrada_produto(@fornecedor, @usuario, @produtos, @quantidade_cada_produto);

SET @produtos = '[5,1,3,4]';
SET @quantidade_cada_produto = '[2,2,2,2]';
SET @usuario = 1;
SET @fornecedor = 2;
CALL entrada_produto(@fornecedor, @usuario, @produtos, @quantidade_cada_produto);

SET @produtos = '[9,7,8,1]';
SET @quantidade_cada_produto = '[1,5,3,10]';
SET @usuario = 2;
SET @fornecedor = 1;
CALL entrada_produto(@fornecedor, @usuario, @produtos, @quantidade_cada_produto);

SET @produtos = '[6,3]';
SET @quantidade_cada_produto = '[2,10]';
SET @usuario = 2;
SET @fornecedor = 5;
CALL entrada_produto(@fornecedor, @usuario, @produtos, @quantidade_cada_produto);

SET @produtos = '[6,3,7]';
SET @quantidade_cada_produto = '[2,1,1]';
SET @usuario = 1;
SET @fornecedor = 6;
CALL entrada_produto(@fornecedor, @usuario, @produtos, @quantidade_cada_produto);

-- VENDA ---------------------

SET @produtos = '[6]';
SET @quantidade_cada_produto = '[5]';
SET @usuario = 1;
SET @cliente = 7;
CALL Venda(@cliente, @usuario, @produtos, @quantidade_cada_produto);

SET @produtos = '[5,1,3,4]';
SET @quantidade_cada_produto = '[2,2,2,2]';
SET @usuario = 1;
SET @cliente = 2;
CALL Venda(@cliente, @usuario, @produtos, @quantidade_cada_produto);

SET @produtos = '[9,7,8,1]';
SET @quantidade_cada_produto = '[1,5,3,10]';
SET @usuario = 2;
SET @cliente = 1;
CALL Venda(@cliente, @usuario, @produtos, @quantidade_cada_produto);

SET @produtos = '[6,3]';
SET @quantidade_cada_produto = '[2,10]';
SET @usuario = 2;
SET @cliente = 5;
CALL Venda(@cliente, @usuario, @produtos, @quantidade_cada_produto);

SET @produtos = '[6,3,7]';
SET @quantidade_cada_produto = '[2,1,1]';
SET @usuario = 1;
SET @cliente = NULL;
CALL Venda(@cliente, @usuario, @produtos, @quantidade_cada_produto);


-- ------------------------------------------------------ RELATÓRIOS PARA MERCADO SCT LTDA--------------------------------------------------------------------

-- VENDA SEM CLIENTE IDENTIFICADO
CREATE VIEW vendas_sem_idcliente AS SELECT id_venda AS VENDA, nome_usuario AS "VENDA POR", FORMAT(total_venda,2) AS "TOTAL VENDA" FROM venda v
INNER JOIN usuario u ON v.usuario_venda = u.id_usuario
WHERE v.cliente_venda IS NULL;

-- VENDAS COM IDENTIFICAÇÃO 
CREATE VIEW vendas_com_idcliente AS 
SELECT id_venda AS VENDA, nome_cliente AS CLIENTE, nome_usuario AS "VENDA POR", FORMAT(total_venda,2) AS "TOTAL VENDA" FROM venda v
INNER JOIN cliente c ON v.cliente_venda = c.id_cliente 
INNER JOIN usuario u ON v.usuario_venda = u.id_usuario;

-- CLIENTE COM COMPRAS
CREATE VIEW cliente_que_ja_comprou AS 
SELECT id_cliente, nome_cliente AS CLIENTE FROM cliente c
WHERE c.id_cliente IN (SELECT v.cliente_venda FROM venda v GROUP BY v.cliente_venda); 

-- CLIENTE SEM COMPRAS
CREATE VIEW cliente_que_ainda_nao_comprou AS 
SELECT id_cliente, nome_cliente AS CLIENTE FROM cliente c
WHERE c.id_cliente NOT IN (SELECT v.cliente_venda FROM venda v GROUP BY v.cliente_venda);

-- FORNECEDOR QUE JA FORNECEU ALGUM PRODUTO 
CREATE VIEW fornecedor_com_entrada AS 
SELECT id_fornecedor, nome_fornecedor AS FORNECEDOR FROM fornecedor f
WHERE f.id_fornecedor IN (SELECT e.fornecedor_entrada FROM entradaproduto e GROUP BY e.fornecedor_entrada); 

-- FORNECEDOR QUE NÃO FORNECEU NENHUM PRODUTO AINDA
CREATE VIEW fornecedor_sem_entrada AS 
SELECT id_fornecedor, nome_fornecedor AS FORNECEDOR FROM fornecedor f
WHERE f.id_fornecedor NOT IN (SELECT e.fornecedor_entrada FROM entradaproduto e GROUP BY e.fornecedor_entrada); 

-- RECEITA TOTAL 
CREATE VIEW receita_total AS SELECT FORMAT(SUM(total_venda),2)AS "RECEITA TOTAL" FROM venda;

-- MAIOR VENDA  
CREATE VIEW maior_venda AS SELECT id_venda AS VENDA, FORMAT(MAX(total_venda),2) AS "VALOR DA VENDA" FROM venda;

-- MENOR VENDA  
CREATE VIEW menor_venda AS SELECT id_venda AS VENDA, FORMAT(MIN(total_venda),2) AS "VALOR DA VENDA" FROM venda;

-- ULTIMA VENDA
CREATE VIEW ultima_venda AS 
SELECT id_venda AS VENDA, nome_cliente AS CLIENTE, nome_usuario AS "VENDA POR", FORMAT(total_venda,2) AS "TOTAL VENDA" FROM venda v
INNER JOIN cliente c ON v.cliente_venda = c.id_cliente 
INNER JOIN usuario u ON v.usuario_venda = u.id_usuario
WHERE v.id_venda = (SELECT LAST_INSERT_ID() venda); 

-- QUANTIDADE TOTAL DE VENDAS  
CREATE VIEW total_vendas AS SELECT COUNT(*) FROM venda;

-- VALOR MÉDIO DAS VENDAS  
CREATE VIEW valor_medio_vendas AS SELECT FORMAT(AVG(total_venda),2)AS "VALOR MÉDIO" FROM venda;

-- PRODUTO COM ESTOQUE MÍNIMO
CREATE VIEW produtos_com_estoque_minimo AS 
SELECT * FROM produto p WHERE p.quantidade_produto IN (SELECT quantidade_minima_produto FROM produto);
