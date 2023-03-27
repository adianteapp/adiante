require('dotenv').config()

const authService = require("../auth/auth.service");


const patientActivityRepository = require("./patientActivity.repository");
const taskRecordingEnum = require("./patientActivity.enum");

const taskEnum = require("../tasks/tasks.enum");
const taskService = require("../tasks/task.service");

//Modeles
const QuestionnaireExecutionAnswer = require("./domain/models/QuestionnaireExecutionAnswer");
const QuestionnaireExecution = require("./domain/models/QuestionnaireExecution");
const PatientActivityEntry = require("./domain/models/PatientActivityEntry");
const PatientActivityEntryValue = require("./domain/models/PatientActivityEntryValue");

const questionnaireService = require("../questionnaire/questionnaire.service");

const loggerConfig = require("../../middleware/log4sConf");
const logger = loggerConfig.fileAppenderLogger;



/**
 * @description This method is in charge to save the activity confirmed by the patient.
 * @param {patientActivityDto} patientActivity
 * @param {String} password
 * @returns {validationResult,patient,token}
 */
exports.save = async (patientActivityDto) => {

   let validationResult;

   //apply validations
   validationResult = await validatePatientActivityRequest(patientActivityDto);

   if (validationResult !== taskRecordingEnum.TaskRecordingStatusses.patRecOk) {

      return { status: validationResult };
   }

   //build the obtjects to save them into database
   const pantientActivityEntry = await preparePatientActivity(patientActivityDto);

   //save the info
   let saveStatusRepository = null;

   if (pantientActivityEntry.questionnaireExecution) {

      saveStatusRepository = await patientActivityRepository.insertPatientTaskQuestionnaireEntry(pantientActivityEntry);

   } else {

      saveStatusRepository = await patientActivityRepository.insertPatientTaskEntry(pantientActivityEntry);

   }

   const saveStatus = saveStatusRepository ? taskRecordingEnum.TaskRecordingStatusses.patRecOk : taskRecordingEnum.TaskRecordingStatusses.patRecErrInternalError;

   return {status:saveStatus};

};


//#region Prepare functions to save data into repository


async function preparePatientActivity(patientActivityDto) {

   let questionnaireExecution = null;
   let taskPatientValue = null;

   if (patientActivityDto.executedTask.value) {

      taskPatientValue = new PatientActivityEntryValue(null, patientActivityDto.executedTask.value);
   }

   if (patientActivityDto.executedTask && patientActivityDto.executedTask.filledQuestionnaire) {
      questionnaireExecution = await getPatientQuestionnaireData(patientActivityDto.executedTask.filledQuestionnaire);
   }
   
   const pantientActivityEntry = new PatientActivityEntry(null, null,patientActivityDto.idPatient, patientActivityDto.executedTask.idTask, taskPatientValue, questionnaireExecution);

   return pantientActivityEntry;
}



async function getPatientQuestionnaireData(filledQuestionnaire) {

   const questionnaireExecutionAnswerList = [];
   for (const answer of filledQuestionnaire.answersList) {

      const freeAnswerValue = answer.freeAnswerValue ? answer.freeAnswerValue : null;
      questionnaireExecutionAnswerList.push(new QuestionnaireExecutionAnswer(null, answer.idQuestion, freeAnswerValue, answer.idQuestion, null));
   }

   const questionnaireExecution = new QuestionnaireExecution(null, filledQuestionnaire.idQuestionnaire, null, questionnaireExecutionAnswerList);

   return questionnaireExecution;
}

//#endregion


//#region Validations functions of the save method.

async function validatePatientActivityRequest(patientActivityDto) {


   let validationResult = taskRecordingEnum.TaskRecordingStatusses.patRecOk;

   // PatientId validation
   validationResult = await validateIdPatient(patientActivityDto);
   if (validationResult !== taskRecordingEnum.TaskRecordingStatusses.patRecOk) {
      return validationResult;
   }

   //validate that at least 1 activity is provide
   validationResult = await validateExecutedTaskMinContent(patientActivityDto.executedTask);
   if (validationResult !== taskRecordingEnum.TaskRecordingStatusses.patRecOk) {
      return validationResult;
   }

   //validate task integrity references
   validationResult = await validateExecutedTask(patientActivityDto.executedTask);
   if (validationResult !== taskRecordingEnum.TaskRecordingStatusses.patRecOk) {
      return validationResult;
   }

   return validationResult;

}

async function validateExecutedTask(executedTask) {



   const task = await taskService.getTaskById(executedTask.idTask);

   if (task) {

      switch (task.taskType.codeName) {

         case taskEnum.TaskType.questionnaire:

            const questionnaireValidation = questionnaireService.validateQuestionnaireData(executedTask);
            if (questionnaireValidation !== taskRecordingEnum.TaskRecordingStatusses.patRecOk) {
               return questionnaireValidation;
            }

         default:
         //not validation are needed on this case
      }

   } else {

      logger.error("Error saving patient activity. Invalid taskId:" + executedTask.idTask);
      return taskRecordingEnum.TaskRecordingStatusses.patRecErrInvalidTaskId;

   }

   return taskRecordingEnum.TaskRecordingStatusses.patRecOk;
}

async function validateIdPatient(patientActivityDto) {

   if (!patientActivityDto || !(patientActivityDto.idPatient)) {

      logger.error("Patientid not provided, activity can not be saved");
      return taskRecordingEnum.TaskRecordingStatusses.patRecErrPatientNotFound;
   }


   const patientValidation = await authService.getPatientByPatientId(patientActivityDto.idPatient);

   if (!patientValidation) {

      logger.error("Patientid:" + patientActivityDto.idPatient + " not found, activity can not be saved");
      return taskRecordingEnum.TaskRecordingStatusses.patRecErrPatientNotFound;

   } else {
      return taskRecordingEnum.TaskRecordingStatusses.patRecOk;
   }

}



async function validateExecutedTaskMinContent(executedTask) {

   if (!executedTask || !(executedTask.idTask)) {

      logger.error("Error saving patient activity. No taskid provided");
      return taskRecordingEnum.TaskRecordingStatusses.patRecErrInvalidTaskId

   } else {
      return taskRecordingEnum.TaskRecordingStatusses.patRecOk;
   }
}


//#endregion







