CREATE DATABASE ReptiHabitatSolutions;
USE ReptiHabitatSolutions;

CREATE TABLE cadastroUsuario (
  id_user INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(60) NOT NULL,
  cpf VARCHAR(20) NOT NULL,
  dtNssc VARCHAR(20) NOT NULL,
  email VARCHAR(100) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  permissao CHAR(1) NOT NULL,
  PRIMARY KEY (id_user)
  );

CREATE TABLE loginUsuario (
  id_user INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(60) NOT NULL,
  email VARCHAR(100) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  permissao CHAR(1) NOT NULL,
  PRIMARY KEY (id_user)
  );

CREATE TABLE cliente(
  id_cliente INT NULL AUTO_INCREMENT,
  cnpj VARCHAR(20) NOT NULL,
  razao_social VARCHAR(60) NOT NULL,
  nome_fantasia VARCHAR(60) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  email VARCHAR(80) NOT NULL,
  fk_cliente INT,
  PRIMARY KEY (id),
  CONSTRAINT fk_cliente_usuario
    FOREIGN KEY (fk_cliente)
    REFERENCES usuario (id_user)
);

CREATE TABLE endereco (
  id_endereco INT AUTO_INCREMENT,
  logradouro VARCHAR(60) NOT NULL,
  numero VARCHAR (10)  NOT NULL,
  complemento VARCHAR(45) NOT NULL,
  bairro VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  UF CHAR(2) NOT NULL,
  cliente_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_endereco_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES cliente (id)
);

CREATE TABLE medicao (
  id_medicao INT AUTO_INCREMENT,
  temperatura DECIMAL(4,2) NOT NULL,
  lumunosidade DECIMAL(7,2) NOT NULL,
  fk_cliente INT NOT NULL,
  PRIMARY KEY (id_medicao, cliente_id),
  CONSTRAINT ck_cliente_medicao
    FOREIGN KEY (fk_cliente)
    REFERENCES cliente (id)
);
 -- Ter um segunda tabela para se o cliente tiver mais de um endereco
 -- arrumar fk usuario (esta na tabela cliente)
