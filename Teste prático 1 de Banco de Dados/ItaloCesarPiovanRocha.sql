-- 1)
CREATE DATABASE ItaloCesarPiovanRocha_TCS;
USE ItaloCesarPiovanRocha_TCS;
-- 2)
-- a)
CREATE TABLE  vendedor (
  id_vendedor INT NOT NULL AUTO_INCREMENT,
  nome_vendedor VARCHAR(45) NOT NULL,
  email_vendedor VARCHAR(45) NOT NULL,
  telefone_vendedor VARCHAR(12) NOT NULL,
  PRIMARY KEY (id_vendedor));
  
-- b)
CREATE TABLE  cliente (
  id_cliente INT NOT NULL AUTO_INCREMENT,
  nome_cliente VARCHAR(45) NOT NULL,
  email_cliente VARCHAR(45) NOT NULL,
  telefone_cliente VARCHAR(12) NOT NULL,
  PRIMARY KEY (id_cliente));

-- c)
CREATE TABLE  produto (
  id_produto INT NOT NULL AUTO_INCREMENT,
  descricao_produto VARCHAR(45) NOT NULL,
  preco_produto DECIMAL NOT NULL,
  codigo_produto VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_produto));

-- d)
CREATE TABLE  pedido_compra (
  pedido_id INT NOT NULL AUTO_INCREMENT,
  data_pedido DATETIME NOT NULL,
  cliente_id INT NOT NULL,
  vendedor_id INT NOT NULL,
  produto_id INT NOT NULL,
  PRIMARY KEY (pedido_id),
  CONSTRAINT fk_pedido_compra_cliente FOREIGN KEY (cliente_id) REFERENCES cliente (id_cliente),
  CONSTRAINT fk_pedido_compra_vendedor FOREIGN KEY (vendedor_id) REFERENCES vendedor (id_vendedor),
  CONSTRAINT fk_pedido_compra_produto FOREIGN KEY (produto_id) REFERENCES produto (id_produto));

-- 3)
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_0', 'VENDEDOR_0@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_1', 'VENDEDOR_1@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_2', 'VENDEDOR_2@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_3', 'VENDEDOR_3@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_4', 'VENDEDOR_4@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_5', 'VENDEDOR_5@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_6', 'VENDEDOR_6@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_7', 'VENDEDOR_7@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_8', 'VENDEDOR_8@vendedor.com', '9 9999-9999');
INSERT INTO vendedor (nome_vendedor, email_vendedor, telefone_vendedor) VALUES ('VENDEDOR_9', 'VENDEDOR_9@vendedor.com', '9 9999-9999');

-- 4)
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

-- 5)
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_0',100, 'XYZA0');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_1',110, 'XYZB1');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_2',220, 'XYZC2');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_3',330, 'XYZD3');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_4',440, 'XYZE4');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_5',550, 'XYZF5');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_6',660, 'XYZG6');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_7',770, 'XYZH7');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_8',880, 'XYZI8');
INSERT INTO produto (descricao_produto, preco_produto, codigo_produto) VALUES ('produto_9',990, 'XYZJ9');

-- 6)
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+1, 1, 1, 1);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+2, 2, 2, 2);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+3, 3, 3, 3);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+4, 4, 4, 4);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+5, 5, 5, 5);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+4, 6, 6, 6);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+3, 7, 7, 7);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+2, 8, 8, 8);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now()+1, 9, 9, 9);
INSERT INTO pedido_compra (data_pedido, cliente_id, vendedor_id, produto_id) VALUES (now(), 10, 10, 10);

-- 7)
SELECT * FROM vendedor ORDER BY nome_vendedor;

-- 8)
SELECT * FROM cliente ORDER BY id_cliente DESC;

-- 9)
UPDATE cliente SET nome_cliente = "willian", email_cliente = "willian@gmail.com", telefone_cliente = "9999-9999" WHERE id_cliente = 5;

-- 10)
SELECT * FROM pedido_compra; 

-- 11)
SELECT nome_vendedor, nome_cliente, descricao_produto, data_pedido FROM pedido_compra ped
INNER JOIN vendedor v
INNER JOIN cliente c
INNER JOIN produto prod
ON ped.vendedor_id = v.id_vendedor AND ped.cliente_id = c.id_cliente AND ped.produto_id = prod.id_produto;
