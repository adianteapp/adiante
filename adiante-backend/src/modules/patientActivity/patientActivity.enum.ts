
// Used on taskRecordingService
export const enum TaskRecordingStatusses  {
   patRecOk = "OK",
   patRecErrTaskValueMandatory = "PAT-REC-ERR-01",
   patRecErrIncompleteQuestionnaireAnswers = "PAT-REC-ERR-02",
   patRecErrInvalidTaskId = "PAT-REC-ERR-03",
   patRecErrTaskNotAssignedToPatient = "PAT-REC-ERR-04",
   patRecErrIncompleteQuestionnaireId ="PAT-REC-ERR-05",
   patRecErrPatientNotFound = "PAT-REC-ERR-06",
   patRecErrInternalError = "PAT-REC-INTERNAL-ERROR",
};



// Common statuses
export const enum PatientActivityStatusses  {
   Ok = "OK"
};



export default TaskRecordingStatusses;
