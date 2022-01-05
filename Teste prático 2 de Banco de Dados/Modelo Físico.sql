CREATE DATABASE italocesarpiovanrocha_t2_tcs;
USE italocesarpiovanrocha_t2_tcs;

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
