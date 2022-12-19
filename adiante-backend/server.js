const express = require("express");
const cors = require("cors");
const loggerConfig = require("./app/middleware/log4sConf");
const logger = loggerConfig.fileAppenderLogger;
require('dotenv').config()



const app = express();

logger.info("----------------------------------------------------------------------------------");
logger.info(" starting ADIANTE-BACKEND app");
logger.info("----------------------------------------------------------------------------------");
logger.info("Loading server config");

logger.info("Apply cors options");
var corsOptions = {
  origin: "http://localhost:8081"
};
app.use(cors(corsOptions));



// parse requests of content-type - application/json
app.use(express.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));


// simple route
app.get("/", (req, res) => {
  res.json({ message: "Adiante backend up." });
});

// routes
logger.info("Mapping routes");
require('./app/routes/auth.routes')(app);

// set port, listen for requests
const PORT = process.env.API_PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
  logger.info(`Server is running on port ${PORT}.!!`);
  logger.info("----------------------------------------------------------------------------------");
});