import * as dotenv from 'dotenv';
dotenv.config();

import * as authService from '../auth/auth.service';

import * as patientActivityRepository from './patientActivity.repository';
import  {TaskRecordingStatusses}  from '../patientActivity/patientActivity.enum';
import  PatientActivityEntryValue  from './domain/models/PatientActivityEntryValue';

import {TaskType} from '../tasks/tasks.enum';
import * as taskService from '../tasks/task.service';

import  QuestionnaireExecutionAnswer  from './domain/models/QuestionnaireExecutionAnswer';
import { QuestionnaireExecution } from './domain/models/QuestionnaireExecution';
import { PatientActivityEntry } from './domain/models/PatientActivityEntry';


import * as questionnaireService from '../questionnaire/questionnaire.service';

import Logger from '../../config/logger';


//#region  exported methods

/**
 * @description This method is in charge to save the activity confirmed by the patient.
 * @param {patientActivityDto} patientActivity
 * @param {String} password
 * @returns {validationResult,patient,token}
 */
export const save = async (patientActivityDto: any) => {
   let validationResult :TaskRecordingStatusses;

   //apply validations
   validationResult = await validatePatientActivityRequest(patientActivityDto);

   if (validationResult !== TaskRecordingStatusses.patRecOk) {
      return { status: validationResult };
   }

   //build the objects to save them into the database
   const patientActivityEntry = await preparePatientActivity(patientActivityDto);

   //save the info
   let saveStatusRepository = null;

   if (patientActivityEntry.questionnaireExecution) {
      saveStatusRepository = await patientActivityRepository.insertPatientTaskQuestionnaireEntry(patientActivityEntry);
   } else {
      saveStatusRepository = await patientActivityRepository.insertPatientTaskEntry(patientActivityEntry);
   }

   const saveStatus = saveStatusRepository ? TaskRecordingStatusses.patRecOk : TaskRecordingStatusses.patRecErrInternalError;

   return { status: saveStatus };
};


//#endregion

//#region Prepare functions to save data into repository


async function preparePatientActivity(patientActivityDto: any): Promise<PatientActivityEntry> {

   let questionnaireExecution: QuestionnaireExecution | undefined = undefined;
   let taskPatientValue: PatientActivityEntryValue | undefined = undefined;

   if (patientActivityDto.executedTask.value) {
      taskPatientValue = new PatientActivityEntryValue(0, patientActivityDto.executedTask.value, 0);
   }

   if (patientActivityDto.executedTask && patientActivityDto.executedTask.filledQuestionnaire) {
      questionnaireExecution = await getPatientQuestionnaireData(patientActivityDto.executedTask.filledQuestionnaire);
   }
   
   const pantientActivityEntry = new PatientActivityEntry(0, new Date(), patientActivityDto.idPatient, patientActivityDto.executedTask.idTask, taskPatientValue, questionnaireExecution);

   return pantientActivityEntry;
}


async function getPatientQuestionnaireData(filledQuestionnaire: any): Promise<QuestionnaireExecution> {

   const questionnaireExecutionAnswerList: QuestionnaireExecutionAnswer[] = [];
   for (const answer of filledQuestionnaire.answersList) {

      const freeAnswerValue = answer.freeAnswerValue ? answer.freeAnswerValue : null;
      questionnaireExecutionAnswerList.push(new QuestionnaireExecutionAnswer(0, answer.idQuestion, freeAnswerValue, answer.idQuestion, 0));
   }

   const questionnaireExecution = new QuestionnaireExecution(0, filledQuestionnaire.idQuestionnaire, 0, questionnaireExecutionAnswerList);

   return questionnaireExecution;
}


//#endregion


//#region Validations functions of the save method.

async function validatePatientActivityRequest(patientActivityDto: any): Promise<TaskRecordingStatusses> {

   let validationResult: TaskRecordingStatusses = TaskRecordingStatusses.patRecOk;

   // PatientId validation
   validationResult = await validateIdPatient(patientActivityDto);
   if (validationResult !== TaskRecordingStatusses.patRecOk) {
      return validationResult;
   }

   //validate that at least 1 activity is provide
   validationResult = await validateExecutedTaskMinContent(patientActivityDto.executedTask);
   if (validationResult !== TaskRecordingStatusses.patRecOk) {
      return validationResult;
   }

   //validate task integrity references
   validationResult = await validateExecutedTask(patientActivityDto.executedTask);
   if (validationResult !== TaskRecordingStatusses.patRecOk) {
      return validationResult;
   }

   return validationResult;
}

async function validateExecutedTask(executedTask: any): Promise<TaskRecordingStatusses> {

   const task = await taskService.getTaskById(executedTask.idTask);

   if (task) {

      switch (task.taskType.codeName) {

         case TaskType.questionnaire:

            const questionnaireValidation = await questionnaireService.validateQuestionnaireData(executedTask);
            if (questionnaireValidation !== TaskRecordingStatusses.patRecOk) {
               return questionnaireValidation;
            }

         default:
            //not validation are needed on this case
      }

   } else {

      Logger.error("Error saving patient activity. Invalid taskId:" + executedTask.idTask);
      return TaskRecordingStatusses.patRecErrInvalidTaskId;

   }

   return TaskRecordingStatusses.patRecOk;
}

async function validateIdPatient(patientActivityDto: any): Promise<TaskRecordingStatusses> {

   if (!patientActivityDto || !(patientActivityDto.idPatient)) {

      Logger.error("Patientid not provided, activity can not be saved");
      return TaskRecordingStatusses.patRecErrPatientNotFound;
   }

   const patientValidation = await authService.getPatientByPatientId(patientActivityDto.idPatient);

   if (!patientValidation) {

      Logger.error("Patientid:" + patientActivityDto.idPatient + " not found, activity can not be saved");
      return TaskRecordingStatusses.patRecErrPatientNotFound;

   } else {
      return TaskRecordingStatusses.patRecOk;
   }
}

async function validateExecutedTaskMinContent(executedTask: any): Promise<TaskRecordingStatusses> {

   if (!executedTask || !(executedTask.idTask)) {

      Logger.error("Error saving patient activity. No taskid provided");
      return TaskRecordingStatusses.patRecErrInvalidTaskId

   } else {
      return TaskRecordingStatusses.patRecOk;
   }
}

//#endregion







