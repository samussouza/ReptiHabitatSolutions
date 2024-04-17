CREATE DATABASE ReptiHabitatSolutions;
USE ReptiHabitatSolutions;

-- Criação da tabela de cadastro da empresa e usuário
create table empresa (
    idEmpresa INT auto_increment,
    nomeEmpresa VARCHAR(50) not null,
    emailEmpresa VARCHAR(45) not null,
    senha VARCHAR(20) not null,
    CEP CHAR(8) not null,
    numeroLocal char(4),
    PRIMARY KEY (idEmpresa)
);


-- Criação da tabela de login do usuário
create table login (
    idLogin INT auto_increment,
    emailEmpresa VARCHAR(45) not null,
    senha VARCHAR(20) not null,
    dataHora datetime,
    fkEmpresa int not null,
    PRIMARY KEY (idLogin, fkEmpresa),
    foreign key (fkEmpresa) references empresa(idEmpresa)
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
    FORE
    IGN KEY (id_cliente)
    REFERENCES cliente (id)
);

-- Criação da tabela haitat animal que será registrado
create table ambienteEmpresa (
    idAmbiente int auto_increment,
    descricao VARCHAR(45) DEFAULT 'Adicionar Descrição',
    fkEmpresa int not null,
    PRIMARY KEY (idAmbiente),
    foreign key (fkEmpresa) references cadastroEmpresa(idEmpresa)
);

-- Criação da tabela dos sensores
create table sensor (
    idSensor int primary key auto_increment,
    tipo char (4) not null,
    quantidade int not null,
    alertaVerde int,
    alertaAmarelo int,
    alertaVermelho int,
    fkAmbiente int not null,
    fkEmpresa int not null,
    foreign key (fkAmbiente) references ambienteEmpresa(idAmbiente),
    foreign key (fkEmpresa) references ambienteEmpresa(fkEmpresa),
    CONSTRAINT chk_tipo check (tipo in('UMID','TEMP'))
);

-- Criação da tabela de dados dos sensores
create table leituraSensor (
    idLeitura int auto_increment,
    valorTemperaturaDht float,
    valorTemperaturaLm float,
    valorUmidadeDht float,
    dataHora datetime,
    fkSensor int not null,
    primary key (idLeitura),
    foreign key (fkSensor) references sensor(idSensor)
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
(null, 26, 25.8, 65, '2024-03-21 18:32:00'),
(null, 28, 27.6, 68, '2024-03-21 21:25:38'),
(null, 27, 26.9, 67, '2024-03-22 18:32:12'),
(null, 29, 28.7, 66, '2024-03-22 19:13:14'),
(null, 30, 29.5, 65, '2024-03-22 20:47:18');


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