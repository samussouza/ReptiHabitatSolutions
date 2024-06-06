-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE ReptiHabitatSolutions;
USE ReptiHabitatSolutions;

-- Criação da tabela "empresa";
CREATE TABLE empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	cnpj CHAR(14)
);
 
-- Criação da tabela "usuário":
CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT,
    nome VARCHAR(50),
    cpf CHAR(11),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(50),
    fkEmpresa int,
    PRIMARY KEY (idUsuario),
    CONSTRAINT fkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa (id)
);

-- Criação da tabela "endereco":
CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT,
    logradouro VARCHAR(60) NOT NULL,
    numero INT NOT NULL,
    complemento VARCHAR(45),
    bairro VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    fkUsuario INT,
    fkIdEmpresa int,
    PRIMARY KEY (idEndereco),
    CONSTRAINT fk_Usuario FOREIGN KEY (fkUsuario) REFERENCES usuario (idUsuario),
	CONSTRAINT fkIdEmpresa FOREIGN KEY (fkIdEmpresa) REFERENCES empresa (id)
);


-- Criação da tabela do "habitatAnimal" que será registrado:
CREATE TABLE habitatAnimal (
  idHabitat INT NOT NULL,
  especieRepteis VARCHAR(45) NOT NULL,
  qtdRepteis INT NOT NULL,
  areaHabitat  INT NULL,
  fkEnderecoINT INT NOT NULL,
  PRIMARY KEY (idHabitat),
  INDEX fk_habitatAnimal_endereco1_idx (fkEndereco ASC) VISIBLE,
  CONSTRAINT fk_habitatAnimal_endereco1
    FOREIGN KEY (fkEndereco)
    REFERENCES endereco (idEndereco));


-- Criação da tabela 'Leituras":
CREATE TABLE Leituras(
  idLuminosidade INT NOT NULL,
  LeituraLumi DECIMAL(5,2) NULL,
  LeituraTemp DECIMAL(5,2) NULL,
  PRIMARY KEY (idLuminosidade));

CREATE TABLE Medidas(
	idMedidas INT AUTO_INCREMENT,
    LeituraLumi INT NOT NULL,
    DataLeitura DATETIME,
    fkLeituraTemp INT,
	fkHabitat INT,
    CONSTRAINT fkLeituraTemp FOREIGN KEY (fkLeituraTemp) REFERENCES Leituras (idLuminosidade),
    CONSTRAINT fkHabitat FOREIGN KEY (fkHabitat) REFERENCES Leituras (idLuminosidade),
    PRIMARY KEY (idMedidas, LeituraLumi, LeituraTemp, fkHabitat)
);