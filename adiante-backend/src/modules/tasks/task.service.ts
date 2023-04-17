import * as dotenv from 'dotenv';
dotenv.config();

import taskRepository from "./task.repository";


import loggerConf from '../../middleware/log4sConf';
import { Task } from './models/Task';
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

export async function getMoodQuestionnaire() :  Promise<Task>{
  const moodQuestionnaire = await taskRepository.getMoodQuestionnaire();

  if (!moodQuestionnaire) {
    logger.error(`Error retrieving getMoodQuestionnaire, no content`);
  }

  return moodQuestionnaire;
}