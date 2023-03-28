import { FilledAnswerDto } from './FilledAnswerDto';

class FilledQuestionnaireDto {
  idQuestionnaire: number;
  answersList: FilledAnswerDto[];

  constructor(idQuestionnaire: number, answersList: { idQuestion: number, idAnswer: number }[]) {
    this.idQuestionnaire = idQuestionnaire;
    this.answersList = answersList.map(answer => new FilledAnswerDto(answer.idQuestion, answer.idAnswer));
  }
}

export { FilledQuestionnaireDto };
