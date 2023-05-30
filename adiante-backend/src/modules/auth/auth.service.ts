import * as dotenv from 'dotenv';
dotenv.config();

import config from '../../config/auth.config';
import * as authRepository from './auth.repository';
import * as authEnum from './auth.enum';

import Logger from '../../config/logger';

import * as jwt from 'jsonwebtoken';
import * as bcrypt from 'bcryptjs';

/**
 * @description This method is in charge to check the existing of the username in database and to validate if the provided password
 * matches with the stored hashed one.
 * @param {String} username
 * @param {String} password
 * @returns {validationResult,patient,token}
 */
export const validatePatientCredentials = async (userName: string, password: string) => {
  let validationResult = authEnum.LoginStatuses.Succesfull;
  let patient: any;
  let token : any;
  
           
  const queryResult = await authRepository.getPatientByUsername(userName);
  if (queryResult.length == 0) {
    validationResult = authEnum.LoginStatuses.UserNameNotFound;
    return { validationResult, patient, token };
  } 
  

  patient = queryResult[0];
  let passwordIsValid : any;
  if (patient.password !== undefined) {
      passwordIsValid = bcrypt.compareSync(password, patient.password);
  }

  if (!passwordIsValid) {
    validationResult = authEnum.LoginStatuses.WrongPassword;
    return { validationResult, patient, token };
  } 

  token = jwt.sign({ id: patient.email }, config.secret, {
      expiresIn: `${process.env.PATIENT_ACCESS_TOKEN_TTL}`, // 24 hours
    });

    return { validationResult, patient, token }  
};



/**
 * @description This method is in charge to check the existing of the patient in database based on the idPatient
 * @param {idPatient} username
 * @returns {patient}
 */
export const getPatientByPatientId = async (idPatient: string) => {
  let validationResult = authEnum.LoginStatuses.Succesfull;
  let patient: any;
  const queryResult = await authRepository.getPatientByPatientId(idPatient);

  if (queryResult.length == 1) {
    patient = queryResult[0];
  } else {
    Logger.debug('Error retrieving patient with id:' + idPatient);
  }
  return patient;
};
