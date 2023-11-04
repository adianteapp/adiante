import express,{ ErrorRequestHandler,NextFunction, Request, Response } from 'express';
import cors from 'cors';
import 'reflect-metadata';
import * as dotenv from 'dotenv';
import DiContainer from '../config/di-container.config';
import { Container } from 'inversify';
import { InversifyExpressServer } from 'inversify-express-utils';
import morganMiddleware from '../middleware/morgan.middleware';
import apiErrorHandlerMiddleware from '../middleware/api-error-handler.middleware';
import AdianteLog from './adiante-log';

class AppConfig {
  private app: express.Application;
  private server: InversifyExpressServer;
  private corsOptions: any;
  private container: Container;
 

  constructor() {
    this.app = express();
    this.container = new DiContainer().getContainer();
    this.setup();
  }

  private setup(): void {
    AdianteLog.logApplicationStartingInit();

    dotenv.config();
    this.configureCorsOptions();
    this.configureServer();
  }


  private configureCorsOptions(): void {
    this.corsOptions = {
      origin: process.env.API_VALID_CORS_URL,
    };
  }

  

  private configureServer(): void {
    this.server = new InversifyExpressServer(this.container, null, { rootPath: process.env.API_BASE_URL });

    this.server.setConfig((app) => {
      app.use(express.json());
      app.use(express.urlencoded({ extended: true }));
      app.use(cors(this.corsOptions));
      app.use(morganMiddleware);
    });

    this.server.setErrorConfig(apiErrorHandlerMiddleware);

    const PORT = process.env.API_PORT || 8080;
    this.server.build().listen(PORT, () => {
      AdianteLog.logApplicationStartingEnd(PORT.toString());
    });
  }

  public start(): void {
    this.app.listen();
  }
}

export default AppConfig;
