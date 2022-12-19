
const authService = require("../services/auth/authService");
const authEnum = require("../services/auth/authEnum");




  exports.singinPatient = async (req,res) => {
      
      const loginResult = await authService.validatePatientCredentials(req.body.username,req.body.password);

      switch  (loginResult.validationResult){
         case authEnum.LoginStatuses.Succesfull:
                return res.status(200).send({
                        id: loginResult.patient.id,
                        username: loginResult.patient.username,
                        email: loginResult.patient.email,
                        roles: "",
                        accessToken: loginResult.token
                      });
         case authEnum.LoginStatuses.UserNameNotFound:
               return res.status(404).send({ message: "User Not found." });  
        case authEnum.LoginStatuses.WrongPassword:
              return res.status(401).send({ accessToken: null, message: "Invalid Password!" });        
      }

  };
