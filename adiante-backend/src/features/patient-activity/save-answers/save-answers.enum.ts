// Used on taskRecordingService
export const enum SaveAnswersStatus  {
    Success = "Success",
    TaskValueMandatory = "TaskValueMandatory",
    IncompleteQuestionnaireAnswers = "IncompleteQuestionnaireAnswers",
    InvalidTaskId = "InvalidTaskId",
    TaskNotAssignedToPatient = "TaskNotAssignedToPatient",
    ScheduledTaskAlreadyCompleted = "ScheduledTaskAlreadyCompleted",
    InvalidScheduledTaskId = "InvalidScheduledTaskId",
    IncompleteQuestionnaireId ="IncompleteQuestionnaireId",
    QuestionnaireIdNotFound = "QuestionnaireIdNotFound",
    QuestionIdNotFound = "QuestionIdNotFound",
    PatientNotFound = "PatientNotFound",
    InternalError = "InternalError",
 };
 