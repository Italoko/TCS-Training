CREATE DATABASE BDAvaliacao;
USE BDAvaliacao;

CREATE TABLE tb_cliente (
	id_cliente INT UNSIGNED NOT NULL AUTO_INCREMENT,
	nome_cliente VARCHAR(45) NOT NULL,
	email_cliente VARCHAR(45) NOT NULL,
	telefone_cliente VARCHAR(12) NOT NULL,
	PRIMARY KEY (id_cliente));
  
CREATE TABLE tb_produto (
	id_produto INT UNSIGNED NOT NULL AUTO_INCREMENT,
	nome_produto VARCHAR(45) NOT NULL,
	qtd_produto INT UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (id_produto));