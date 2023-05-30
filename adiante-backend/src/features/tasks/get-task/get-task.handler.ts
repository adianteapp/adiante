import { injectable, inject } from "inversify";
import { GetTaskRequest } from "./dto/get-task.request";
import { GetTaskResponse, Task } from "./dto/get-task.response";
import { IGetTaskHandler } from "./i-get-task.handler";
import { GetTaskStatus } from "./get-task.enum";
import * as dotenv from 'dotenv';
import { IGetPatientHandler } from "../../../features/shared/get-patient/i-get-patient.handler";
import { GetPatientResponse } from "../../../features/shared/get-patient/dto/get-patient.response";
import { GetPatientRequest } from "../../../features/shared/get-patient/dto/get-patient.request";
import dao from "../../../middleware/dao";
import Logger from '../../../config/logger';

@injectable()
export class GetTaskHandler implements IGetTaskHandler {

  @inject("IGetPatientHandler") private readonly getPatientHandler: IGetPatientHandler;

  constructor(){
    dotenv.config();
  }

  async execute(getTaskRequest: GetTaskRequest): Promise<GetTaskResponse> {

    let getTaskResponse: GetTaskResponse = {} as GetTaskResponse;
    let task:Task = undefined;
    const validationRequestResult: GetTaskStatus = await this.validateRequest(getTaskRequest);

    if (validationRequestResult != GetTaskStatus.Succesfull) {

      return getTaskResponse = { status: validationRequestResult } as GetTaskResponse;

    } else {
       
      task =  await this.getTaskByIdFromDB(getTaskRequest.taskId);
      getTaskResponse = {task:task,status:GetTaskStatus.Succesfull} as GetTaskResponse;

    }

    return getTaskResponse;
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

private async getTaskByIdFromDB(taskId:string,langId?:string):Promise<Task>{
  let retrievedTask: Task = undefined

  const languageId:string = langId != undefined ? langId : process.env.DEAFULT_LANGID


  const sqlQuery =`SELECT t.id AS 'taskId',
  tt.code_name AS 'taskTypeId',
  tin.title_i18n AS 'title',
  tin.description_i18n AS 'description',
  t.mandatory_feedback AS 'mandatoryFeedback',
  tq.id_questionnaire AS 'relatedQuestionnaireId'
FROM task AS t
INNER JOIN task_type AS tt ON t.id_task_type = tt.id
INNER JOIN task_i18n AS tin ON t.id = tin.id_task
LEFT JOIN task_questionnaire AS tq ON tq.id_task = t.id
WHERE t.id = '${taskId}' AND tin.id_language = '${languageId}'`;

    const rows = await dao.executeQuery(sqlQuery);
    
    if(rows && rows.length > 0){

        const taskList = JSON.parse(JSON.stringify(rows, (_, value) => typeof value === 'bigint' ? value.toString() : value)) as Task[];
        
        if(taskList && taskList.length == 1){

          retrievedTask = taskList[0]

        }else{

          if(rows.length > 1){
            Logger.error("TaskId:"+taskId+" gives more than 1 result");
          }
        }
    }
  return retrievedTask;
}

//#endregion queries to database



}






