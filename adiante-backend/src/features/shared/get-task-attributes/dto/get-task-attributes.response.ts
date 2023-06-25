import { GetTaskAttributesStatus } from "../get-task-attributes.enum";

export interface GetTaskAttributesResponse {
     status:GetTaskAttributesStatus;
     taskAttributes?:TaskAttributeValue[];
  }

export interface TaskAttributeValue {
    taskAttributeId:string;
    taskAttributeName:string;
    taskAttributeValue:string;
 }

 export interface TaskTypeAttributeValue {
  taskTypeAttributeValue:string;
  taskTypeAttributeName:string;
  taskTypeAttributeId:string;
}


