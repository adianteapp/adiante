import { injectable } from "inversify";
import { GetTaskAttributesRequest } from "./dto/get-task-attributes.request";
import { GetTaskAttributesResponse, TaskAttributeValue } from "./dto/get-task-attributes.response";
import { IGetTaskAttributesHandler } from "./i-get-task-attributes.handler";
import { GetTaskAttributesStatus } from "./get-task-attributes.enum";
import * as dotenv from 'dotenv';

import dao from "../../../middleware/dao";
import Logger from '../../../config/logger';
import TaskType from "../enums/task-type.enum";

@injectable()
export class GetTaskAttributesHandler implements IGetTaskAttributesHandler {



  constructor(){
    dotenv.config();
  }

  async execute(getTaskAttributesRequest: GetTaskAttributesRequest): Promise<GetTaskAttributesResponse> {

    let getTaskAttributesResponse: GetTaskAttributesResponse = undefined;
    let relatedAttributeValueList: TaskAttributeValue[] = undefined;

    const validationRequestResult: GetTaskAttributesStatus = await this.validateRequest(getTaskAttributesRequest);
    if(validationRequestResult !== GetTaskAttributesStatus.Succesfull){
      return getTaskAttributesResponse = {status : validationRequestResult} as GetTaskAttributesResponse;
    }

    relatedAttributeValueList = await this.getTaskAttributeValues(getTaskAttributesRequest.taskId,getTaskAttributesRequest.taskTypeCode);

    getTaskAttributesResponse = {taskAttributes:relatedAttributeValueList,status:GetTaskAttributesStatus.Succesfull};


    return getTaskAttributesResponse;
  }


  private async getTaskAttributeValues(taskId:number,taskType:string ):Promise<TaskAttributeValue[]>{
      let taskAttributeValueList: TaskAttributeValue[] = undefined;
      switch(taskType){
        case TaskType.challenge:
          taskAttributeValueList = await this.getTaskAtributeValuesFromDB(taskId);
          break;

        default:
          break;
      }

      return taskAttributeValueList;
  }

//#region validations 
  private async validateRequest(getTaskAttributesRequest: GetTaskAttributesRequest): Promise<GetTaskAttributesStatus> {
    let validationResult = GetTaskAttributesStatus.Succesfull;

    if (getTaskAttributesRequest.taskId == undefined) {
      validationResult = GetTaskAttributesStatus.MissedTaskId;
    }

    return validationResult;
  }

  //#endregion validations

  


//#region queries to database

  private async getTaskAtributeValuesFromDB(taskId: number):Promise<TaskAttributeValue[]> {
    
    let taskAttributeValueList:TaskAttributeValue[] = undefined;
    const sqlQuery: string = `SELECT ta.id  as 'taskAtributeId',ta.code_name as 'taskAtributeName', tav.value as 'taskAttributeValue' 
                              FROM task_attribute_value tav
                              INNER JOIN task t ON tav.id_task = t.id
                              INNER JOIN task_attribute ta ON tav.id_task_attribute = ta.id
                              WHERE t.id = ${taskId}`;
    
    const rows = await dao.executeQuery(sqlQuery);
    if(rows && rows.length > 0){

      taskAttributeValueList = JSON.parse(JSON.stringify(rows, (_, value) => typeof value === 'bigint' ? value.toString() : value)) as TaskAttributeValue[];
    }
    return taskAttributeValueList;
  }





//#endregion queries to database



}






