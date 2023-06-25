export interface PreparePatientActivityResponse{
   patientActivityEntry: PatientActivityEntry
}


export interface   PatientActivityEntry {
  id: string;
  entryDatetime: Date;
  idPatient: string;
  idTask: string;
  patientActivityEntryValue?: PatientActivityEntryValue;
  questionnaireExecution?: QuestionnaireExecution;
}


export interface  PatientActivityEntryValue {
    id: string;
    value: string;
    idActivityEntry: string;

} 

export interface   QuestionnaireExecution {
    id: string,
    idQuestionnaire: string,
    idPatientActivityEntry: string,
    questionnaireExecutionAnswersList: QuestionnaireExecutionAnswer[]
}

export interface  QuestionnaireExecutionAnswer {
    id: string;
    idQuestion: string;
    freeAnswerValue: string;
    idAnswer: string;
    idQuestionnaireExecution: string;
}