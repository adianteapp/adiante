import { LoginRequest } from './dto/login.request';
import { LoginResponse } from './dto/login.response';

export interface ILoginHandler{

    /**
 * @description This method is in charge to check the existing of the username in database and to validate if the provided password
 * matches with the stored hashed one.
 * @param {String} loginRequest.email
 * @param {String} loginRequest.password
 * @returns {LoginResponse}
 */
  execute(loginRequest: LoginRequest):Promise<LoginResponse> ;
}
