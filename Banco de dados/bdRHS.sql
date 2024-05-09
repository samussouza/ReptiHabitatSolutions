CREATE DATABASE ReptiHabitatSolutions;
USE ReptiHabitatSolutions;

 
-- Criação da tabela "usuário":

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT,
    nome VARCHAR(50),
    cpf CHAR(11),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(50),
    PRIMARY KEY (idUsuario)
);

-- Criação da tabela "endereco":

CREATE TABLE endereco (
    idEndereco INT AUTO_INCREMENT,
    logradouro VARCHAR(60) NOT NULL,
    numero INT NOT NULL,
    complemento VARCHAR(45),
    bairro VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    contatoCelular CHAR(12) NOT NULL,
    fkUsuario INT,
    PRIMARY KEY (idEndereco),
    CONSTRAINT fk_Usuario FOREIGN KEY (fkUsuario) REFERENCES usuario (idUsuario)
);


-- Criação da tabela do "habitatAnimal" que será registrado:

CREATE TABLE habitatAnimal (
    idHabitat INT AUTO_INCREMENT,
    especieRepteis VARCHAR(45) NOT NULL,
    qtdRepteis INT NOT NULL,
    areaHabitat INT,
    descricao VARCHAR(45) DEFAULT 'Adicionar Descrição',
    fkEndereco INT,
    PRIMARY KEY (idHabitat),
    CONSTRAINT fk_Endereco FOREIGN KEY (fkEndereco) REFERENCES endereco (idEndereco)
);

-- Criação da tabela 'sensor":

CREATE TABLE sensor(
idSensor INT,
tipo CHAR(4) NOT NULL,
fkHabitat INT,
PRIMARY KEY(idSensor),
CONSTRAINT fk_Habitat FOREIGN KEY (fkHabitat) REFERENCES habitatAnimal (idHabitat),
CONSTRAINT chk_tipo CHECK (tipo IN ('TEMP', 'LUMI'))
);

-- Criação da tabela de "temperatura":

CREATE TABLE leituraTemperatura (
    idTemperatura INT AUTO_INCREMENT,
    leituraTemp DECIMAL(4, 2),
    dataHora DATETIME,
    fkSensor INT,
    PRIMARY KEY (idTemperatura, fkSensor),
    CONSTRAINT fk_Sensor FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor)
);

-- Criação da tabela de "luminosidade":

CREATE TABLE leituraLuminosidade (
    idLuminosidade INT AUTO_INCREMENT,
    leituraLumi DECIMAL(5, 2),
    dataHora DATETIME,
    fkIdSensor INT,
    PRIMARY KEY (idLuminosidade , fkIdSensor),
    CONSTRAINT fk_IdSensor FOREIGN KEY (fkIdSensor) REFERENCES sensor (idSensor)
);



-- Inserção de dados na tabela "usuario":

INSERT INTO  usuario(nome, cpf, email, senha)
VALUES 
('Maria', '15235896217', 'maria@email.com', 'Maria1234'),
('Antonio','55598632178','antonio@email.com', 'Antonio1234'),
('Marcos','66639586214','marcos@email.com', 'Marcos1234'),
('Stefane','77845215986','stefane@email.com', 'Stefane1234'),
('Ana','63598651548','ana@email.com', 'Ana1234'),
('Selma','12768651500','selma@email.com', 'Selma1234');


SELECT * FROM usuario;

-- Inserção de dados na tabela "endereco":

INSERT INTO endereco (logradouro, numero, complemento, bairro, cidade, contatoCelular, fkUsuario)
VALUES
('Avenida Machado Ferreira', 2000, 'Bloco B', 'Centro', 'São Paulo', '25698645385', 1),
('Avenida dos Imigrantes', 123, 'Bloco A', 'Jardim Azul', 'São Paulo', '69328564771', 2),
('Rua das Camélias', 4006, 'Casa 3', 'Vila Verde', 'São Paulo', '53697152471', 3),
('Rua dos Ferreiros', 101,'apt 8', 'Centro','São Paulo', '15869371240', 4),
('Avenida Casemiro de Souza', 03,'Casa 9', 'Bairro Taboão','São Paulo', '98067171299', 5),
('Avenida Brasil', 122,'Casa 106', 'Bairro Figueiras','São Paulo', '55069094299', 6);

SELECT * FROM endereco;

-- Inserção de dados na tabela "habitatAnimal":
select*from endereco;
INSERT INTO habitatAnimal(especieRepteis, qtdRepteis, areaHabitat, descricao, fkEndereco)
VALUES
('Cobra', 5, 10, 'Habitat para as cobras', 1),
('Lagarto', 6, 11, 'Habitat para os lagartos', 2),
('Tartaruga', 3, 8, 'Habitat para as tartarugas',3),
('Camaleão', 2, 3, 'Habitat para os camaleões', 4),
('Iguana', 2, 3, 'Habitat para as iguanas', 5),
('Jabuti', 2, 3, 'Habitat para jabutis', 6);

