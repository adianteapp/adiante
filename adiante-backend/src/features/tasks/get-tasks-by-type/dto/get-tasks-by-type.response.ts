import { Task } from "../../../../features/shared/get-task/dto/get-task.response";
import {GetTasksByTypeStatus} from "../get-tasks-by-type.enum"
export interface GetTasksByTypeResponse {
    tasksList: Task[];
    status:GetTasksByTypeStatus
  }
