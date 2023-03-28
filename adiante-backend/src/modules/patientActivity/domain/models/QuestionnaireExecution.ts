import  QuestionnaireExecutionAnswer  from './QuestionnaireExecutionAnswer';

export class QuestionnaireExecution {
  constructor(
    public id: number,
    public idQuestionnaire: number,
    public idPatientActivityEntry: number,
    public questionnaireExecutionAnswersList: QuestionnaireExecutionAnswer[]
  ) {}
}