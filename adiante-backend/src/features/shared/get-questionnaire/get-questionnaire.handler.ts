import { injectable, inject } from "inversify";
import { GetQuestionnaireRequest } from "./dto/get-questionnaire.request";
import { GetQuestionnaireResponse, Questionnaire } from "./dto/get-questionnaire.response";

import { GetQuestionnaireStatus } from "./get-questionnaire.enum";
import * as dotenv from 'dotenv';

import dao from "../../../middleware/dao";
import Logger from '../../../config/logger';
import TaskType from "../enums/task-type.enum";
import { IGetQuestionnaireHandler } from "./i-get-questionnaire.handler";

@injectable()
export class GetQuestionnaireHandler implements IGetQuestionnaireHandler {



  constructor(){
    dotenv.config();
  }

  async execute(getQuestionnaireRequest: GetQuestionnaireRequest): Promise<GetQuestionnaireResponse> {

    let getQuestionnaireResponse: GetQuestionnaireResponse = undefined;
    let relatedQuestionnaire: Questionnaire = undefined;


    const validationRequestResult: GetQuestionnaireStatus = await this.validateRequest(getQuestionnaireRequest);
    if(validationRequestResult !== GetQuestionnaireStatus.Succesfull){
      return getQuestionnaireResponse = {status : validationRequestResult} as GetQuestionnaireResponse;
    }

    if(getQuestionnaireRequest.relatedQuestionnaireId !== undefined){
      relatedQuestionnaire = await this.getQuestionnaireByIdFromDB(getQuestionnaireRequest.relatedQuestionnaireId);
    }

    getQuestionnaireResponse = {questionnaire:relatedQuestionnaire ,status:GetQuestionnaireStatus.Succesfull};


    return getQuestionnaireResponse;
  }


  


//#region validations 
  private async validateRequest(getQuestionnaireRequest: GetQuestionnaireRequest): Promise<GetQuestionnaireStatus> {
    let validationResult = GetQuestionnaireStatus.Succesfull;

    if (getQuestionnaireRequest.relatedQuestionnaireId == undefined) {
      validationResult = GetQuestionnaireStatus.MissedQuestionnaireId;
    }

    return validationResult;
  }

  //#endregion validations

  


//#region queries to database

private async getQuestionnaireByIdFromDB(questionnaireId:number,langId?:string):Promise<Questionnaire>{
  let retrievedQuestionnaire: Questionnaire = undefined

  const languageId:string = langId != undefined ? langId : process.env.DEAFULT_LANGID


  const sqlQuery = ` SELECT 
                          t.id  as 'taskId', q.id as 'questionnaireId',  qt.id  as 'questionnaireTypeId', qt.code_name  as 'questionnaireType',
                          q2.id as 'questionId',q2in.i18n_value as 'questionValue',qt2.code_name 'questionType',
                          a.id  as 'answerId', ain.i18n_value as 'answerValue', rat.id_task as 'answerRelatedTaskId'
                    FROM  task t
                    INNER JOIN task_type tt ON t.id_task_type = tt.id
                    INNER JOIN  task_questionnaire tq ON  tq.id_task = t.id 
                    INNER JOIN questionnaire q ON tq.id_questionnaire = q.id 
                    INNER JOIN questionnaire_type qt ON qt.id = q.id_questionnaire_type 
                    INNER JOIN question q2 ON q.id = q2.id_questionnaire
                    INNER JOIN question_i18n q2in ON q2.id = q2in.id_question 
                    INNER JOIN question_type qt2 ON qt2.id = q2.id_question_type 
                    INNER JOIN answer a  ON a.id_question = q2.id
                    INNER JOIN answer_i18n ain ON a.id = ain.id_answer
                    LEFT OUTER JOIN related_answer_task rat ON a.id = rat.id_task
                    where q.id = '${questionnaireId}' AND ain.id_language = '${languageId}' AND q2in.id_language = '${languageId}'`;

    const rows = await dao.executeQuery(sqlQuery);

  if(rows && rows.length === 1){

    retrievedQuestionnaire = await this.mapDbRestultToQuestionnaire(rows);

  }else{
    Logger.error(`Error, mapping questionnaireId:'${questionnaireId}' total retrieved rows:'${rows.length}' `);
  }
 
  return retrievedQuestionnaire;
}

private async mapDbRestultToQuestionnaire(result:any):Promise<Questionnaire>{
   
  let questionnaire: Questionnaire = undefined;

      questionnaire = {
        questionnaireId: result[0].questionnaireId,
        questionnaireTypeId: result[0].questionnaireTypeId,
        questionnaireType: result[0].questionnaireType,
        questions: result.map((data: any) => ({
          questionId: data.questionId,
          questionValue: data.questionValue,
          questionType: data.questionType,
          answers: result
            .filter((ans: any) => ans.questionId === data.questionId)
            .map((ans: any) => ({
              answerId: ans.answerId,
              answerValue: ans.answerValue,
              answerRelatedTaskId: ans.answerRelatedTaskId
            }))
        }))
      };
 
  return questionnaire;
}

//#endregion queries to database



}






