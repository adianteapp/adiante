import { injectable, inject } from "inversify";
import { GetMoodQuestionnaireRequest } from "./dto/get-mood-questionnaire.request";
import { GetMoodQuestionnaireResponse } from "./dto/get-mood-questionnaire.response";

import { GetMoodQuestionnaireStatus } from "./get-mood-questionnaire.enum";
import * as dotenv from 'dotenv';

import dao from "../../../middleware/dao";
import Logger from '../../../config/logger';
import { IGetMoodQuestionnaireHandler } from "./i-get-mood-questionnaire.handler";
import { GetTaskResponse } from "../../../features/shared/get-task/dto/get-task.response";
import { GetTaskRequest } from "../../../features/shared/get-task/dto/get-task.request";
import { IGetTaskHandler } from "../../../features/shared/get-task/i-get-task.handler";
import {QuestionnaireType} from "../../shared/enums/questionnaire-type.enum";
import { Answer } from "../../../features/shared/get-questionnaire/dto/get-questionnaire.response";
import { Question } from "../../../features/shared/get-questionnaire/dto/get-questionnaire.response";

@injectable()
export class GetMoodQuestionnaireHandler implements IGetMoodQuestionnaireHandler {

  @inject("IGetTaskHandler") private readonly _getTaskHandler: IGetTaskHandler;


  constructor(){
    dotenv.config();
  }

  async execute(getMoodQuestionnaireRequest: GetMoodQuestionnaireRequest): Promise<GetMoodQuestionnaireResponse> {

    let getMoodQuestionnaireResponse: GetMoodQuestionnaireResponse = undefined;
    let taskResponse : GetTaskResponse = undefined;

    const validationRequestResult: GetMoodQuestionnaireStatus = await this.validateRequest(getMoodQuestionnaireRequest);
    if(validationRequestResult !== GetMoodQuestionnaireStatus.Succesfull){
      return getMoodQuestionnaireResponse = {status : validationRequestResult} as GetMoodQuestionnaireResponse;
    }

    const moodQuestionnaireTaskId: string = await this.getMoodQuestionnaireTaskIdFromDB(getMoodQuestionnaireRequest.patientId);
 
    if(moodQuestionnaireTaskId){
      const taskRequest : GetTaskRequest = { patientId:getMoodQuestionnaireRequest.patientId,taskId: moodQuestionnaireTaskId} as GetTaskRequest;
      taskResponse  = await this._getTaskHandler.execute(taskRequest);
    }

    const executionStatus:GetMoodQuestionnaireStatus = taskResponse.questionnaire != undefined ? GetMoodQuestionnaireStatus.Succesfull : GetMoodQuestionnaireStatus.NoContent;

    if(executionStatus == GetMoodQuestionnaireStatus.Succesfull){
      let orderedQuestions:Question[] = [];
      for(const question of taskResponse.questionnaire.questions){
        question.answers = await this.orderAnswers(question.answers);
        orderedQuestions.push(question);
      }
      taskResponse.questionnaire.questions = orderedQuestions;
    }

    getMoodQuestionnaireResponse = {task:taskResponse.task,questionnaire:taskResponse.questionnaire,status:executionStatus} as GetMoodQuestionnaireResponse ;


    return getMoodQuestionnaireResponse;
  }



  private async orderAnswers(answers:Answer[]):Promise<Answer[]>{
    let orderedAnswers:Answer[] = undefined;

    if(answers && answers.length > 0){
      orderedAnswers = answers.sort((a,b) => a.answerOrder - b.answerOrder);
    }

    return orderedAnswers;
  }

  


//#region validations 
  private async validateRequest(getMoodQuestionnaireRequest: GetMoodQuestionnaireRequest): Promise<GetMoodQuestionnaireStatus> {
    let validationResult = GetMoodQuestionnaireStatus.Succesfull;

    if (getMoodQuestionnaireRequest.patientId === undefined) {
      validationResult = GetMoodQuestionnaireStatus.MissedPatientId;
    }

    return validationResult;
  }

  //#endregion validations

  


//#region queries to database

private async getMoodQuestionnaireTaskIdFromDB(patientId:string,langId?:string):Promise<string>{
  let retrievedQuestionnaireTaskId: string = undefined

  const languageId:string = langId != undefined ? langId : process.env.DEAFULT_LANGID


  const sqlQuery = ` SELECT t.id as 'taskId'
                      FROM  task t
                      INNER JOIN program_task pt ON t.id = pt.id_task
                      INNER JOIN patient_program_map ppm ON ppm.id_program  = pt.id_program
                      INNER JOIN task_questionnaire tq ON  tq.id_task = t.id 
                      INNER JOIN questionnaire q ON tq.id_questionnaire = q.id 
                      INNER JOIN questionnaire_type qt ON qt.id = q.id_questionnaire_type                      
                      WHERE ppm.id_patient  = '${patientId}' and qt.code_name = '${QuestionnaireType.dashboard}'`;

    const rows = await dao.executeQuery(sqlQuery);

  if(rows && rows.length > 0){

    retrievedQuestionnaireTaskId = rows[0].taskId.toString();

  }else{
    Logger.error(`Error, mapping  get-mood  for patientId:'${patientId}' total retrieved rows:'${rows.length}' `);
  }
 
  return retrievedQuestionnaireTaskId;
}


//#endregion queries to database



}






