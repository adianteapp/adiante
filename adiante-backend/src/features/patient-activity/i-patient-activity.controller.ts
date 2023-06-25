import * as express from 'express';

export interface IPatientActivityController{

    saveActivity  ( req: express.Request, res: express.Response): Promise<void>;

}