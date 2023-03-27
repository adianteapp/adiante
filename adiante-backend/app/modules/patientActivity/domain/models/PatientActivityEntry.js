class PatientActivityEntry {
  constructor(id, entryDatetime, idPatient, idTask, patientActivityEntryValue, questionnaireExecution) {
    this.id = id;
    this.entryDatetime = entryDatetime;
    this.idPatient = idPatient;
    this.idTask = idTask;
    this.patientActivityEntryValue = patientActivityEntryValue;
    this.questionnaireExecution = questionnaireExecution;
  }
}
module.exports = PatientActivityEntry;