import express from 'express';
import cors from 'cors';

import loggerConf from './middleware/log4sConf';
const logger = loggerConf.logger;

import * as dotenv from 'dotenv';
dotenv.config();

const app = express();

logger.info("----------------------------------------------------------------------------------");
logger.info(" starting ADIANTE-BACKEND app");
logger.info("----------------------------------------------------------------------------------");
logger.info("Loading server config");

logger.info("Apply cors options");
const corsOptions = {
  origin: "http://localhost:8081"
};
app.use(cors(corsOptions));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));



logger.info("Mapping routes");
require('./modules/auth/auth.routes')(app);
require('./modules/patientActivity/patientActivity.routes')(app);
require('./modules/tasks/task.routes')(app);

const PORT = process.env.API_PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
  logger.info(`Server is running on port ${PORT}.!!`);
  logger.info("----------------------------------------------------------------------------------");
});
