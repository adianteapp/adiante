import { GetTaskRequest } from "./dto/get-task.request";
import { GetTaskResponse } from "./dto/get-task.response";

export interface IGetTaskHandler{
    execute( taskRequest: GetTaskRequest):Promise<GetTaskResponse>; 
}