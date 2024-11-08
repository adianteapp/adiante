import { RequestAnswer, SaveAnswersRequest } from "./dto/save-answers.request";
import { SaveAnswersResponse } from "./dto/save-answers.response";
import { ISaveAnswersHandler } from "./i-save-answers.handler";
import { SaveAnswersStatus } from "./save-answers.enum";
import Logger from "../../../config/logger";
import { inject, injectable } from "inversify";
import { IGetPatientHandler } from "../../../features/shared/get-patient/i-get-patient.handler";


import { IGetTaskHandler } from "../../../features/shared/get-task/i-get-task.handler";
import { GetTaskRequest } from "../../../features/shared/get-task/dto/get-task.request";
import { GetTaskResponse } from "../../../features/shared/get-task/dto/get-task.response";
import { QuestionType } from "../../../features/shared/enums/question-type.enum";
import dao from "../../../middleware/dao";
import { IPreparePatientActivityHandler } from "./prepare-patient-activity/i-prepare-patient-activity.handler";
import { PreparePatientActivityRequest } from "./prepare-patient-activity/dto/prepare-patient-activity.request";
import { PatientActivityEntry, PreparePatientActivityResponse } from "./prepare-patient-activity/dto/prepare-patient-activity.response";

import { Question, Questionnaire } from "../../../features/shared/get-questionnaire/dto/get-questionnaire.response";
import { FilledQuestionnaire } from "./dto/save-answers.request";
import TaskType from "../../../features/shared/enums/task-type.enum";
import { IGetScheduledTaskByIdHandler } from "../../../features/tasks/get-scheduled-task-by-id/i-get-scheduled-task-by-id.handler";
import { GetScheduledTaskByIdRequest } from "../../../features/tasks/get-scheduled-task-by-id/dto/get-scheduled-task-by-id.request";
import { GetScheduledTaskByIdResponse } from "../../../features/tasks/get-scheduled-task-by-id/dto/get-scheduled-task-by-id.response";

@injectable()
export class SaveAnswersHandler implements ISaveAnswersHandler{



   @inject("IGetPatientHandler")private readonly getPatientHandler: IGetPatientHandler;
   @inject("IGetTaskHandler")private readonly getTasktHandler: IGetTaskHandler;
   @inject("IPreparePatientActivityHandler")private readonly preparePatientActivityHandler: IPreparePatientActivityHandler;
   @inject("IGetScheduledTaskByIdHandler")private readonly getScheduledTaskByIdHandler: IGetScheduledTaskByIdHandler;


 /**
 * @description This method is in charge to save the activity confirmed by the patient.
 * @param {SaveAnswersRequest} saveAnswersRequest
 * @returns {SaveAnswersResponse}
 */
  async  execute(saveAnswersRequest:SaveAnswersRequest):Promise<SaveAnswersResponse>{
        let saveAnswersResponse : SaveAnswersResponse = {}as SaveAnswersResponse;
        let validationResult :SaveAnswersStatus;
 


        const getTaskHandlerRequest: GetTaskRequest = {taskId: saveAnswersRequest.executedTask.idTask, patientId:saveAnswersRequest.patientId} as GetTaskRequest;
        const originalTask: GetTaskResponse = await this.getTasktHandler.execute(getTaskHandlerRequest);

        //apply validations
        validationResult = await this.validateRequest(saveAnswersRequest,originalTask);
     
        if (validationResult !== SaveAnswersStatus.Success) {
           return { status: validationResult };
        }
     
        //build the objects to save them into the database
        const preparePatientActivityResponse: PreparePatientActivityResponse = await this.preparePatientActivityHandler.execute({patientActivityData:saveAnswersRequest,taskType:originalTask.task.taskTypeCode} as PreparePatientActivityRequest);
     
        //save the info
        let saveResult:string ;
     
        if (originalTask.task.taskTypeCode === TaskType.questionnaire || originalTask.task.taskTypeCode === TaskType.challenge) {
            if(saveAnswersRequest.executedTask.idScheduledTask){
               saveResult = await this.insertPatientTaskScheduledQuestionnaireEntry(preparePatientActivityResponse.patientActivityEntry ,saveAnswersRequest.executedTask.idScheduledTask);
            }else{
               saveResult = await this.insertPatientTaskQuestionnaireEntry(preparePatientActivityResponse.patientActivityEntry);
            }
            
        } else {
         saveResult = await this.insertPatientTaskExecutionEntry(preparePatientActivityResponse.patientActivityEntry, saveAnswersRequest.executedTask.idScheduledTask);
        }
         
        if(saveResult != "-1"){
            saveAnswersResponse.status  = SaveAnswersStatus.Success;
            saveAnswersResponse.patientActivityEntryId = saveResult;
        }else{
         saveAnswersResponse.status  = SaveAnswersStatus.InternalError;
        }


        return saveAnswersResponse;
    }

 
 //#region Validations over player and task.
 
