import { GetScheduledTasksRequest } from "./dto/get-scheduled-task.request";
import { GetScheduledTasksResponse } from "./dto/get-scheduled-task.response";
import { ScheduledTask } from "./dto/get-scheduled-task.response";
import { IGetScheduledTaskHandler } from "./i-get-scheduled-task.handler";
import { GetScheduledTasksStatus } from "./get-scheduled-task.enum";
import { inject,injectable } from "inversify";
import dao from "../../../middleware/dao";
import * as dotenv from 'dotenv';
import { IGetPatientHandler } from "../../../features/shared/get-patient/i-get-patient.handler";
import { GetPatientResponse } from "../../../features/shared/get-patient/dto/get-patient.response";
import { GetPatientRequest } from "../../../features/shared/get-patient/dto/get-patient.request";


@injectable()
export class GetScheduledTaskHandler implements IGetScheduledTaskHandler{

    @inject("IGetPatientHandler")private readonly getPatientHandler: IGetPatientHandler;


    constructor(){
        dotenv.config();
      }



    public async execute( getScheduledTaskRequest: GetScheduledTasksRequest):Promise<GetScheduledTasksResponse>{
          
        let scheduledTaskList : GetScheduledTasksResponse = {tasksList:[]} as GetScheduledTasksResponse;
          
        let validationResult = GetScheduledTasksStatus.Succesfull;
        validationResult = await this.validateRequest(getScheduledTaskRequest);

        if(validationResult !=  GetScheduledTasksStatus.Succesfull){

            scheduledTaskList.status = validationResult;

        }else{

            const selectedDate:Date = new Date(getScheduledTaskRequest.selectedDate);

            const {startUtcTime , endUtcTime } = this.getDateTimeInterval(selectedDate);

            let response:GetScheduledTasksResponse= await this.getscheduledTasksFromDB(getScheduledTaskRequest.patientId,startUtcTime,endUtcTime);
            response.status = GetScheduledTasksStatus.Succesfull;            
            
            return response;
        }



         



          return scheduledTaskList;
    }

//#region validations 
private async validateRequest(scheduledTaskRequest: GetScheduledTasksRequest): Promise<GetScheduledTasksStatus>{
    let validationResult = GetScheduledTasksStatus.Succesfull;

    validationResult = await this.validatePatientId(scheduledTaskRequest);
    if(validationResult !=  GetScheduledTasksStatus.Succesfull){
        return validationResult;
    }

    validationResult = await this.validateSelectedDate(scheduledTaskRequest);
    if(validationResult !=  GetScheduledTasksStatus.Succesfull){
        return validationResult;
    }

    return validationResult;
}

private async validateSelectedDate(scheduledTaskRequest: GetScheduledTasksRequest): Promise<GetScheduledTasksStatus>{
    let validationResult = GetScheduledTasksStatus.Succesfull;

    if(scheduledTaskRequest.selectedDate == undefined){
        validationResult = GetScheduledTasksStatus.MissedSelectedDate;
     }
    return validationResult;
}



private async validatePatientId(scheduledTaskRequest: GetScheduledTasksRequest): Promise<GetScheduledTasksStatus>{
    let validationResult = GetScheduledTasksStatus.Succesfull;

    if(scheduledTaskRequest.patientId == undefined){
        validationResult = GetScheduledTasksStatus.MissedPatientId;
    }else{
        const patientValidation: boolean = await this.isPatientIdValid(scheduledTaskRequest.patientId)
        if( !patientValidation ){
    
            validationResult = GetScheduledTasksStatus.PatientIdNotFound;
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

private getDateTimeInterval(selectedDate:Date){
    if(selectedDate){
          
        selectedDate.setUTCHours(0, 0, 0, 0);
        const selectedDateStartTime: string = this.formatDate(selectedDate) ;
        
        const selectedDateEnd = new Date(selectedDate);
        selectedDateEnd.setUTCHours(23, 59, 59, 999);
        const selectedDateEndTime: string = this.formatDate(selectedDateEnd) ;

        return {startUtcTime: selectedDateStartTime,endUtcTime:selectedDateEndTime};
    }else{
        return;
    }
}

private  formatDate(date: Date): string {
    const year = date.getUTCFullYear();
    const month = (date.getUTCMonth() + 1).toString().padStart(2, "0");
    const day = date.getUTCDate().toString().padStart(2, "0");
    const hours = date.getUTCHours().toString().padStart(2, "0");
    const minutes = date.getUTCMinutes().toString().padStart(2, "0");
    const seconds = date.getUTCSeconds().toString().padStart(2, "0");
    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}


//#region database methods

async  getscheduledTasksFromDB(patientId: string , startDate: string ,endDate:string,langId?:string): Promise<GetScheduledTasksResponse> {

    let retrievedScheduledTaskList : GetScheduledTasksResponse = {tasksList:[]} as GetScheduledTasksResponse;
    let tasksList: ScheduledTask[] = [];

    const languageId:string = langId != undefined ? langId : process.env.DEAFULT_LANGID;

    const sqlQuery =`SELECT pst.id  AS 'scheduledId',t.id as 'taskId', tt.code_name AS 'taskTypeCode', tin.title_i18n AS 'title', tin.description_i18n AS 'description',
                      CONVERT_TZ(pst.start_datetime, '+00:00', @@session.time_zone) AS 'startDateTimeLocal',
                      CONVERT_TZ(pst.end_datetime, '+00:00', @@session.time_zone) AS 'endDateTimeLocal',
                      CONVERT_TZ(pae.entry_datetime , '+00:00', @@session.time_zone) AS 'executionDateTimeLocal',
                      tq.id_questionnaire as 'relatedQuestionnaireId'
                    FROM patient_scheduled_task pst
                    INNER JOIN task t ON pst.id_task = t.id
                    INNER JOIN task_type AS tt ON t.id_task_type = tt.id
                    INNER JOIN task_i18n tin ON t.id = tin.id_task
                    LEFT OUTER JOIN  patient_activity_entry pae ON pst.id_patient_activity_entry = pae.id 
                    LEFT OUTER JOIN  task_questionnaire tq on tq.id_task = t.id
                    WHERE pst.id_patient = '${patientId}'
                    AND pst.start_datetime >= '${startDate}'
                    AND pst.end_datetime <  '${endDate}'
                    AND tin.id_language= '${languageId}'
                    ORDER BY 
					    CASE WHEN executionDateTimeLocal IS NULL THEN 0 ELSE 1 END,
					    pst.start_datetime ASC;`;
  
    const rows = await dao.executeQuery(sqlQuery);
    
    if(rows && rows.length > 0){

        tasksList = JSON.parse(JSON.stringify(rows, (_, value) => typeof value === 'bigint' ? value.toString() : value)) as ScheduledTask[];
        retrievedScheduledTaskList.tasksList = tasksList;

    }

    return retrievedScheduledTaskList;
  }
  


//#endregion



}