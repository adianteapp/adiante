import { LoginRequest } from './dto/login.request';
import { LoginResponse } from './dto/login.response';
import { LoginStatus } from './login.enum';
import config from '../../../config/auth.config';
import * as jwt from 'jsonwebtoken';
import * as bcrypt from 'bcryptjs';
import { ILoginHandler } from './i-login.handler';
import { injectable,inject } from 'inversify';
import { IGetPatientHandler } from '../../shared/get-patient/i-get-patient.handler';
import { GetPatientResponse } from '../../shared/get-patient/dto/get-patient.response';
import { GetPatientRequest } from '../../shared/get-patient/dto/get-patient.request';
import Logger from '../../../config/logger'

@injectable()
export class LoginHandler implements ILoginHandler{

  @inject("IGetPatientHandler")private readonly getPatientHandler: IGetPatientHandler;


 /**
 * @description This method is in charge to check the existing of the username in database and to validate if the provided password
 * matches with the stored hashed one.
 * @param {String} loginRequest.email
 * @param {String} loginRequest.password
 * @returns {LoginResponse}
 */
async  execute(loginRequest: LoginRequest): Promise<LoginResponse> {

    let validationResult = LoginStatus.Succesfull;
    let token : any;
    let loginResponse : LoginResponse = undefined;

    const patientRequest = { email: loginRequest.username } as  GetPatientRequest;
    const patient: GetPatientResponse = await this.getPatientHandler.getPatientByCriteria( patientRequest);

    if (patient == undefined) {
      validationResult = LoginStatus.UserNameNotFound;
      return  {status : validationResult} as LoginResponse;
    } 
    
    const validatePasswordResult = this.validatePassword(patient,loginRequest);
    if(validatePasswordResult != LoginStatus.Succesfull){
      return  {status : validatePasswordResult} as LoginResponse;
    }

    token = this.getToken(patient.patientId);
    const loginResult = {
                          name:patient.name,
                          accessToken:token,
                          id: patient.patientId,
                          status:LoginStatus.Succesfull
                        } as LoginResponse;
  
      return loginResult;
  };



  private getToken(patientId:Number):string{
   const token:string = jwt.sign({ id:Number(patientId.toString()) }, config.secret, {
      expiresIn: `${process.env.PATIENT_ACCESS_TOKEN_TTL}`, // 24 hours
    });
   
    return token;
  }

   
  private validatePassword(patient: GetPatientResponse,loginRequest: LoginRequest):LoginStatus{
     let validationResult : LoginStatus = LoginStatus.Succesfull;

     let passwordIsValid : any;
     if (patient.password !== undefined) {
         passwordIsValid = bcrypt.compareSync(loginRequest.password, patient.password);
     }else{
      Logger.error("Error, retrieved patient  doesnt have a valid pwd on database, patientId:"+patient.patientId);
     }
     return validationResult;
  }



}


