import express,{ ErrorRequestHandler,NextFunction, Request, Response } from 'express';
import Logger from "../config/logger";


const apiErrorHandlerMiddleware = (app: express.Application) => {
    app.use((err: any, req: express.Request, res: express.Response, next: express.NextFunction) => {
        Logger.error(err.stack);
        res.status(500).send("Something broke!");
    });
}

export default apiErrorHandlerMiddleware;