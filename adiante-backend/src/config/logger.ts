
import winston from 'winston'
import * as dotenv from 'dotenv';
import DailyRotateFile from 'winston-daily-rotate-file';

dotenv.config();

const levels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  debug: 4,
}

const level = () => {
  const env = process.env.NODE_ENV || 'development'
  const isDevelopment = env === 'development'
  return isDevelopment ? 'debug' : 'warn'
}


const format = winston.format.combine(
  winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss:ms' }),
  winston.format.printf(
    (info) => `${info.timestamp} ${info.level}: ${info.message}`,
  ),
)

const errorTransport = new DailyRotateFile({
  filename: `${process.env.API_LOG_FILE_AUDIT_NAME}`,
  dirname: `${process.env.API_LOG_PATH}`,
  datePattern: 'YYYY-MM-DD',
  zippedArchive: true,
  maxSize: `${process.env.API_LOG_MAX_SIZE}`,
  maxFiles: `${process.env.API_LOG_MAX_DAYS}`
});

const transports = [
  new winston.transports.Console(),
  new DailyRotateFile({
    filename: `${process.env.API_LOG_FILE_AUDIT_NAME}`,
    dirname: `${process.env.API_LOG_PATH}`,
    datePattern: 'YYYY-MM-DD',
    zippedArchive: true,
    
    maxSize: `${process.env.API_LOG_MAX_SIZE}`,
    maxFiles: `${process.env.API_LOG_MAX_DAYS}`
})
]

const Logger = winston.createLogger({
  level: level(),
  levels,
  format,
  transports,exceptionHandlers: [
    errorTransport,
  ],
})

export default Logger