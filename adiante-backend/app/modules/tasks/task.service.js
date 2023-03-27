require('dotenv').config()

const taskRepository = require("./task.repository");
const taskEnum = require("./tasks.enum");


const patientActivityEnum = require("../patientActivity/patientActivity.enum");

const loggerConfig = require("../../middleware/log4sConf");
const logger = loggerConfig.fileAppenderLogger;

  /**
   * @description This method is in charge to check the existing of the  task on the database
   * @param {String} username
   * @param {String} password
   * @returns {validationResult,patient,token}
   */
  exports.getTaskById = async (taskId) => {
    const recoveredTask = await  taskRepository.getTaskById(taskId);
    
    if(!recoveredTask){
 
       logger.error("Error saving patient activity. Provided taskid:"+taskId+" not found");
    }
    return recoveredTask;
  };


 