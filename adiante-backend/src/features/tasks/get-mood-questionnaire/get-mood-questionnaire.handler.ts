import { injectable, inject } from "inversify";
import { GetMoodQuestionnaireRequest } from "./dto/get-mood-questionnaire.request";
import { GetMoodQuestionnaireResponse, MoodQuestionnaire } from "./dto/get-mood-questionnaire.response";

import { GetMoodQuestionnaireStatus } from "./get-mood-questionnaire.enum";
import * as dotenv from 'dotenv';

import dao from "../../../middleware/dao";
import Logger from '../../../config/logger';
import { IGetMoodQuestionnaireHandler } from "./i-get-mood-questionnaire.handler";

@injectable()
export class GetMoodQuestionnaireHandler implements IGetMoodQuestionnaireHandler {



  constructor(){
    dotenv.config();
  }

  async execute(getQuestionnaireRequest: GetMoodQuestionnaireRequest): Promise<GetMoodQuestionnaireResponse> {

    let getMoodQuestionnaireResponse: GetMoodQuestionnaireResponse = undefined;
    let questionnaire: MoodQuestionnaire = undefined;


    const validationRequestResult: GetMoodQuestionnaireStatus = await this.validateRequest(getQuestionnaireRequest);
    if(validationRequestResult !== GetMoodQuestionnaireStatus.Succesfull){
      return getMoodQuestionnaireResponse = {status : validationRequestResult} as GetMoodQuestionnaireResponse;
    }

    questionnaire = await this.getQuestionnaireByIdFromDB(getQuestionnaireRequest.patientId);
 
    const executionStatus:GetMoodQuestionnaireStatus = questionnaire.questionnaireId != undefined ? GetMoodQuestionnaireStatus.Succesfull : GetMoodQuestionnaireStatus.NoContent;
    getMoodQuestionnaireResponse = {questionnaire:questionnaire ,status:executionStatus};


    return getMoodQuestionnaireResponse;
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

private async getQuestionnaireByIdFromDB(patientId:number,langId?:string):Promise<MoodQuestionnaire>{
  let retrievedQuestionnaire: MoodQuestionnaire = undefined

  const languageId:string = langId != undefined ? langId : process.env.DEAFULT_LANGID


  const sqlQuery = ` SELECT 
                        t.id  as 'taskId', q.id as 'questionnaireId',  qt.id  as 'questionnaireTypeId', qt.code_name  as 'questionnaireType',
                        q2.id as 'questionId',q2in.i18n_value as 'questionValue',qt2.code_name 'questionType',
                        a.id  as 'answerId', ain.i18n_value as 'answerValue', rat.id_task as 'answerRelatedTaskId'
                      FROM  task t
                      INNER JOIN task_type tt ON t.id_task_type = tt.id
                      INNER JOIN program_task pt ON t.id = pt.id_task
                      INNER JOIN patient_program_map ppm ON ppm.id_program  = pt.id_program
                      INNER JOIN task_questionnaire tq ON  tq.id_task = t.id 
                      INNER JOIN questionnaire q ON tq.id_questionnaire = q.id 
                      INNER JOIN questionnaire_type qt ON qt.id = q.id_questionnaire_type 
                      INNER JOIN question q2 ON q.id = q2.id_questionnaire
                      INNER JOIN question_i18n q2in ON q2.id = q2in.id_question 
                      INNER JOIN question_type qt2 ON qt2.id = q2.id_question_type 
                      INNER JOIN answer a  ON a.id_question = q2.id
                      INNER JOIN answer_i18n ain ON a.id = ain.id_answer
                      LEFT OUTER JOIN related_answer_task rat ON a.id = rat.id_task
                      WHERE ppm.id_patient  = '${patientId}' AND ain.id_language = '${languageId}' AND q2in.id_language = '${languageId}' and qt.code_name = 'qt-dashboard'`;

    const rows = await dao.executeQuery(sqlQuery);

  if(rows && rows.length > 0){

    retrievedQuestionnaire = await this.mapDbRestultToQuestionnaire(rows);

  }else{
    Logger.error(`Error, mapping  get-mood  for patientId:'${patientId}' total retrieved rows:'${rows.length}' `);
  }
 
  return retrievedQuestionnaire;
}

private async mapDbRestultToQuestionnaire(result:any):Promise<MoodQuestionnaire>{
   
  let questionnaire: MoodQuestionnaire = undefined;

      questionnaire = {
        questionnaireId: String(result[0].questionnaireId),
        questionnaireTypeId: String(result[0].questionnaireTypeId),
        questionnaireType: result[0].questionnaireType,
        questions: result.map((data: any) => ({
          questionId: String(data.questionId),
          questionValue: data.questionValue,
          questionType: data.questionType,
          answers: result
            .filter((ans: any) => ans.questionId === data.questionId)
            .map((ans: any) => ({
              answerId: String(ans.answerId),
              answerValue: ans.answerValue,
              answerRelatedTaskId: String(ans.answerRelatedTaskId)
            }))
        }))
      };
 
  return questionnaire;
}

//#endregion queries to database



}






