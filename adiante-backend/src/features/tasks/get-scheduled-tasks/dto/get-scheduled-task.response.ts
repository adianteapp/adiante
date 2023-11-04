import {GetScheduledTasksStatus} from "../get-scheduled-task.enum";
export interface GetScheduledTasksResponse {
    tasksList: ScheduledTask[];
    status:GetScheduledTasksStatus
  }


export interface ScheduledTask {
    scheduledId: string;
    taskId:string;
    title: string;
    description: string;
    startDateTimeLocal: string;
    endDateTimeLocal: string;
    executionDateTimeLocal: string;
    relatedQuestionnaireId:string;

  }