   async validateRequest(saveAnswersRequest: SaveAnswersRequest, originalTask: GetTaskResponse): Promise<SaveAnswersStatus> {

      let validationResult: SaveAnswersStatus = SaveAnswersStatus.Success;

      // PatientId validation
      validationResult = await this.validateIdPatient(saveAnswersRequest.patientId);
      if (validationResult !== SaveAnswersStatus.Success) {
         return validationResult;
      }

      //validate that at least 1 activity is provide
      validationResult = await this.validateMandatoryTaskId(saveAnswersRequest);
      if (validationResult !== SaveAnswersStatus.Success) {
         return validationResult;
      }

      if (originalTask && originalTask.task) {

         //validate task type
         switch (originalTask.task.taskTypeCode) {
            case TaskType.completionCheck:
               validationResult = await this.validateTaskTypeConfirmCompletion(saveAnswersRequest);
               break;
            case TaskType.questionnaire:
               validationResult = await this.validateTaskTypeQuestionnaire(saveAnswersRequest, originalTask);
               break;
           case TaskType.challenge:
                  //Challenges can have a related questionnaire.
                  validationResult = await this.validateTaskTypeQuestionnaire(saveAnswersRequest, originalTask);
                  break;
            default:
               Logger.error("Error saving patient activity. Invalid task type retrived from DB:" + originalTask.task.taskTypeCode);
               validationResult = SaveAnswersStatus.InternalError;
               break;
         }
      } else {
         Logger.error("Error saving patient activity. Invalid taskId:" + saveAnswersRequest.executedTask.idTask);
         validationResult = SaveAnswersStatus.InvalidTaskId;
      }

      return validationResult;
   }

 async  validateTaskTypeConfirmCompletion(saveAnswersRequest:SaveAnswersRequest): Promise<SaveAnswersStatus> {
 
   let validationResult: SaveAnswersStatus = SaveAnswersStatus.Success;
   const request: GetScheduledTaskByIdRequest = {scheduledId:saveAnswersRequest.executedTask.idScheduledTask } as GetScheduledTaskByIdRequest;
   const response: GetScheduledTaskByIdResponse = await this.getScheduledTaskByIdHandler.execute(request);

   if (response && response.scheduledId) {
      //validate that the task is not already completed
      validationResult = response.activityEntryId ? SaveAnswersStatus.ScheduledTaskAlreadyCompleted : SaveAnswersStatus.Success;

      //validate that the task is assigned to the patient
      if(validationResult == SaveAnswersStatus.Success){
         validationResult = response.patientId != saveAnswersRequest.patientId ? SaveAnswersStatus.TaskNotAssignedToPatient : SaveAnswersStatus.Success;
      }
   }
   else{
      Logger.error("Error saving patient activity. Invalid scheduledTaskId:" + saveAnswersRequest.executedTask.idScheduledTask);
      validationResult = SaveAnswersStatus.InvalidScheduledTaskId;
   }

   return validationResult;
 }



