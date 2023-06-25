import { LoginRequest } from './login/dto/login.request';
import { LoginResponse } from './login/dto/login.response';
import * as express from 'express';

export interface IAuthController{
    signInPatient(req: express.Request, res: express.Response | { message: string, errorCode: number }): Promise<void>;
}