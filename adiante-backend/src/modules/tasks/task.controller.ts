import { Request, Response } from 'express';
import * as taskService from './task.service';


import loggerConf from '../../middleware/log4sConf';
const logger = loggerConf.logger;

export const getMoodQuestionnaire = async (req: Request, res: Response) => {
  try{
    const moodQestionnaireResult = await taskService.getMoodQuestionnaire();

    if(moodQestionnaireResult){
      res.status(200).send({ task:moodQestionnaireResult });
    }else{
      
      return res.status(204).send({ message: "No GetMood questionnaire found"});
    }
  }catch(err)
  {
    logger.error(`ERROR retrieving GetMood questionnaire:`+err);
    return res.status(500).send({ message: "Internal server error" });
  }
}
