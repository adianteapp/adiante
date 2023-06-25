import { GetTasksByTypeRequest } from "./dto/get-tasks-by-type.request";
import { GetTasksByTypeResponse } from "./dto/get-tasks-by-type.response";
import {  IGetTasksByTypeHandler } from "./i-get-task-by-type.handler";
import { GetTasksByTypeStatus } from "./get-tasks-by-type.enum";
import TaskType from "../../shared/enums/task-type.enum";
import { inject,injectable } from "inversify";
import dao from "../../../middleware/dao";
import * as dotenv from 'dotenv';
import { IGetPatientHandler } from "../../shared/get-patient/i-get-patient.handler";
import { GetPatientResponse } from "../../shared/get-patient/dto/get-patient.response";
import { GetPatientRequest } from "../../shared/get-patient/dto/get-patient.request";
import { Task } from "../../../features/shared/get-task/dto/get-task.response";


@injectable()
export class GetTasksByTypeHandler implements IGetTasksByTypeHandler{

    @inject("IGetPatientHandler")private readonly getPatientHandler: IGetPatientHandler;


    constructor(){
        dotenv.config();
      }



    public async execute( getTasksByTypeRequest: GetTasksByTypeRequest):Promise<GetTasksByTypeResponse>{
          
        let getTasksByTypeReponse : GetTasksByTypeResponse = {tasksList:[]} as GetTasksByTypeResponse;
          
        let validationResult = GetTasksByTypeStatus.Succesfull;
        validationResult = await this.validateRequest(getTasksByTypeRequest);

        if(validationResult !=  GetTasksByTypeStatus.Succesfull){

            getTasksByTypeReponse.status = validationResult;

        }else{

            let taskList:Task[]= await this.getsTasksByTypeFromDB(getTasksByTypeRequest.taskType);

            getTasksByTypeReponse.status = GetTasksByTypeStatus.Succesfull;
            getTasksByTypeReponse.tasksList = taskList;     
        }
        return getTasksByTypeReponse;
    }

//#region validations 

private async validateRequest(getTasksByTypeRequest: GetTasksByTypeRequest): Promise<GetTasksByTypeStatus>{
    let validationResult = GetTasksByTypeStatus.Succesfull;

    validationResult = await this.validatePatientId(getTasksByTypeRequest);
    if(validationResult != GetTasksByTypeStatus.Succesfull){
        return validationResult
    }

    validationResult = await this.isValidTaskType(getTasksByTypeRequest.taskType);
    return validationResult;
}

private async isValidTaskType(selectedTaskType: string): Promise<GetTasksByTypeStatus> {
    const validTaskTypes = [TaskType.challenge,TaskType.guidedActivity];
    let validationTaskTypeResult: GetTasksByTypeStatus;
    validationTaskTypeResult = selectedTaskType && validTaskTypes.includes(selectedTaskType as TaskType) ? GetTasksByTypeStatus.Succesfull: GetTasksByTypeStatus.InvalidTaskType;

    return validationTaskTypeResult;
  }

private async validatePatientId(getTasksByTypeRequest: GetTasksByTypeRequest): Promise<GetTasksByTypeStatus>{
    let validationResult = GetTasksByTypeStatus.Succesfull;

    if(getTasksByTypeRequest.patientId == undefined){
        validationResult = GetTasksByTypeStatus.MissedPatientId;
    }else{
        const patientValidation: boolean = await this.isPatientIdValid(getTasksByTypeRequest.patientId)
        if( !patientValidation ){
    
            validationResult = GetTasksByTypeStatus.PatientIdNotFound;
        }
    }
    return validationResult;
}

private async isPatientIdValid(patientId:string):Promise<boolean>{
   let isPatientIdValid:boolean = false;
 
   const patientRequest: GetPatientRequest = {patientId:patientId} as GetPatientRequest;
   const patient:GetPatientResponse = await this.getPatientHandler.getPatientByCriteria(patientRequest);

   if(patient != undefined){
     isPatientIdValid = true;
   }

   return isPatientIdValid
}

//#endregion validations 


//#region database methods

async  getsTasksByTypeFromDB(selectedTaskType:string,langId?:string): Promise<Task[]> {

    let retrievedTaskList : Task[] = [];


    const languageId:string = langId != undefined ? langId : process.env.DEAFULT_LANGID;

    const sqlQuery =`SELECT t.id AS 'taskId', tin.title_i18n AS 'taskTitle', tin.description_i18n AS 'taskDescription'
                    FROM  task t 
                    INNER JOIN task_type tt ON t.id_task_type = tt.id
                    INNER JOIN task_i18n tin ON t.id = tin.id_task
                    WHERE tt.code_name = '${selectedTaskType}' AND tin.id_language= '${languageId}'`;
  
    const rows = await dao.executeQuery(sqlQuery);
    
    if(rows && rows.length > 0){

        retrievedTaskList = JSON.parse(JSON.stringify(rows, (_, value) => typeof value === 'bigint' ? value.toString() : value)) as  Task[];
    }

    return retrievedTaskList;
  }
  


//#endregion



}