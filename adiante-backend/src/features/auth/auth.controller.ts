import { Request, Response } from 'express';
import { LoginRequest } from './login/dto/login.request';
import { LoginResponse } from './login/dto/login.response';
import {LoginStatus } from './login/login.enum';
import * as express from 'express';
import { controller, httpGet, httpPost, request, response } from "inversify-express-utils";
import { IAuthController } from './i-auth.controller';
import { ILoginHandler } from './login/i-login.handler';
import { inject } from 'inversify/lib/annotation/inject';
import verifyToken from '../../middleware/token-validation.middleware';


@controller("/auth")
export class AuthController implements IAuthController{

  @inject("ILoginHandler") private readonly _loginHandler: ILoginHandler;


  @httpPost("/session")
  async  signInPatient(@request() req: express.Request, @response() res: express.Response): Promise<void> {

    const loginRequest: LoginRequest =  JSON.parse(JSON.stringify(req.body));
    const loginResult = await this._loginHandler.execute(loginRequest);

    switch (loginResult.status) {
      case LoginStatus.Succesfull:
         
        res.status(200).send({
          name: loginResult.name,
          accessToken: loginResult.accessToken
        });
        break;
  
      case LoginStatus.UserNameNotFound:
        res.status(404).send({ message: "User Not found.", errorCode: LoginStatus.UserNameNotFound });
        break;
      case LoginStatus.WrongPassword:
        res.status(401).send({ message: "Invalid Password!", errorCode: LoginStatus.WrongPassword });
        break;
      default:
        res.status(500).send({ message: "Server error", errorCode: LoginStatus.InternalError }); 
    }
  }

  @verifyToken
  @httpGet("/session")
  async validateToken(req: express.Request, res: express.Response ): Promise<void>{
    const patientId :string = req.params.patientId !== undefined ? req.params.patientId:undefined;

    if(patientId != undefined){
      res.status(200).send();
    }else{
      res.status(403).send();
    }
       
  }



}