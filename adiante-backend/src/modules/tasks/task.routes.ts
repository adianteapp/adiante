import { Request, Response } from 'express';
import * as controller from './task.controller';
import authJwt from '../../middleware/authJwt';

const taskRoutesBasePath = "/adiante/patient";
module.exports = function(app: any) {
  app.use(function(req: Request, res: Response, next: Function) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
  });

  app.get(
    taskRoutesBasePath+"/:id/tasks/questionnaires/get-mood",
    [authJwt.verifyToken],
    controller.getMoodQuestionnaire
  );
};
