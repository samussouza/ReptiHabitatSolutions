var database = require("../database/config");

function indicadores(empresa) {

    var instrucaoSql = `
    SELECT 
    (SELECT AVG(FkLeituraTemp) 
     FROM Medidas 
     WHERE fkHabitat IN (SELECT idHabitat FROM habitatAnimal WHERE fk_empresa = ${empresa})) AS media_temperatura,
    
    (SELECT AVG(FkLeituraLumi) 
     FROM Medidas 
     WHERE fkHabitat IN (SELECT idHabitat FROM habitatAnimal WHERE fk_empresa = ${empresa})) AS media_lumin,
    
    (SELECT FkLeituraLumi 
     FROM Medidas 
     WHERE fkHabitat IN (SELECT idHabitat FROM habitatAnimal WHERE fk_empresa = ${empresa}) 
     ORDER BY FkLeituraLumi DESC LIMIT 1) AS FkLeituraLumi,
    
    (SELECT FkLeituraTemp 
     FROM Medidas 
     WHERE fkHabitat IN (SELECT idHabitat FROM habitatAnimal WHERE fk_empresa = ${empresa}) 
     ORDER BY FkLeituraTemp DESC LIMIT 1) AS FkLeituraTemp,
    
    (SELECT DATE_FORMAT(DataLeitura, '%d/%m/%Y %H:%i:%s') 
     FROM Medidas 
     WHERE fkHabitat IN (SELECT idHabitat as id FROM habitatAnimal WHERE fk_empresa = ${empresa}) 
     AND (FkLeituraTemp < 22 OR FkLeituraTemp > 29) 
     ORDER BY idMedidas DESC 
     LIMIT 1) AS ultimo_alerta,

     (SELECT idHabitat 
     FROM habitatAnimal 
     WHERE fk_empresa = ${empresa} 
     AND idHabitat IN (SELECT fkHabitat FROM Medidas WHERE FkLeituraTemp < 22 OR FkLeituraTemp > 29) 
     ORDER BY idHabitat DESC 
     LIMIT 1) AS ultimo_alertaID,

    (SELECT COUNT(DISTINCT fkHabitat) 
     FROM Medidas 
     WHERE fkHabitat IN (SELECT idHabitat FROM habitatAnimal WHERE fk_empresa = ${empresa}) 
     AND (FkLeituraTemp < 22 OR FkLeituraTemp > 29)) AS quantidade_habitats_alerta,
    
    (SELECT COUNT(idHabitat) 
     FROM habitatAnimal 
     WHERE fk_empresa = ${empresa}) AS qtd_habitats,
    
    ((SELECT COUNT(DISTINCT fkHabitat) 
      FROM Medidas 
      WHERE fkHabitat IN (SELECT idHabitat FROM habitatAnimal WHERE fk_empresa = ${empresa}) 
      AND (FkLeituraTemp < 22 OR FkLeituraTemp > 29)) 
    / 
    (SELECT COUNT(idHabitat) 
     FROM habitatAnimal 
     WHERE fk_empresa = ${empresa})) * 100 AS percentual_habitats_alerta;


    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarUltimasMedidas(idAquario, limite_linhas) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    FROM medida
                    WHERE fk_aquario = ${idAquario}
                    ORDER BY id DESC LIMIT ${limite_linhas}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {

    var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        FROM medida WHERE fk_aquario = ${idAquario} 
                    ORDER BY id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    indicadores
}
