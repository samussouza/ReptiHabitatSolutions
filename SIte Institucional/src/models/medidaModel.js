var database = require("../database/config");

function indicadores(empresa) {

    var instrucaoSql = `SELECT 
    (SELECT AVG(l.LeituraTemp)
     FROM Medidas m
     INNER JOIN habitatAnimal ha ON m.fkHabitat = ha.idHabitat
     INNER JOIN endereco e ON ha.fkEndereco = e.idEndereco
     INNER JOIN empresa emp ON ha.fk_empresa = emp.id
     INNER JOIN Leituras l ON m.fkLeituras = l.id
     WHERE emp.id = ${empresa}) AS media_temperatura,

    (SELECT AVG(l.LeituraLumi)
     FROM Medidas m
     INNER JOIN habitatAnimal ha ON m.fkHabitat = ha.idHabitat
     INNER JOIN endereco e ON ha.fkEndereco = e.idEndereco
     INNER JOIN empresa emp ON ha.fk_empresa = emp.id
     INNER JOIN Leituras l ON m.fkLeituras = l.id
     WHERE emp.id = ${empresa}) AS media_lumin,

    (SELECT l.LeituraLumi
     FROM Medidas m
     INNER JOIN habitatAnimal ha ON m.fkHabitat = ha.idHabitat
     INNER JOIN endereco e ON ha.fkEndereco = e.idEndereco
     INNER JOIN empresa emp ON ha.fk_empresa = emp.id
     INNER JOIN Leituras l ON m.fkLeituras = l.id
     WHERE emp.id = ${empresa}
     ORDER BY l.LeituraLumi DESC LIMIT 1) AS FkLeituraLumi,

    (SELECT l.LeituraTemp
     FROM Medidas m
     INNER JOIN habitatAnimal ha ON m.fkHabitat = ha.idHabitat
     INNER JOIN endereco e ON ha.fkEndereco = e.idEndereco
     INNER JOIN empresa emp ON ha.fk_empresa = emp.id
     INNER JOIN Leituras l ON m.fkLeituras = l.id
     WHERE emp.id = ${empresa}
     ORDER BY l.LeituraTemp DESC LIMIT 1) AS FkLeituraTemp,

    (SELECT DATE_FORMAT(m.DataLeitura, '%d/%m/%Y %H:%i:%s')
     FROM Medidas m
     INNER JOIN habitatAnimal ha ON m.fkHabitat = ha.idHabitat
     INNER JOIN endereco e ON ha.fkEndereco = e.idEndereco
     INNER JOIN empresa emp ON ha.fk_empresa = emp.id
     INNER JOIN Leituras l ON m.fkLeituras = l.id
     WHERE emp.id = ${empresa}
     AND (l.LeituraTemp < 22 OR l.LeituraTemp > 29)
     ORDER BY m.idMedidas DESC LIMIT 1) AS ultimo_alerta,

    (SELECT ha.idHabitat
     FROM habitatAnimal ha
     INNER JOIN empresa emp ON ha.fk_empresa = emp.id
     WHERE emp.id = ${empresa}
     AND ha.idHabitat IN (
         SELECT m.fkHabitat
         FROM Medidas m
         INNER JOIN Leituras l ON m.fkLeituras = l.id
         WHERE l.LeituraTemp < 22 OR l.LeituraTemp > 29
     )
     ORDER BY ha.idHabitat DESC LIMIT 1) AS ultimo_alertaID,

    (SELECT COUNT(DISTINCT ha.idHabitat)
     FROM Medidas m
     INNER JOIN habitatAnimal ha ON m.fkHabitat = ha.idHabitat
     INNER JOIN empresa emp ON ha.fk_empresa = emp.id
     INNER JOIN Leituras l ON m.fkLeituras = l.id
     WHERE emp.id = ${empresa}
     AND (l.LeituraTemp < 22 OR l.LeituraTemp > 29)) AS quantidade_habitats_alerta,

    (SELECT COUNT(ha.idHabitat)
     FROM habitatAnimal ha
     INNER JOIN empresa emp ON ha.fk_empresa = emp.id
     WHERE emp.id = ${empresa}) AS qtd_habitats,

   (SELECT 
        (COUNT(DISTINCT CASE WHEN (l.LeituraTemp < 22 OR l.LeituraTemp > 29) THEN ha.idHabitat END) / COUNT(DISTINCT ha.idHabitat)) * 100 
    FROM 
        Medidas m
        INNER JOIN habitatAnimal ha ON m.fkHabitat = ha.idHabitat
        INNER JOIN empresa emp ON ha.fk_empresa = emp.id
        INNER JOIN Leituras l ON m.fkLeituras = l.id
    WHERE 
        emp.id = ${empresa}) AS percentual_habitats_alerta,

    (SELECT GROUP_CONCAT(subquery.idHabitat SEPARATOR ' e ')
     FROM (
         SELECT ha.idHabitat
         FROM habitatAnimal ha
         INNER JOIN empresa emp ON ha.fk_empresa = emp.id
         WHERE emp.id = ${empresa}
         AND ha.idHabitat IN (
             SELECT m.fkHabitat
             FROM Medidas m
             INNER JOIN habitatAnimal ha ON m.fkHabitat = ha.idHabitat
             INNER JOIN Leituras l ON m.fkLeituras = l.id
             WHERE l.LeituraTemp < 22 OR l.LeituraTemp > 29
         )
         ORDER BY ha.idHabitat DESC
         LIMIT 2
     ) AS subquery) AS ultimo2_alertaID;






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

function buscarResultadoGraficoBar(empresa) {
    var instrucaoSql = `
    SELECT 
        
        AVG(CASE WHEN LeituraTemp < 22 THEN LeituraTemp END) AS MediaAbaixo22,
        AVG(CASE WHEN LeituraTemp >= 22 AND LeituraTemp <= 29 THEN LeituraTemp END) AS MediaEntre22e29,
        AVG(CASE WHEN LeituraTemp > 29 THEN LeituraTemp END) AS MediaAcima29
    FROM (
        SELECT 
            MONTH(DataLeitura) AS Mes,
            LeituraTemp
        FROM Medidas
        JOIN Leituras ON Medidas.fkLeituras = Leituras.id
        WHERE MONTH(DataLeitura) BETWEEN 1 AND 6
    ) AS TempMes
    GROUP BY Mes
    ORDER BY Mes;


                    `;
  
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
  }

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    indicadores,
    buscarResultadoGraficoBar
}
