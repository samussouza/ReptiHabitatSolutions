var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})
router.post("/indicadores", function (req, res) {
    medidaController.indicadores(req, res);
});
router.get("/buscarResultadoGraficoBar/:idUsuario", function (req, res) {
    medidaController.buscarResultadoGraficoBar(req, res);
});
module.exports = router;