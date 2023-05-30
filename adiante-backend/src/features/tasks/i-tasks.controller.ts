import * as express from 'express';

export interface ITasksController{

    getScheduledTasks  ( req: express.Request, res: express.Response): Promise<void>;
    getMoodQuestionnaire  ( req: express.Request, res: express.Response): Promise<void>;
    getTaskById  ( req: express.Request, res: express.Response): Promise<void>;
}