import { injectable, inject } from "inversify";
import { GetTaskRequest } from "./dto/get-task.request";
import { GetTaskResponse, Task, TaskAttribute } from "./dto/get-task.response";
import { IGetTaskHandler } from "./i-get-task.handler";
import { GetTaskStatus } from "./get-task.enum";
import * as dotenv from 'dotenv';
import { IGetPatientHandler } from "../../../features/shared/get-patient/i-get-patient.handler";
import { GetPatientResponse } from "../../../features/shared/get-patient/dto/get-patient.response";
import { GetPatientRequest } from "../../../features/shared/get-patient/dto/get-patient.request";
import dao from "../../../middleware/dao";
import Logger from '../../../config/logger';
import { IGetQuestionnaireHandler } from "../get-questionnaire/i-get-questionnaire.handler";
import { GetQuestionnaireResponse, Question, Questionnaire } from "../get-questionnaire/dto/get-questionnaire.response";
import { GetQuestionnaireRequest } from "../get-questionnaire/dto/get-questionnaire.request";


@injectable()
export class GetTaskHandler implements IGetTaskHandler {

  @inject("IGetPatientHandler") private readonly getPatientHandler: IGetPatientHandler;
  @inject("IGetQuestionnaireHandler") private readonly getQuestionnaireHandler: IGetQuestionnaireHandler;
    
  constructor(){
    dotenv.config();
  }

  async execute(getTaskRequest: GetTaskRequest): Promise<GetTaskResponse> {

    let getTaskResponse: GetTaskResponse = {} as GetTaskResponse;
    let retrievedTask:Task = undefined;
  let  questionnaire: Questionnaire = undefined;
    const validationRequestResult: GetTaskStatus = await this.validateRequest(getTaskRequest);

    if (validationRequestResult != GetTaskStatus.Succesfull) {

      return getTaskResponse = { status: validationRequestResult } as GetTaskResponse;

    } else {
       
      retrievedTask =  await this.getTaskByIdFromDB(getTaskRequest.taskId);
      if(retrievedTask != undefined && retrievedTask.relatedQuestionnaireId != undefined){
         
        const relatedQuestionnaire:GetQuestionnaireResponse = await this.getRelatedQuestionnaire(retrievedTask);
        questionnaire = relatedQuestionnaire && relatedQuestionnaire.questionnaire ? relatedQuestionnaire.questionnaire : null;
      }
      getTaskResponse = {task:retrievedTask,questionnaire:questionnaire,status:GetTaskStatus.Succesfull} as GetTaskResponse;

    }

    return getTaskResponse;
  }


  private async getRelatedQuestionnaire(retrievedTask: Task):Promise<GetQuestionnaireResponse>{

    let getQuestionnaireRequest: GetQuestionnaireRequest = {taskId:retrievedTask.taskId,relatedQuestionnaireId:retrievedTask.relatedQuestionnaireId} as GetQuestionnaireRequest
    const relatedQuestionnaire: GetQuestionnaireResponse = await this.getQuestionnaireHandler.execute(getQuestionnaireRequest);
    if(! relatedQuestionnaire.questionnaire){
        Logger.error("Error no questionnaire retrived from database");
    }

    return relatedQuestionnaire;
  }



  //#region validations 
  private async validateRequest(getTaskRequest: GetTaskRequest): Promise<GetTaskStatus> {
    let validationResult = GetTaskStatus.Succesfull;

    validationResult = await this.validatePatientId(getTaskRequest);
    if (validationResult != GetTaskStatus.Succesfull) {
      return validationResult;
    }

    validationResult = await this.validateCriteria(getTaskRequest);
    if (validationResult != GetTaskStatus.Succesfull) {
      return validationResult;
    }

    return validationResult;
  }

  private async validateCriteria(getTaskRequest: GetTaskRequest): Promise<GetTaskStatus> {
    let validationResult = GetTaskStatus.Succesfull;

    if (getTaskRequest.taskId == undefined) {
      validationResult = GetTaskStatus.MissedCriteria;
    }
    return validationResult;
  }



  private async validatePatientId(getTaskRequest: GetTaskRequest): Promise<GetTaskStatus> {
    let validationResult = GetTaskStatus.Succesfull;

    if (getTaskRequest.patientId == undefined) {
      validationResult = GetTaskStatus.MissedPatientId;
    } else {
      const patientValidation: boolean = await this.isPatientIdValid(getTaskRequest.patientId)
      if (!patientValidation) {

        validationResult = GetTaskStatus.PatientIdNotFound;
      }
    }
    return validationResult;
  }


  private async isPatientIdValid(patientId: string): Promise<boolean> {
    let isPatientIdValid: boolean = false;

    const patientRequest: GetPatientRequest = { patientId: patientId } as GetPatientRequest;
    const patient: GetPatientResponse = await this.getPatientHandler.getPatientByCriteria(patientRequest);

    if (patient != undefined) {
      isPatientIdValid = true;
    }

    return isPatientIdValid
  }


  //#endregion validations 


//#region queries to database

  private async getTaskByIdFromDB(taskId: string, langId?: string): Promise<Task> {
        let retrievedTask: Task = undefined

        const languageId: string = langId != undefined ? langId : process.env.DEAFULT_LANGID


        const sqlQuery = `SELECT t.id AS 'taskId',
                              tt.code_name AS 'taskTypeCode',
                              tin.title_i18n AS 'title',
                              tin.description_i18n AS 'description',
                              tin.additional_info_i18n AS 'additionalInfo',
                              t.mandatory_feedback AS 'mandatoryFeedback',
                              tav.id_task as 'attributeTaskId',
                              ta.code_name as 'attributeCode',tav.value  as 'attributeValue',
                              tq.id_questionnaire AS 'relatedQuestionnaireId'
                            FROM task AS t
                            INNER JOIN task_type AS tt ON t.id_task_type = tt.id
                            INNER JOIN task_i18n AS tin ON t.id = tin.id_task
                            LEFT OUTER JOIN task_attribute_value tav on tav.id_task = t.id
                            LEFT OUTER JOIN task_attribute ta on ta.id = tav.id_task_attribute
                            LEFT JOIN task_questionnaire AS tq ON tq.id_task = t.id
                            WHERE t.id = '${taskId}' AND tin.id_language = '${languageId}'`;

        const rows = await dao.executeQuery(sqlQuery);

        if (rows && rows.length > 0) {

          retrievedTask = await this.mapToTask(rows);

        } else {

          Logger.error("TaskId:" + taskId + " gives more than 1 result");

        }
        return retrievedTask;
  }


private async  mapToTask(queryResult: any[]): Promise<Task> {


  let currentAttribute: TaskAttribute | undefined;
  let currentTask: Task | undefined;

  queryResult.forEach((row) => {

    if (!currentTask || currentTask.taskId  !== row.taskId.toString()) {
      currentTask = {
        taskId : row.taskId.toString(),
        title : row.title,
        description : row.description,
        taskTypeCode : row.taskTypeCode,
        additionalInfo : row.additionalInfo,
        relatedQuestionnaireId : row.relatedQuestionnaireId.toString(),
        taskAttributeList : []
      } as Task;

    }

    if (row.attributeCode != undefined && row.attributeTaskId.toString() == currentTask.taskId.toString()) {

      currentAttribute = {
          attributeValue : row.attributeValue,
          attributeCode : row.attributeCode,
      } as TaskAttribute;
      
      currentTask.taskAttributeList.push(currentAttribute);
    }
  });

  return currentTask;
}




//#endregion queries to database



}






