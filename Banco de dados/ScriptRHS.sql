CREATE DATABASE ReptiHabitatSolutions;
USE ReptiHabitatSolutions;
 
-- Criação da tabela de cadastro da empresa 
CREATE TABLE empresa (
    idEmpresa INT AUTO_INCREMENT,
    nomeEmpresa VARCHAR(50) NOT NULL,
    PRIMARY KEY (idEmpresa)
);
-- Criação da tabala usuario para armazenar o cadastro das empresas
CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT,
    nome VARCHAR(50),
    cpf CHAR(11),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(50),
    fkEmpresa INT,
    PRIMARY KEY (idUsuario, fkEmpresa),
   FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idEmpresa)
);

-- Criação da tabela endereço para registrar mais de um endereço para as empresas
CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT,
    logradouro VARCHAR(60) NOT NULL,
    numero INT NOT NULL,
    complemento VARCHAR(45),
    bairro VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    contatoCelular CHAR(11) NOT NULL,
    fkEmpresa INT,
    PRIMARY KEY (idEndereco , fkEmpresa),
    CONSTRAINT foreinEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idEmpresa)
);

-- Criação da tabela haitat animal que será registrado
CREATE TABLE habitatAnimal (
    idAmbiente INT AUTO_INCREMENT,
    especieRepteis VARCHAR(45) NOT NULL,
    qntRepteis INT NOT NULL,
    areaHabitat INT,
    descricao VARCHAR(45) DEFAULT 'Adicionar Descrição',
    fkIdEndereco INT,
    fk_fkEmpresa INT,
    PRIMARY KEY (idAmbiente , fkIdEndereco),
    CONSTRAINT foreinfkEndereco FOREIGN KEY (fkIdEndereco)
        REFERENCES endereco (idEndereco)
);

-- Criação da tabela dos sensores 
CREATE TABLE sensor (
    idSensor INT AUTO_INCREMENT,
    tipo CHAR(4) NOT NULL,
    fkHabitat INT,
    PRIMARY KEY (idSensor , fkHabitat),
    FOREIGN KEY (fkHabitat)
        REFERENCES habitatAnimal (idAmbiente),
    CONSTRAINT chk_tipo CHECK (tipo IN ('LUMIN' , 'TEMP'))
);

-- Criação da tabela de dados dos sensores
CREATE TABLE leituraSensor (
    idLeitura INT AUTO_INCREMENT,
    lm35Temperatura DECIMAL(4.2),
    luminosidade DECIMAL(5 , 2 ),
    dataHora DATETIME,
    fkSensor INT,
    fkHabitatSensor INT,
    PRIMARY KEY (idLeitura , fkSensor , fkHabitatSensor),
    FOREIGN KEY (fkSensor)
        REFERENCES sensor (idSensor),
    FOREIGN KEY (fkHabitatSensor)
        REFERENCES habitatAnimal (idAmbiente)
);

-- Inserção de dados na tabela "empresa"
insert into empresa values
(null, 'C6 Bank', 'isabela@c6bank.com', 'Isabela1234', '31872495000172', 'Financeiro', 01406100, 3186),
(null, 'Jazz Tech', 'paulo@jazztech.com', 'Paulo1234', '35496855000130', 'Financeiro',  05402100, 1368),
(null, 'Itaú', 'matheus@itau.com', 'Matheus1234','60701190000104', 'Financeiro', 04310050, 306),
(null, 'Accenture', 'gustavo@accenture.com', 'Gustavo1234', '96534094000158', 'Consultoria', 04717004, 2051),
(null, 'Safra', 'joao@safra.com', 'Joao1234', '58160789000128', 'Financeiro', 01310300, 2100);

-- Inserção de dados na tabela "login"
insert into login values
(null, 'isabela@c6bank.com', 'Isabela1234', '2024-03-18 18:47:02'),
(null, 'paulo@jazztech.com', 'Paulo1234', '2024-03-16 17:35:22'),
(null, 'matheus@itau.com', 'Matheus1234', '2024-03-19 17:40:32'),
(null, 'gustavo@accenture.com', 'Gustavo1234', '2024-03-21 19:42:22'),
(null, 'joao@safra.com', 'Joao1234', '2024-03-21 22:12:02');

-- Inserção de dados na tabela "ambienteEmpresa"
insert into ambienteEmpresa values
(null, "Escritório Gestor Batatinha"),
(null, "Escritório TI"),
(null,"Escritório Laptops"),
(null,"Escritório Geral"),
(null, "Escritório RH");

-- Inserção de dados na tabela "sensor"
insert into sensor (tipo, quantidade) values
('TEMP', 2),
('UMID', 1),
('TEMP', 3),
('TEMP', 1),
('UMID', 2);

-- Inserção de dados na tabela "leituraSensor"
insert into leituraSensor values
( 26, 25.8, 65, '2024-03-21 18:32:00'),
( 28, 27.6, 68, '2024-03-21 21:25:38'),
( 27, 26.9, 67, '2024-03-22 18:32:12'),
( 29, 28.7, 66, '2024-03-22 19:13:14'),
( 30, 29.5, 65, '2024-03-22 20:47:18');
truncate table leituraSensor;

select * from empresa;
select * from login;
select * from ambienteEmpresa;
select * from sensor;
select * from leituraSensor;

-- Selecionar o nome da empresa, email da empresa e segmento na tabela empresa onde o email do usuario tem '@'
select nomeEmpresa, emailEmpresa, segmento from empresa where emailEmpresa like '%@%';

-- Selecionar o nome da empresa, CEP e numero na tabela empresa onde o segmento da empresa começa com a letra 'F'
select nomeEmpresa, CEP, numero from empresa where segmento like 'F%';

-- Selecionar a descrição da tabela ambienteEmpresa onde o idAmbiente é 2, 3 e 5
select descricao from ambienteEmpresa where idAmbiente in (2,3,5);

-- Selecionar o id, valor da temperatura dht, valor da umidade dht e data, hora da tabela leituraSensor onde o valorUmidadeDht é 65
select idLeitura, valorTemperaturaDht, valorUmidadeDht, dataHora from leituraSensor where valorUmidadeDht = 65;

-- Selecionar o nome da empresa, representante e segmento da tabela cadastroEmpresa
select nomeEmpresa as Empresa,
	   nomeUsuario as Representante,
       segmentoEmpresa as Segmento from cadastroEmpresa;