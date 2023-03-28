import { Request, Response } from 'express';
import * as controller from './auth.controller';

module.exports = function(app: any) {
  app.use(function(req: Request, res: Response, next: Function) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });


  /// PATIENT 
  app.post("/adiante/patient/auth/signin", controller.signInPatient);


};