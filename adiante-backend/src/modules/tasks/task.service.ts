import * as dotenv from 'dotenv';
dotenv.config();

import taskRepository from "./task.repository";


import loggerConf from '../../middleware/log4sConf';
const logger = loggerConf.logger;

/**
 * @description This method is in charge to check the existing of the task on the database
 * @param {String} taskId
 * @returns {Promise<any>} The recovered task
 */
export async function getTaskById(taskId: string) {
  const recoveredTask = await taskRepository.getTaskById(taskId);

  if (!recoveredTask) {
    logger.error(`Error saving patient activity. Provided taskid: ${taskId} not found`);
  }

  return recoveredTask;
}
