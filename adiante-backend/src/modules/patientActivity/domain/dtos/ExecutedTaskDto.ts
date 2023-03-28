import { FilledQuestionnaireDto } from './FilledQuestionnarieDto';

class ExecutedTaskDto {
  idTask: number;
  value: number;
  filledQuestionnaire: FilledQuestionnaireDto;

  constructor(idTask: number, value: number, filledQuestionnaire: FilledQuestionnaireDto) {
    this.idTask = idTask;
    this.value = value;
    this.filledQuestionnaire = filledQuestionnaire;
  }
}

export { ExecutedTaskDto };