 async  validateTaskTypeQuestionnaire(saveAnswersRequest:SaveAnswersRequest,task:GetTaskResponse): Promise<SaveAnswersStatus> {
 
   let validationResult: SaveAnswersStatus = SaveAnswersStatus.Success;

   //validate task integrity references
   validationResult = await this.validateTaskAnswers(saveAnswersRequest,task);
   if (validationResult !== SaveAnswersStatus.Success) {
      return validationResult;
   }

   return validationResult;
}
 

 
   async validateTaskAnswers(saveAnswersRequest: SaveAnswersRequest,getTaskResponse: GetTaskResponse): Promise<SaveAnswersStatus> {

   
      let questionnaireValidation: SaveAnswersStatus = undefined;

      if (getTaskResponse && getTaskResponse.task ) {

         if(getTaskResponse.task.relatedQuestionnaireId){
            
            questionnaireValidation = await this.validateQuestionnaireData(saveAnswersRequest,getTaskResponse);
            if (questionnaireValidation !== SaveAnswersStatus.Success) {
               return questionnaireValidation;
            }else{
               return SaveAnswersStatus.Success;
            }
         }
           
      }
      else {

         Logger.error("Error saving patient activity. Invalid taskId:" + saveAnswersRequest.executedTask.idTask);
         return SaveAnswersStatus.InvalidTaskId;

      }

      return SaveAnswersStatus.Success;
   }
 
 async  validateIdPatient(patientId: string): Promise<SaveAnswersStatus> {
 
    if (patientId === undefined) {

       Logger.error("Patientid not provided, activity can not be saved");
       return SaveAnswersStatus.PatientNotFound;
    // NOTE: This method only validates if the patientId is present, getTask feaute validates if there is an patient with the providedId.

    }else {
       return SaveAnswersStatus.Success;
    }
 }
 
 async  validateMandatoryTaskId(saveAnswersRequest: SaveAnswersRequest): Promise<SaveAnswersStatus> {
 
    if (!saveAnswersRequest || !(saveAnswersRequest.executedTask) || !(saveAnswersRequest.executedTask.idTask)) {
 
       Logger.error("Error saving patient activity. No taskid provided");
       return SaveAnswersStatus.InvalidTaskId
 
    } else {
       return SaveAnswersStatus.Success;
    }
 }
 
 //#endregion


 //#region validations over questionnaire
 /**
 * @description  This method is in charge to check the integrity of the reference data, idquestionnaire, idquestions and answers. Moreover in case of a free answer 
 * @returns {TaskRecordingStatusses}
 */
private async  validateQuestionnaireData( patientAnswersRequest: SaveAnswersRequest, retrievedTask: GetTaskResponse): Promise<SaveAnswersStatus> {
     
   let validateQuestionnaireAnswerDataResult:SaveAnswersStatus = undefined;

   if ( !(patientAnswersRequest.executedTask.filledQuestionnaire) || !(patientAnswersRequest.executedTask.filledQuestionnaire.idQuestionnaire)) {
       return SaveAnswersStatus.IncompleteQuestionnaireId;
   }

   // 
   if (!retrievedTask.questionnaire) {
       return SaveAnswersStatus.QuestionnaireIdNotFound;
   }else{
      const questionsMap: Map<string,Question> = await this.getQuestionsMap(retrievedTask.questionnaire);
      validateQuestionnaireAnswerDataResult = await this.validateAnswersData(patientAnswersRequest.executedTask.filledQuestionnaire,questionsMap);
   }

   return validateQuestionnaireAnswerDataResult;
}


private async getQuestionsMap(questionnaire: Questionnaire):Promise<Map<string,Question>>{
   let questionsMap : Map<string,Question> = new Map<string,Question>();

   if(questionnaire.questions && questionnaire.questions.length > 0){
        for(const question of questionnaire.questions){
            questionsMap.set(question.questionId,question);
        }

   }
   return questionsMap;
}



private async  validateAnswersData(filledQuestionnaire: FilledQuestionnaire, revoceredQuestionsMap: Map<string,Question>): Promise<SaveAnswersStatus> {
   let validateAnswersDataResult = false;
   
   const originalFilledQuestionList: RequestAnswer[] =  (filledQuestionnaire.answersList && filledQuestionnaire.answersList.length > 0) ? filledQuestionnaire.answersList :[];

   // Validate mandatory answers: Check that at least there is one answer per question on the requested questionnaire.

   // condition checks that the retrieved map has values and the provided answers also have values.
   if (revoceredQuestionsMap && revoceredQuestionsMap.size > 0 &&
       filledQuestionnaire.answersList && filledQuestionnaire.answersList.length > 0) {
       for (const filledAnswer of filledQuestionnaire.answersList) {

              const currentQuestion: Question =  revoceredQuestionsMap.get( String(filledAnswer.idQuestion) );
               if (!currentQuestion) {
                     Logger.error("Error retrieving question for provided questionId:" + filledAnswer.idQuestion)
                     return SaveAnswersStatus.QuestionIdNotFound;
               }
               switch (currentQuestion.questionType) {
                     case QuestionType.freeAnswer:
                        validateAnswersDataResult = await this.validateMandatoryFreeAnswerValue(filledAnswer);
                        break;
                     case QuestionType.selectOneAnswer:            
                        validateAnswersDataResult = await this.validateSelectOneAnswer(filledAnswer, originalFilledQuestionList,revoceredQuestionsMap);
                        break;
                     case QuestionType.selectMultipleAnswer:
                        validateAnswersDataResult = await this.validateQuestionAnswerRelationship(filledAnswer, revoceredQuestionsMap);
                        break;
               }
               
               if (!validateAnswersDataResult) {
                     return SaveAnswersStatus.IncompleteQuestionnaireAnswers;
               }
       } 
       return SaveAnswersStatus.Success;
   } 
}


/**
* This function ensures that the provided answeredItem. That it's the only related answer for the provided question.
*/
private async  validateSelectOneAnswer(patientAnswer: RequestAnswer, patientAnswersList: RequestAnswer[], revoceredQuestionsMap: Map<string,Question>): Promise<boolean> {
   let validationResult:boolean = false;
   
   validationResult = await this.validateQuestionAnswerRelationship(patientAnswer, revoceredQuestionsMap);

   if(validationResult == true){

      validationResult = patientAnswersList.filter(entry => entry.idQuestion == patientAnswer.idQuestion).length == 1 ? true : false;
   }
   return validationResult;
}




/**
* This function ensures that the provided answeredItem.IdAnswer is related to the right question on database, and at the same time exists one answer with the valide answerId.
*/
private async  validateQuestionAnswerRelationship(patientAnswer: RequestAnswer, revoceredQuestionsMap: Map<string,Question>): Promise<boolean> {
   
   let validationResult:boolean = false;
   const relatedQuestion:Question = revoceredQuestionsMap.get(String(patientAnswer.idQuestion) ) 
   if(relatedQuestion){
       validationResult = relatedQuestion.answers.some( entry => entry.answerId == patientAnswer.idAnswer);
   }


   return validationResult;
   
}

async  validateMandatoryFreeAnswerValue(patientAnswer: RequestAnswer): Promise<boolean> {
 const validationResult = patientAnswer.freeAnswerValue !== null;
 return validationResult;
}
 //#endregion validations over questionnaire


//#region database methods

