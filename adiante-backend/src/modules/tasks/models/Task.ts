import { TaskType } from "./TaskType";
import { Questionnaire } from "./Questionnaire";
export class Task {
  constructor(
    public id: string,
    public codeName: string,
    public freeExecution: boolean,
    public updatedAt: Date,
    public taskType: TaskType,
    public questionnaire?: Questionnaire
  ) {}
}