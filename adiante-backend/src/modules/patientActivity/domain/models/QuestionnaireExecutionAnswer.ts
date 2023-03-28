class QuestionnaireExecutionAnswer {
  id: number;
  idQuestion: number;
  freeAnswerValue: string;
  idAnswer: number;
  idQuestionnaireExecution: number;

  constructor(id: number, idQuestion: number, freeAnswerValue: string, idAnswer: number, idQuestionnaireExecution: number) {
    this.id = id;
    this.idQuestion = idQuestion;
    this.freeAnswerValue = freeAnswerValue;
    this.idAnswer = idAnswer;
    this.idQuestionnaireExecution = idQuestionnaireExecution;
  }
}

export default QuestionnaireExecutionAnswer;