 async  insertPatientTaskQuestionnaireEntry(patientActivityData: PatientActivityEntry): Promise<string> {
   let connection: any;
   try {
           connection = await dao.getConnection();
           connection.beginTransaction();
 
 
           const sql = "INSERT INTO patient_activity_entry (entry_datetime, id_patient, id_task) VALUES(UTC_TIMESTAMP(), @p2, @p3);";
           const sqlWithValues = sql
             .replace("@p2", patientActivityData.idPatient)
             .replace("@p3", patientActivityData.idTask);
           const result1 = await connection.execute(sqlWithValues);
           const insertIdPatientActivityData = result1.insertId;
 

          if(patientActivityData.idParentPatientActivityEntry){
            const sqlRelatedPatientActivityEntry = "INSERT INTO related_patient_activity_entries (parent_patient_activity_entry, patient_activity_entry)  VALUES(@parent_patient_activity_entry, @patient_activity_entry)";
            const sqlRelatedPatientActivityEntryWithValues = sqlRelatedPatientActivityEntry.replace("@parent_patient_activity_entry", patientActivityData.idParentPatientActivityEntry)
                                                                                           .replace("@patient_activity_entry", insertIdPatientActivityData);
            await connection.execute(sqlRelatedPatientActivityEntryWithValues);
          }

          

           const sqlQuestionnaireExecution = "INSERT INTO questionnaire_execution (id_questionnaire, id_patient_activy_entry) VALUES(@id_questionnaire, @id_patient_activy_entry)";
           const sqlQuestionnaireExecutionWithValues = sqlQuestionnaireExecution
             .replace("@id_questionnaire", patientActivityData.questionnaireExecution.idQuestionnaire)
             .replace("@id_patient_activy_entry", insertIdPatientActivityData);
           const resultQuestionnaireExecution = await connection.execute(sqlQuestionnaireExecutionWithValues);
           const insertIdQuestionnaireExecution = resultQuestionnaireExecution.insertId;
 
 
 
           const sqlQuestionnaireExecutionAnswer = "INSERT INTO questionnaire_execution_answer (id_question, free_answer_value ,id_answer, id_questionnaire_execution) VALUES";
           let valueParamList = "";
           for (const questionnaireExecutionAnswer of patientActivityData.questionnaireExecution.questionnaireExecutionAnswersList) {
             const valueTuple = "(id_question, free_answer_value, id_answer, id_questionnaire_execution)";
 
             const paramIdquestion = questionnaireExecutionAnswer.idQuestion;
             const paramIdAnswer = questionnaireExecutionAnswer.idAnswer ?  questionnaireExecutionAnswer.idAnswer: "NULL";
             const paramFreeAnswerValue = questionnaireExecutionAnswer.freeAnswerValue ?  "'"+questionnaireExecutionAnswer.freeAnswerValue+"'": "NULL";
             const paramIdQuestionnaireExecution = insertIdQuestionnaireExecution;
 
             const valueTupleReplaced = valueTuple
               .replace("id_question", paramIdquestion)
               .replace("id_answer", paramIdAnswer)
               .replace("free_answer_value", String(paramFreeAnswerValue))
               .replace("id_questionnaire_execution", paramIdQuestionnaireExecution);
             valueParamList = valueParamList + valueTupleReplaced + ",";
           }
           valueParamList = valueParamList.substring(0, valueParamList.length - 1);
           let sqlQuestionnaireExecutionAnswerWithValues = sqlQuestionnaireExecutionAnswer + valueParamList;
           await connection.execute(sqlQuestionnaireExecutionAnswerWithValues);

           await connection.commit();
 
           return insertIdPatientActivityData.toString();
   } catch (err) {
     Logger.error("Error saving answers" + err);
     if (connection) {
       await connection.rollback();
     }
     return "-1";
   } finally {

     await connection.end();
   }
 }


