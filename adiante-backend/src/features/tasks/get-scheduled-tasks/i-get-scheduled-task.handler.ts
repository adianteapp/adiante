import { GetScheduledTasksRequest } from "./dto/get-scheduled-task.request";
import { GetScheduledTasksResponse } from "./dto/get-scheduled-task.response"

export interface IGetScheduledTaskHandler{

    execute( scheduledTaskRequest: GetScheduledTasksRequest):Promise<GetScheduledTasksResponse>; 
}