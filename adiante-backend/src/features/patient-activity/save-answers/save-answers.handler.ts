import { SaveAnswersRequest } from "./dto/save-answers.request";
import { SaveAnswersResponse } from "./dto/save-answers.response";
import { ISaveAnswersHandler } from "./i-save-answers.handler";
import { SaveAnswersStatus } from "./save-answers.enum";
import Logger from "../../../config/logger";

export class SaveAnswerHandler implements ISaveAnswersHandler{
    
  async  execute(saveAnswersRequest:SaveAnswersRequest):Promise<SaveAnswersResponse>{
        let saveAnswersResponse : SaveAnswersResponse = undefined;

        return saveAnswersResponse;
    }

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
 
 
 async  preparePatientActivity(patientActivityDto: any): Promise<PatientActivityEntry> {
 
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
 
 
 async  getPatientQuestionnaireData(filledQuestionnaire: any): Promise<QuestionnaireExecution> {
 
    const questionnaireExecutionAnswerList: QuestionnaireExecutionAnswer[] = [];
    for (const answer of filledQuestionnaire.answersList) {
 
       const freeAnswerValue = answer.freeAnswerValue ? answer.freeAnswerValue : null;
       questionnaireExecutionAnswerList.push(new QuestionnaireExecutionAnswer(0, answer.idQuestion, freeAnswerValue, answer.idQuestion, 0));
    }
 
    const questionnaireExecution = new QuestionnaireExecution(0, filledQuestionnaire.idQuestionnaire, 0, questionnaireExecutionAnswerList);
 
    return questionnaireExecution;
 }
 
 
 //#endregion
 
 
 //#region Validations over player and task.
 
 async  validatePatientActivityRequest(patientActivityDto: any): Promise<SaveAnswersStatus> {
 
    let validationResult: SaveAnswersStatus = SaveAnswersStatus.Success;
 
    // PatientId validation
    validationResult = await validateIdPatient(patientActivityDto);
    if (validationResult !== SaveAnswersStatus.Success) {
       return validationResult;
    }
 
    //validate that at least 1 activity is provide
    validationResult = await validateExecutedTaskMinContent(patientActivityDto.executedTask);
    if (validationResult !== SaveAnswersStatus.Success) {
       return validationResult;
    }
 
    //validate task integrity references
    validationResult = await validateExecutedTask(patientActivityDto.executedTask);
    if (validationResult !== SaveAnswersStatus.Success) {
       return validationResult;
    }
 
    return validationResult;
 }
 
 async  validateExecutedTask(executedTask: any): Promise<SaveAnswersStatus> {
 
    const task = await taskService.getTaskById(executedTask.idTask);
 
    if (task) {
 
       switch (task.taskType.codeName) {
 
          case TaskType.questionnaire:
 
             const questionnaireValidation = await questionnaireService.validateQuestionnaireData(executedTask);
             if (questionnaireValidation !== SaveAnswersStatus.Success) {
                return questionnaireValidation;
             }
 
          default:
             //not validation are needed on this case
       }
 
    } else {
 
       Logger.error("Error saving patient activity. Invalid taskId:" + executedTask.idTask);
       return SaveAnswersStatus.InvalidTaskId;
 
    }
 
    return SaveAnswersStatus.Success;
 }
 
 async  validateIdPatient(patientActivityDto: any): Promise<SaveAnswersStatus> {
 
    if (!patientActivityDto || !(patientActivityDto.idPatient)) {
 
       Logger.error("Patientid not provided, activity can not be saved");
       return SaveAnswersStatus.PatientNotFound;
    }
 
    const patientValidation = await authService.getPatientByPatientId(patientActivityDto.idPatient);
 
    if (!patientValidation) {
 
       Logger.error("Patientid:" + patientActivityDto.idPatient + " not found, activity can not be saved");
       return SaveAnswersStatus.PatientNotFound;
 
    } else {
       return SaveAnswersStatus.Success;
    }
 }
 
 async  validateExecutedTaskMinContent(executedTask: any): Promise<SaveAnswersStatus> {
 
    if (!executedTask || !(executedTask.idTask)) {
 
       Logger.error("Error saving patient activity. No taskid provided");
       return SaveAnswersStatus.InvalidTaskId
 
    } else {
       return SaveAnswersStatus.Success;
    }
 }
 
 //#endregion


 //#region validations over questionnaire
 
 //#endregion validations over questionnaire





}





 