 async  insertPatientTaskScheduledQuestionnaireEntry(patientActivityData: PatientActivityEntry,scheduledTaskId:string): Promise<string> {
   let connection: any;
   try {
           connection = await dao.getConnection();
           connection.beginTransaction();
 
 
           const sql = "INSERT INTO patient_activity_entry (entry_datetime, id_patient, id_task) VALUES(UTC_TIMESTAMP(), @p2, @p3);";
           const sqlWithValues = sql
             .replace("@p2", patientActivityData.idPatient)
             .replace("@p3", patientActivityData.idTask);
           const result1 = await connection.execute(sqlWithValues);
           const insertIdPatientActivityData = result1.insertId;

           if(patientActivityData.idParentPatientActivityEntry){
            const sqlRelatedPatientActivityEntry = "INSERT INTO related_patient_activity_entries (parent_patient_activity_entry, patient_activity_entry)  VALUES(@parent_patient_activity_entry, @patient_activity_entry)";
            const sqlRelatedPatientActivityEntryWithValues = sqlRelatedPatientActivityEntry.replace("@parent_patient_activity_entry", patientActivityData.idParentPatientActivityEntry)
                                                                                           .replace("@patient_activity_entry", insertIdPatientActivityData);
            await connection.execute(sqlRelatedPatientActivityEntryWithValues);
          }
 
           const sqlUpdatePatientScheduledTask = "UPDATE patient_scheduled_task  SET id_patient_activity_entry = @activityEntryId  where id = @scheduledId;";
           const sqlWithValues2 = sqlUpdatePatientScheduledTask
             .replace("@activityEntryId", insertIdPatientActivityData)
             .replace("@scheduledId", scheduledTaskId);
           await connection.execute(sqlWithValues2);
 
           const sqlQuestionnaireExecution = "INSERT INTO questionnaire_execution (id_questionnaire, id_patient_activy_entry) VALUES(@id_questionnaire, @id_patient_activy_entry)";
           const sqlQuestionnaireExecutionWithValues = sqlQuestionnaireExecution
             .replace("@id_questionnaire", patientActivityData.questionnaireExecution.idQuestionnaire)
             .replace("@id_patient_activy_entry", insertIdPatientActivityData);
           const resultQuestionnaireExecution = await connection.execute(sqlQuestionnaireExecutionWithValues);
           const insertIdQuestionnaireExecution = resultQuestionnaireExecution.insertId;
 
 
 
           const sqlQuestionnaireExecutionAnswer = "INSERT INTO questionnaire_execution_answer (id_question, free_answer_value ,id_answer, id_questionnaire_execution) VALUES";
           let valueParamList = "";
           for (const questionnaireExecutionAnswer of patientActivityData.questionnaireExecution.questionnaireExecutionAnswersList) {
             const valueTuple = "(id_question, free_answer_value, id_answer, id_questionnaire_execution)";
 
             const paramIdquestion = questionnaireExecutionAnswer.idQuestion;
             const paramIdAnswer = questionnaireExecutionAnswer.idAnswer ?  questionnaireExecutionAnswer.idAnswer: "NULL";
             const paramFreeAnswerValue = questionnaireExecutionAnswer.freeAnswerValue ?  "'"+questionnaireExecutionAnswer.freeAnswerValue+"'": "NULL";
             const paramIdQuestionnaireExecution = insertIdQuestionnaireExecution;
 
             const valueTupleReplaced = valueTuple
               .replace("id_question", paramIdquestion)
               .replace("id_answer", paramIdAnswer)
               .replace("free_answer_value", String(paramFreeAnswerValue))
               .replace("id_questionnaire_execution", paramIdQuestionnaireExecution);
             valueParamList = valueParamList + valueTupleReplaced + ",";
           }
           valueParamList = valueParamList.substring(0, valueParamList.length - 1);
           let sqlQuestionnaireExecutionAnswerWithValues = sqlQuestionnaireExecutionAnswer + valueParamList;
           await connection.execute(sqlQuestionnaireExecutionAnswerWithValues);

           await connection.commit();
 
           return insertIdPatientActivityData.toString();
   } catch (err) {
     Logger.error("Error saving answers" + err);
     if (connection) {
       await connection.rollback();
     }
     return "-1";
   } finally {

     await connection.end();
   }
 }



