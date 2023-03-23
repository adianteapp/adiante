require('dotenv').config()
const config = require("../../config/auth.config");
const authRepository = require("../../repositories/authRepository");
const authEnum = require("./authEnum");



var jwt = require("jsonwebtoken");
var bcrypt = require("bcryptjs");


  /**
   * @description This method is in charge to check the existing of the username in database and to validate if the provided password
   * matches with the stored hashed one.
   * @param {String} username
   * @param {String} password
   * @returns {validationResult,patient,token}
   */
  exports.validatePatientCredentials = async (userName,password) => {
      
    let validationResult = authEnum.LoginStatuses.Succesfull;
    let patient;
    const queryResult = await authRepository.getPatientByUsername(userName);

    if(queryResult.length == 0){
         validationResult = authEnum.LoginStatuses.UserNameNotFound;
      }else{
        patient = queryResult[0];

        if(patient.password !== undefined )
        {
          var passwordIsValid = bcrypt.compareSync(
            password,
            patient.password
          );

          if( !passwordIsValid)
          {
            validationResult = authEnum.LoginStatuses.WrongPassword;
          }

        }else{
          validationResult = authEnum.LoginStatuses.InternalError;
        }
        var token = jwt.sign({ id: patient.email }, config.secret, {
          expiresIn: `${process.env.PATIENT_ACCESS_TOKEN_TTL}` // 24 hours
        });
      }
      return {validationResult,patient,token};
  };
