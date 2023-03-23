
const authService = require("../services/auth/authService");
const authEnum = require("../services/auth/authEnum");




  exports.singinPatient = async (req,res) => {
      
      const loginResult = await authService.validatePatientCredentials(req.body.username,req.body.password);

      switch  (loginResult.validationResult){
         case authEnum.LoginStatuses.Succesfull:
                return res.status(200).send({
                        name: loginResult.patient.name,
                        accessToken: loginResult.token
                      });
         case authEnum.LoginStatuses.UserNameNotFound:
               return res.status(404).send({ message: "User Not found.", errorCode: authEnum.LoginStatuses.UserNameNotFound });  
        case authEnum.LoginStatuses.WrongPassword:
              return res.status(401).send({ message: "Invalid Password!", errorCode: authEnum.LoginStatuses.WrongPassword  });        
      }

  };
