CREATE DATABASE ReptiHabitatSolutions;
USE ReptiHabitatSolutions;

-- Criação da tabela de cadastro da empresa e usuário
create table empresaCadastro (
    idEmpresa INT auto_increment,
    nomeEmpresa VARCHAR(50) not null,
    emailEmpresa VARCHAR(45) not null unique,
    senhaEmpresa VARCHAR(20) not null unique,
    PRIMARY KEY (idEmpresa)
);

CREATE TABLE endereco (
  idEndereco INT AUTO_INCREMENT,
  logradouro VARCHAR(60) NOT NULL,
  numero INT NOT NULL,
  complemento VARCHAR(45),
  bairro VARCHAR(45) NOT NULL,
  cidade VARCHAR(45) NOT NULL,
  contatoCelular char(11) NOT NULL,
  fkEmpresa INT, 
  PRIMARY KEY (idEndereco, fkEmpresa),
  constraint foreinEmpresa foreign key endereco(fkEmpresa) references empresaCadastro(idEmpresa)
);

-- Criação da tabela haitat animal que será registrado
create table habitatAnimal (
    idAmbiente int auto_increment,
    especieRepteis varchar(45) not null, 
    qntRepteis INT not null,
	areaHabitat INT,
    descricao varchar(45) DEFAULT 'Adicionar Descrição',
    fkIdEndereco INT,
    fk_fkEmpresa INT,
    PRIMARY KEY (idAmbiente, fkIdEndereco, fk_fkEmpresa),
	constraint foreinfkEmpresa foreign key habitatAnimal(fk_fkEmpresa) references empresaCadastro(idEmpresa),
	constraint foreinfkEndereco foreign key habitatAnimal(fkIdEndereco) references endereco(idEndereco)
);

-- Criação da tabela dos sensores
create table sensor (
    idSensor int auto_increment,
    tipo char (4) not null,
    alertaVerde int,
    alertaAmarelo int,
    alertaVermelho int,
    fkHabitat int,
    PRIMARY KEY (idSensor,fkHabitat),
    foreign key (fkHabitat) references habitatAnimal(idAmbiente),
    CONSTRAINT chk_tipo check (tipo in('UMID','TEMP'))
);

-- Criação da tabela de dados dos sensores
create table leituraSensor (
    idLeitura int primary key auto_increment,
    valorTemperaturaDht decimal(4.2),
    valorUmidadeDht decimal(4,2)
    /*dataHora datetime,
    fkSensor int,
    fkHabitatSensor int,
    primary key (idLeitura, fkSensor, fkHabitatSensor),
    foreign key (fkSensor) references sensor(idSensor),
	foreign key (fkHabitatSensor) references habitatAnimal(idAmbiente)*/
);
drop table leiturasensor;
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