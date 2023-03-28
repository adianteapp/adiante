import { Request, Response } from 'express';
import * as controller from './patientActivity.controller';
import authJwt from '../../middleware/authJwt';

module.exports = function(app: any) {
  app.use(function(req: Request, res: Response, next: Function) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  app.post(
    "/adiante/patient/activity",
    [authJwt.verifyToken],
    controller.savePatientActivity
  );
};
