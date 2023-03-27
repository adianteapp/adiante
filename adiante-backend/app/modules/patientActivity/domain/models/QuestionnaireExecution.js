class QuestionnaireExecution {
  constructor(id, idQuestionnaire, idPatientActivityEntry,questionnaireExecutionAnswersList) {
    this.id = id;
    this.idQuestionnaire = idQuestionnaire;
    this.idPatientActivityEntry = idPatientActivityEntry;
    this.questionnaireExecutionAnswersList = questionnaireExecutionAnswersList;
  }
}
module.exports = QuestionnaireExecution;