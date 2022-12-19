require('dotenv').config()
const log4js = require("log4js");
log4js.configure({
  appenders: { fileAppender: { type: "dateFile", filename: process.env.LOG_FILE_LOCATION,
                keepFileExt : true, alwaysIncludePattern :true, maxLogSize: process.env.LOG_FILE_MAX_LOG_SIZE,  pattern: process.env.LOG_FILE_DATE_PATTERN 
              , compress:  process.env.LOG_FILE_COMPRESS  , backups:  process.env.LOG_FILE_BACKUP_NUMBER 
                }
             },
  categories: { default: { appenders: ["fileAppender"], level: process.env.LOG_FILE_LEVEL } },
}); 
const fileAppenderLogger = log4js.getLogger("fileAppender");


module.exports = {
  fileAppenderLogger
};
