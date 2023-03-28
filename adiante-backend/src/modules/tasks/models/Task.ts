import { TaskType } from "./TaskType";
export class Task {
  constructor(
    public id: string,
    public codeName: string,
    public freeExecution: boolean,
    public updatedAt: Date,
    public taskType: TaskType
  ) {}
}