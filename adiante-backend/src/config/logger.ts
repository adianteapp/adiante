
import winston from 'winston'
import TransportStream from 'winston-transport'
import LokiTransport from 'winston-loki'
import * as dotenv from 'dotenv';
import DailyRotateFile from 'winston-daily-rotate-file';
import e from 'express';

dotenv.config();

const levels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  debug: 4,
}


const logTransports = {
  lokiTransport: new LokiTransport({
    host: `${process.env.API_LOG_GRAFANA_LOKI_URL}`,
    labels: { app: `${process.env.APP_NAME}` },
    json: true,
    level: `${process.env.API_LOG_FILE_LOKI_TRANSPORT_LEVEL}`,
    format: winston.format.json(),
    replaceTimestamp: true,
    onConnectionError: (err) => console.error(err)
  }),
  consoleTransport: new winston.transports.Console(),
  fileTransport: new DailyRotateFile({
    filename: `${process.env.API_LOG_FILE_AUDIT_NAME}`,
    dirname: `${process.env.API_LOG_PATH}`,
    datePattern: 'YYYY-MM-DD',
    zippedArchive: true,
    level: `${process.env.API_LOG_FILE_TRANSPORT_LEVEL}`,
    maxSize: `${process.env.API_LOG_MAX_SIZE}`,
    maxFiles: `${process.env.API_LOG_MAX_DAYS}`
  })
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


let transports: TransportStream[] = [];

if (`${process.env.API_LOG_FILE_LOKI_TRANSPORT_ENABLED}` == '1') {
  transports.push(logTransports.lokiTransport)
}

if (`${process.env.API_LOG_CONSOLE_TRANSPORT_ENABLED}` == '1') {
  transports.push(logTransports.consoleTransport)
}


if (`${process.env.API_LOG_FILE_TRANSPORT_ENABLED}` == '1') {
  transports.push(logTransports.fileTransport)
}



let Logger = winston.createLogger({
  level: 'debug',
  levels,
  format,
  transports,
  handleExceptions: true,
  handleRejections: true,
  exitOnError: false
});


// Set Exception Handler
if (`${process.env.API_LOG_FILE_LOKI_TRANSPORT_ENABLED}` == '1') {
  Logger.exceptions.handle(logTransports.lokiTransport);
} else {
  Logger.exceptions.handle(errorTransport);
}


export default Logger