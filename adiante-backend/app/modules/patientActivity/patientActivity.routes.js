const controller = require("./patientActivity.controller")
const authJwt = require("../../middleware/authJwt");



module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });


  
  app.post(
    "/adiante/patient/activity",
    [authJwt.verifyToken],
    controller.savePatientActivity
  );


};
