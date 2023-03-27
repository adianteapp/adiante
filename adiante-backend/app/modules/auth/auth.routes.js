const { verifySignUp } = require("../../middleware");
const controller = require("./auth.controller");


module.exports = function(app) {
  app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });


/// PATIENT 
  app.post("/adiante/patient/auth/signin", controller.singinPatient);


};
