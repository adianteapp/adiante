import { GetTaskStatus } from "../get-task.enum";

export interface GetTaskResponse {
     status:GetTaskStatus;
     task:Task;
     relatedQuestionnaire?:any;
  }

export interface Task {
    taskId: number;
    taskTypeCode: string;
    title: string;
    description: string;
    mandatoryFeedback: boolean;
    relatedQuestionnaireId: number | null;
  }