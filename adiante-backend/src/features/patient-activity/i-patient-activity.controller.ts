import * as express from 'express';

export interface IPatientActivityController{

    saveAnswers  ( req: express.Request, res: express.Response): Promise<void>;

}