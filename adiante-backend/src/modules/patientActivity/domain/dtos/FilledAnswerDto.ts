class FilledAnswerDto {
  idQuestion: number;
  idAnswer: number;

  constructor(idQuestion: number, idAnswer: number) {
    this.idQuestion = idQuestion;
    this.idAnswer = idAnswer;
  }
}

export { FilledAnswerDto };