 async  insertPatientTaskExecutionEntry(patientActivityData: PatientActivityEntry,scheduledId:string): Promise<string> {
   let connection: any;
   try {
           connection = await dao.getConnection();
           connection.beginTransaction();
 
 
           const sqlPatientActivityEntry = "INSERT INTO patient_activity_entry (entry_datetime, id_patient, id_task) VALUES(UTC_TIMESTAMP(), @p2, @p3);";
           const sqlWithValues = sqlPatientActivityEntry
             .replace("@p2", patientActivityData.idPatient)
             .replace("@p3", patientActivityData.idTask);
           const result = await connection.execute(sqlWithValues);
           const insertIdPatientActivityEntry = result.insertId;


           if(patientActivityData.idParentPatientActivityEntry){
            const sqlRelatedPatientActivityEntry = "INSERT INTO related_patient_activity_entries (parent_patient_activity_entry, patient_activity_entry)  VALUES(@parent_patient_activity_entry, @patient_activity_entry)";
            const sqlRelatedPatientActivityEntryWithValues = sqlRelatedPatientActivityEntry.replace("@parent_patient_activity_entry", patientActivityData.idParentPatientActivityEntry)
                                                                                           .replace("@patient_activity_entry", insertIdPatientActivityEntry);
            await connection.execute(sqlRelatedPatientActivityEntryWithValues);
          }


           const sqlUpdatePatientScheduledTask = "UPDATE patient_scheduled_task  SET id_patient_activity_entry = @activityEntryId  where id = @scheduledId;";
           const sqlWithValues2 = sqlUpdatePatientScheduledTask
             .replace("@activityEntryId", insertIdPatientActivityEntry)
             .replace("@scheduledId", scheduledId);
           await connection.execute(sqlWithValues2);
           
           await connection.commit();
 
           return insertIdPatientActivityEntry.toString();
   } catch (err) {
     Logger.error("Error saving confirmation of the execution:" + err);
     if (connection) {
       await connection.rollback();
     }
     return "-1";
   } finally {
     // Close database connection;
     await connection.end();
   }
 }


 //#endregion database methods


}





 