//variaveis que armazenam as valores atuais das medidas de temp e lumin
// temperaturaAtual = sessionStorage.MEDIA_ATUALTEMP;
// luminocidadeAtual = sessionStorage.MEDIA_ATUALLUMIN;
id_habitat = sessionStorage.ID_HABITAT_ALERTA
dataHora_alerta = sessionStorage.DADO_ULTIMO_ALERTA

// console.log('Testando metricas alertas:', temperaturaAtual, luminocidadeAtual);

function validarAlertas() {
    var fk_empresa1 = sessionStorage.FK_EMPRESA;
    fetch("/medidas/alertas", {
        method: "POST",
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            fk_empresa: fk_empresa1
        })
    })
        .then(function (resposta) {
            if (!resposta.ok) {
                throw new Error('Erro ao recuperar os dados');
            }
            return resposta.json();
        }).then((alertas) => {
            if (alertas.length > 0) {
                const idHabitatAlerta = alertas[0].ultimo_alertaID;
                const mediaAtualTemp = alertas[0].FkLeituraTemp;
                const mediaAtualLumin = alertas[0].FkLeituraLumi;
                console.log(idHabitatAlerta, mediaAtualTemp, mediaAtualLumin);
                sessionStorage.MEDIA_ATUALTEMP = mediaAtualTemp;
                sessionStorage.MEDIA_ATUALLUMIN = mediaAtualLumin;
            }
        }).catch(function (erro) {
            console.error(`#ERRO: ${erro.message}`);
        });

    temperaturaAtual = sessionStorage.MEDIA_ATUALTEMP;
    luminocidadeAtual = sessionStorage.MEDIA_ATUALLUMIN;
    console.log('Iniciando validação para emitir os alertas')
    var abaixoTemp = 21;
    var acimaTemp = 29;
    var acimaLumin = 800;
    var abaixoLumin = 400;

    if ((temperaturaAtual <= abaixoTemp) || (temperaturaAtual >= acimaTemp)) {

        document.getElementById('habitatAlerta').innerHTML = `
            Alerta no Habitat ${id_habitat} <br>
            Temperatura fora da média
            `
        mostrarAlerta();
    }

    else if ((luminocidadeAtual > acimaLumin) || (luminocidadeAtual < abaixoLumin)) {
        document.getElementById('habitatAlerta').innerHTML = `
        Alerta no Habitat ${id_habitat} <br>
        Luminosidade fora da média
        `
        mostrarAlerta();
    }
    // else {
    //     document.getElementById('habitatAlerta').innerHTML = `
    //     Temperatura e Luminosidade fora da média
    //     `
    //     mostrarAlerta();
    // }

    else {
        document.getElementById('meuPopup').style.display = 'none'
        return false;
    }

}
function mostrarAlerta() {
    document.getElementById('meuPopup').style.display = 'block'

    var popup = document.getElementById("meuPopup");
    var link = document.getElementById("popupLink");
    var span = document.getElementsByClassName("close-popup")[0];
    // link.onclick = function () {
    //     popup.style.display = "block";
    // }
    span.onclick = function () {
        popup.style.display = "none";
    }


}


