import { GetScheduledTaskByIdRequest } from "./dto/get-scheduled-task-by-id.request"
import { GetScheduledTaskByIdResponse } from "./dto/get-scheduled-task-by-id.response"

export interface IGetScheduledTaskByIdHandler{

    execute( scheduledTaskRequest: GetScheduledTaskByIdRequest):Promise<GetScheduledTaskByIdResponse>; 
}