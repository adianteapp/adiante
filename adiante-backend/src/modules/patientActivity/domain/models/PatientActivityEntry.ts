import  {QuestionnaireExecution}  from './QuestionnaireExecution';
import  PatientActivityEntryValue  from './PatientActivityEntryValue';

class PatientActivityEntry {
  id: number;
  entryDatetime: Date;
  idPatient: number;
  idTask: number;
  patientActivityEntryValue?: PatientActivityEntryValue;
  questionnaireExecution?: QuestionnaireExecution;

  constructor(
    id: number,
    entryDatetime: Date,
    idPatient: number,
    idTask: number,
    patientActivityEntryValue?: PatientActivityEntryValue,
    questionnaireExecution?: QuestionnaireExecution
  ) {
    this.id = id;
    this.entryDatetime = entryDatetime;
    this.idPatient = idPatient;
    this.idTask = idTask;
    this.patientActivityEntryValue = patientActivityEntryValue;
    this.questionnaireExecution = questionnaireExecution;
  }
}

export { PatientActivityEntry };