SELECT * FROM habitatAnimal;


-- Inserção de dados na tabela "sensor":

INSERT INTO sensor (idSensor,tipo, fkHabitat) 
VALUES
(1,'TEMP', 1),
(2,'LUMI', 2),
(3,'TEMP', 3),
(4,'LUMI', 4),
(5, 'Temp', 5),
(6, 'LUMI', 6);

SELECT * FROM sensor;

-- Inserção de dados na tabela "temperatura":

INSERT INTO leituraTemperatura (leituraTemp, dataHora, fkSensor)
VALUES(25.8, NOW(), 1), 
      (26.2, NOW(), 3),   
	  (22.6, NOW(), 5);
      
SELECT * FROM leituraTemperatura; 

-- Inserção de dados na tabela "luminosidade":

INSERT INTO leituraLuminosidade (leituraLumi, dataHora, fkIdSensor)
VALUES(600.00, NOW(), 2), 
      (700.00, NOW(), 4),   
	  (400.00, NOW(), 6);
      

SELECT * FROM leituraLuminosidade;

----------------- SELECTS -----------------:  

SELECT * FROM usuario;
SELECT * FROM endereco;
SELECT * FROM habitatAnimal;
SELECT * FROM sensor;
SELECT * FROM leituraTemperatura;
SELECT * FROM leituraLuminosidade;


-- Encontrar todos os usuários cujo nome começa com "an":
select * from  usuario where nome  like 'ma%';

-- Encontra todos os endereços que ficam no centro:
select	* from  endereco where bairro like 'centro';

-- SELECT para espÉcies que começam com a letra C:
SELECT * FROM habitatAnimal WHERE especieRepteis LIKE 'C%';

-- SELECT penultima letra da descrição dos habitats:
SELECT * FROM habitatAnimal WHERE descricao LIKE '%a_';





-------------- INNER JOINS ------------------:

-- INNER JOIN entre leituraTemperatura e habitat, para visualizar de onde; qual habitat está vindo a leitura temperatura:

select  h.idhabitat, h.especieRepteis, h.qtdRepteis, h.areaHabitat, h.descricao,
 lt.idTemperatura, lt.leituraTemp, lt.dataHora
from habitatAnimal h 
inner join leituraTemperatura lt;
-- Join entre usuario e endereco:

select  u.nome as nome_usuario, u.email,  e.logradouro, e.complemento, e.cidade
from usuario u
inner join endereco  e on e.fkUsuario = u.idUsuario;


-- Join entre habitatAnimal, endereco e usuario:

select h.especieRepteis, h.qtdRepteis, h.areaHabitat, h.descricao,
e.logradouro, e.numero ,e.bairro , e.cidade, e.contatoCelular, u.nome
from  habitatAnimal h 
inner join endereco  e on  h.fkEndereco = e.idEndereco
inner join usuario u on e.fkUsuario = u.idUsuario;



-- Join entre sensor e leituraTemperatura, listará da maior para a menor temperatura:

SELECT lt.idTemperatura, lt.leituraTemp, lt.dataHora, s.idSensor
FROM leituraTemperatura AS lt
INNER JOIN sensor AS s
ON fkSensor = idSensor
ORDER BY  leituraTemp desc;


-- JOIN ENTRE LEITURA TEMPERATURA E LEITURA LUMINOSIDADE, PARA VER AS DUAS
SELECT lt.*, l.*, s.*
FROM sensor AS s
JOIN leituraTemperatura AS lt
ON lt.fkSensor = s.idSensor
JOIN leituraLuminosidade AS l
ON l.fkIdSensor = s.idSensor;
----------- LEFT JOINS -----------------:

-- LEFT JOIN entre endereco e habitatAnimal, para ver onde os habitats estão localizadoos:

SELECT e.idEndereco, e.logradouro, e.bairro, e.cidade, h.idHabitat, h.areaHabitat, h.descricao
FROM endereco AS e LEFT JOIN habitatAnimal AS h 
ON e.idEndereco = h.fkEndereco;


-- LEFT JOIN entre habitatAnimal e sensor, saber qual espécie e quais temperaturas e luminosidade dos respectivos habitats:

SELECT h.especieRepteis, h.areaHabitat, s.idSensor, lt.leituraTemp
FROM habitatAnimal AS h LEFT JOIN sensor AS s 
ON h.idHabitat = s.fkHabitat
LEFT JOIN leituraTemperatura AS lt ON lt.fkSensor = s.idSensor;









 -- drop database ReptiHabitatSolutions;