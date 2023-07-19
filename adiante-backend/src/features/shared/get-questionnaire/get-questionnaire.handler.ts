import { injectable, inject } from "inversify";
import { GetQuestionnaireRequest } from "./dto/get-questionnaire.request";
import { Answer, GetQuestionnaireResponse, Question, Questionnaire } from "./dto/get-questionnaire.response";

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
      relatedQuestionnaire = await this.getQuestionnaireByIdFromDB(getQuestionnaireRequest.taskId,getQuestionnaireRequest.relatedQuestionnaireId);
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

  private async getQuestionnaireByIdFromDB(taskId:string,questionnaireId: string, langId?: string): Promise<Questionnaire> {
    let retrievedQuestionnaire: Questionnaire = undefined

    const languageId: string = langId != undefined ? langId : process.env.DEAFULT_LANGID


    const sqlQuery = ` SELECT 
          t.id AS 'taskId',
          q.id AS 'questionnaireId',
          qt.id AS 'questionnaireTypeId',
          qt.code_name AS 'questionnaireType',
          q2.id AS 'questionId',
          q2in.i18n_value AS 'questionValue',
          q2.order AS 'questionOrder',
          q2.mandatory AS 'mandatory',
          qt2.code_name AS 'questionType',
          a.id AS 'answerId',
          ain.i18n_value AS 'answerValue',
          a.order AS 'answerOrder',
          rat.id_task AS 'answerRelatedTaskId'
        FROM task t
        INNER JOIN task_type tt ON t.id_task_type = tt.id
        INNER JOIN task_questionnaire tq ON tq.id_task = t.id
        INNER JOIN questionnaire q ON tq.id_questionnaire = q.id
        INNER JOIN questionnaire_type qt ON qt.id = q.id_questionnaire_type
        INNER JOIN question q2 ON q.id = q2.id_questionnaire
        INNER JOIN question_i18n q2in ON q2.id = q2in.id_question
        INNER JOIN question_type qt2 ON qt2.id = q2.id_question_type
        LEFT OUTER JOIN answer a ON a.id_question = q2.id
        LEFT OUTER JOIN answer_i18n ain ON a.id = ain.id_answer
        LEFT OUTER JOIN related_answer_task rat ON a.id = rat.id_answer
        WHERE t.id = '${taskId}' AND q.id = '${questionnaireId}'  AND q2in.id_language = '${languageId}' AND ( ain.id_language = '${languageId}' OR  a.id IS NULL)
        ORDER BY a.id DESC`;


    const rows = await dao.executeQuery(sqlQuery);

    if (rows && rows.length > 0) {

      retrievedQuestionnaire = await this.mapToQuestionnaire(rows);

    } else {
      Logger.error(`Error, mapping questionnaireId:'${questionnaireId}' total retrieved rows:'${rows.length}' `);
    }

    return retrievedQuestionnaire;
  }



  private async  mapToQuestionnaire(queryResult: any[]): Promise<Questionnaire> {


    let currentQuestionnaire: Questionnaire | undefined;
    let currentQuestion: Question | undefined;
  
    queryResult.forEach((row) => {
  
      if (!currentQuestionnaire || currentQuestionnaire.questionnaireId !== row.questionnaireId.toString()) {
        currentQuestionnaire = {
          questionnaireId : row.questionnaireId.toString(),
          questionnaireTypeId : row.questionnaireTypeId.toString(),
          questionnaireType : row.questionnaireType,
          questions : []
        } as Questionnaire

      }
  
      if (!currentQuestion || currentQuestion.questionId !== row.questionId.toString()) {

        currentQuestion = {
          questionId : row.questionId.toString(),
          questionnaireId : row.questionnaireId.toString(),
          questionValue : row.questionValue,
          questionType : row.questionType,
          questionOrder : row.questionOrder,
          mandatory : row.mandatory == 1 ? true : false,
          answers : []
        } as Question;
        
        currentQuestionnaire.questions.push(currentQuestion);
      }
      if(row.answerId != undefined){
        const anwerRelatedTaskId:string = row.answerRelatedTaskId ? row.answerRelatedTaskId.toString(): null;
        const answer = {
          answerId : row.answerId.toString(),
          questionId : row.questionId.toString(),
          answerValue : row.answerValue,
          answerOrder : row.answerOrder,
          answerRelatedTaskId : anwerRelatedTaskId,
        } as Answer;
  
        currentQuestion.answers.push(answer);
      }

    });
  
    return currentQuestionnaire;
  }

//#endregion queries to database



}






