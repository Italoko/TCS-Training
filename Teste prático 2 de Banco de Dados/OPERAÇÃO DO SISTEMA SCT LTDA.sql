USE italocesarpiovanrocha_t2_tcs;
-- OPERAÇÃO DO SISTEMA SCT LTDA

-- ENTRADA PRODUTOS ---------------------

SET @produtos = '[6,1,6]'; -- Colocar o produtos(id) que compõe a entrada separados por ",". 
SET @quantidade_cada_produto = '[5,1,2]'; -- Colocar a quantidade de cada produto, na mesma sequência, ex: "5" é a qtd do produto "6".
SET @usuario = 1; -- Usuário que deu entrada.
SET @fornecedor = 7; -- Fornecedor dos produtos. 
CALL entrada_produto(@fornecedor, @usuario, @produtos, @quantidade_cada_produto); -- Faz a entrada de acordo com os parâmetros.

-- VENDA DE PRUDUTOS ---------------------

SET @produtos = '[6]'; -- Colocar o produtos(id) que compõe a venda separados por ",". 
SET @quantidade_cada_produto = '[5]'; -- Colocar a quantidade de cada produto, na mesma sequência, ex: "5" é a qtd do produto "6".
SET @usuario = 1; -- Usuário que fez a venda.
SET @cliente = 7; -- Cliente que comprou // Cliente que não deseja se identificar inserir "NULL", ex: SET @cliente = NULL. 
CALL Venda(@cliente, @usuario, @produtos, @quantidade_cada_produto); -- Faz a entrada de acordo com os parâmetros.


-- ------------------------------------------------------ RELATÓRIO PÓS PUPULAÇÃO DO BASE--------------------------------------------------------------------
-- RELAÇÃO DE PRODUTOS
SELECT * FROM produto;

-- RELAÇÃO DE FORECEDORES
SELECT * FROM fornecedor;

-- RELAÇÃO DE CLIENTES
SELECT * FROM cliente;

-- RELAÇÃO DE VENDAS
SELECT id_venda AS VENDA, nome_cliente AS CLIENTE, nome_usuario AS "VENDA POR", FORMAT(total_venda,2) AS "TOTAL VENDA" FROM venda v
LEFT JOIN cliente c ON v.cliente_venda = c.id_cliente 
INNER JOIN usuario u ON v.usuario_venda = u.id_usuario;

-- RELAÇÃO DE ENTRADAS DE PRODUTOS
SELECT id_entrada AS "NOTA FISCAL", nome_fornecedor AS FORNECEDOR, nome_usuario AS "ENTRADA POR", FORMAT(total_nf_entrada,2) AS "TOTAL NOTA" FROM entradaproduto e
INNER JOIN fornecedor f ON e.fornecedor_entrada = f.id_fornecedor 
INNER JOIN usuario u ON e.usuario_entrada = u.id_usuario;

-- VENDA DETALHADA
SET @id_venda = 2; -- Passar id da venda desejada.
SELECT venda_id AS VENDA, descricao_produto AS PRODUTOS, FORMAT(preco_iten,2) AS "PREÇO PROD", quantidade_iten AS QUANTIDADE,   
subtotal_iten AS SUBTOTAL, FORMAT(total_venda,2) AS "TOTAL VENDA" FROM itensvenda itens
INNER JOIN produto p ON itens.produto_id = p.id_produto
INNER JOIN venda v ON itens.venda_id = v.id_venda
WHERE v.id_venda = @id_venda;

-- ENTRADA DETALHADA
SET @id_entrada = 2; -- Passar id da entrada desejada.
SELECT entrada_id AS "NOTA FISCAL", descricao_produto AS PRODUTOS, FORMAT(preco_iten,2) AS "PREÇO PROD", quantidade_iten AS QUANTIDADE,   
subtotal_iten AS SUBTOTAL, FORMAT(total_nf_entrada,2) AS "TOTAL NOTA" FROM itensentrada itens
INNER JOIN produto p ON itens.produto_id = p.id_produto
INNER JOIN entradaproduto e ON itens.entrada_id = e.id_entrada
WHERE e.id_entrada = @id_entrada;

-- ---------------------------------------------------- RELATÓRIOS ÚTEIS PARA MERCADO SCT LTDA--------------------------------------------------------------------
-- VENDA SEM CLIENTE IDENTIFICADO
SELECT * FROM vendas_sem_idcliente;

-- VENDAS COM IDENTIFICAÇÃO 
SELECT * FROM vendas_com_idcliente; 

-- CLIENTE COM COMPRAS
SELECT * FROM cliente_que_ja_comprou; 

-- CLIENTE SEM COMPRAS
SELECT * FROM cliente_que_ainda_nao_comprou; 

-- FORNECEDOR QUE JA FORNECEU ALGUM PRODUTO 
SELECT * FROM fornecedor_com_entrada; 

-- FORNECEDOR QUE NÃO FORNECEU NENHUM PRODUTO AINDA
SELECT * FROM fornecedor_sem_entrada; 

-- RECEITA TOTAL 
SELECT * FROM receita_total; 

-- MAIOR VENDA  
SELECT * FROM maior_venda;

-- MENOR VENDA  
SELECT * FROM menor_venda; 

-- ULTIMA VENDA
SELECT * FROM ultima_venda;

-- QUANTIDADE TOTAL DE VENDAS  
SELECT * FROM total_vendas;

-- VALOR MÉDIO DAS VENDAS  
SELECT * FROM valor_medio_vendas; 

-- PRODUTO COM ESTOQUE MÍNIMO
SELECT * FROM produtos_com_estoque_minimo;