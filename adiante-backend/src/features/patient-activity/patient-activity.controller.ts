import * as express from 'express';
import { IPatientActivityController } from './i-patient-activity.controller';

export class PatientActivityController implements IPatientActivityController{

   async savePatientAnswers  ( req: express.Request, res: express.Response): Promise<void>{
    
   }

}