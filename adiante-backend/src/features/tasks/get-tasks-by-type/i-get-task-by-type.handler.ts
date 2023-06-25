import { GetTasksByTypeRequest } from "./dto/get-tasks-by-type.request";
import { GetTasksByTypeResponse } from "./dto/get-tasks-by-type.response";

export interface IGetTasksByTypeHandler{

    execute( getTasksByTypeRequest: GetTasksByTypeRequest):Promise<GetTasksByTypeResponse>; 
}