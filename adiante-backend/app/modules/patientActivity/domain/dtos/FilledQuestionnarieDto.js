class FilledQuestionnaireDto {
  constructor(idQuestionnaire, answersList) {
    this.idQuestionnaire = idQuestionnaire;
    this.answersList = answersList.map(answer => new FilledAnswerDto(answer.idQuestion, answer.idAnswer));
  }
}
module.exports = FilledQuestionnaireDto;