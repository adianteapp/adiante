import { GetScheduledTaskByIdRequest } from "./dto/get-scheduled-task-by-id.request";
import { GetScheduledTaskByIdResponse } from "./dto/get-scheduled-task-by-id.response";

import { IGetScheduledTaskByIdHandler } from "./i-get-scheduled-task-by-id.handler";
import { GetScheduledTaskByIdStatus} from "./get-scheduled-task-by-id.enum";
import { inject,injectable } from "inversify";
import dao from "../../../middleware/dao";
import * as dotenv from 'dotenv';



@injectable()
export class GetScheduledTaskByIdHandler implements IGetScheduledTaskByIdHandler{
    dao: any;



    constructor(){
        dotenv.config();
      }



    public async execute( getScheduledTaskRequest: GetScheduledTaskByIdRequest):Promise<GetScheduledTaskByIdResponse>{
          
        let response : GetScheduledTaskByIdResponse = await this.getscheduledTaskByIDFromDB(getScheduledTaskRequest.scheduledId);
          
        if(response && response.scheduledId != undefined){
            response.status = GetScheduledTaskByIdStatus.Succesfull;
        }
        else{
            response = { status: GetScheduledTaskByIdStatus.ScheduledIdNotFound } as GetScheduledTaskByIdResponse;
        }
        
        return response;
    }



async  getscheduledTaskByIDFromDB(scheduledId: string): Promise<GetScheduledTaskByIdResponse> {

    let retrievedScheduledTask : GetScheduledTaskByIdResponse = undefined;


    const sqlQuery =`SELECT pst.id  AS 'scheduledId',
                      CONVERT_TZ(pst.start_datetime, '+00:00', @@session.time_zone) AS 'startDateTimeLocal',
                      CONVERT_TZ(pst.end_datetime, '+00:00', @@session.time_zone) AS 'endDateTimeLocal',
                      id_task AS 'taskId',
                      id_patient_activity_entry AS 'activityEntryId',
                      id_patient AS 'patientId'
                    FROM patient_scheduled_task pst
                    WHERE pst.id = '${scheduledId}'`;
  
    const rows = await dao.executeQuery(sqlQuery);
    
    if(rows && rows.length > 0){

        const scheduledTaskList: GetScheduledTaskByIdResponse []  = JSON.parse(JSON.stringify(rows, (_, value) => typeof value === 'bigint' ? value.toString() : value)) as GetScheduledTaskByIdResponse[];
        retrievedScheduledTask = scheduledTaskList[0];
    }

    return retrievedScheduledTask;
  }
  


//#endregion



}