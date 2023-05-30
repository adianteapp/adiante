import {GetScheduledTasksStatus} from "../get-scheduled-task.enum";
export interface GetScheduledTasksResponse {
    tasksList: ScheduledTask[];
    status:GetScheduledTasksStatus
  }


export interface ScheduledTask {
    taskId: number;
    taskTitle: string;
    taskDescription: string;
    startDateTimeLocal: string;
    endDateTimeLocal: string;
    executionDateTimeLocal: string;
  }