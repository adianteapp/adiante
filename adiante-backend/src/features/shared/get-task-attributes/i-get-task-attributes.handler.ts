import { GetTaskAttributesRequest } from "./dto/get-task-attributes.request";
import { GetTaskAttributesResponse } from "./dto/get-task-attributes.response";

export interface IGetTaskAttributesHandler{
    execute( taskRequest: GetTaskAttributesRequest):Promise<GetTaskAttributesResponse>; 
}