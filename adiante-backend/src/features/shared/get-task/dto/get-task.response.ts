import { Questionnaire } from "../../get-questionnaire/dto/get-questionnaire.response";
import { GetTaskStatus } from "../get-task.enum";

export interface GetTaskResponse {
     status:GetTaskStatus;
     task:Task;
     questionnaire?:Questionnaire;
  }

export interface Task {
    taskId: string;
    taskTypeCode: string;
    title: string;
    description: string;
    mandatoryFeedback: boolean;
    additionalInfo: string | null;
    relatedQuestionnaireId: string | null;
    taskAttributeList: TaskAttribute[] | null;
    executed:boolean | null;
  }

export interface TaskAttribute{
  attributeCode:string;
  attributeValue:string;
}