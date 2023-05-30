import * as dotenv from 'dotenv';
dotenv.config();

import questionnaireRepository from "./questionnaire.repository";
import QuestionType from "./questionnaire.enum";
import  TaskRecordingStatusses  from "../patientActivity/patientActivity.enum";

import Logger from '../../config/logger';


/**
 * @description  This method is in charge to check the integrity of the reference data, idquestionnaire, idquestions and answers. Moreover in case of a free answer 
 * @returns {TaskRecordingStatusses}
 */
export async function validateQuestionnaireData(executedTaskItem: any): Promise<TaskRecordingStatusses> {
      
    if (!executedTaskItem || !(executedTaskItem.filledQuestionnaire) || !(executedTaskItem.filledQuestionnaire.idQuestionnaire)) {
        return TaskRecordingStatusses.patRecErrIncompleteQuestionnaireId;
    }

    const filledQuestionnaire = executedTaskItem.filledQuestionnaire;

    const recoveredQuestionnaire = await questionnaireRepository.getQuestionnaireById(filledQuestionnaire.idQuestionnaire);

    if (!recoveredQuestionnaire) {
        return TaskRecordingStatusses.patRecErrIncompleteQuestionnaireId;
    }

    const validateQuestionnaireAnswerDataResult = await validateAnswersData(filledQuestionnaire, recoveredQuestionnaire);
    return validateQuestionnaireAnswerDataResult;
}


//#region Validations aux functions of the validateQuestionnaireData method.

async function validateAnswersData(filledQuestionnaire: any, recoveredQuestionnaire: any): Promise<TaskRecordingStatusses> {
    let validateAnswersDataResult = false;
    
    if (filledQuestionnaire.answersList && filledQuestionnaire.answersList.length > 0) {
        for (const answer of filledQuestionnaire.answersList) {
            let filteredQuestionAnswers = await filterRelatedQuestionAnswer(answer, recoveredQuestionnaire);
            let questionType = filteredQuestionAnswers[0].question_type;
            if (!questionType) {
                Logger.error("Error retrieving question_type from database for questionId:" + answer.idQuestion)
                return TaskRecordingStatusses.patRecErrInternalError;
            }

            switch (questionType) {
                case QuestionType.freeAnswer:
                    validateAnswersDataResult = await validateFreeAnswerValue(answer);
                    break;
                case QuestionType.selectOneAnswer:
                    validateAnswersDataResult = await validateQuestionAnswerRelationship(answer, filteredQuestionAnswers);
                    break;
                case QuestionType.selectMultipleAnswer:
                    validateAnswersDataResult = await validateQuestionAnswerRelationship(answer, filteredQuestionAnswers);
                    break;
            }
            
            if (!validateAnswersDataResult) {
                return TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers;
            }
        }
        return TaskRecordingStatusses.patRecOk;
    } else {
        Logger.error("Error saving patient activity. Provided questionnaireId:" + filledQuestionnaire.idQuestionnaire + " doesn't have related answers");
        return TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers;
    }
}

/**
 * It filters the recoveredQuestionnaire keeping only the matched entries to the answer.idQuestion
 */
async function filterRelatedQuestionAnswer(answer: any, recoveredQuestionnaire: any): Promise<any> {
    let relatedQuestionAnswer = null;
    if (answer && answer.idQuestion) {
        relatedQuestionAnswer = recoveredQuestionnaire.filter((questionAnswerEntry: any) => questionAnswerEntry.id_question == answer.idQuestion);
    }
    return relatedQuestionAnswer;
}

/**
 * This function ensures that the provided answeredItem.IdAnswer is related to the right question on database.
 */
async function validateQuestionAnswerRelationship(answeredItem: {idAnswer: number}, recoveredQuestionnaire: Array<{id_answer: number}>): Promise<boolean> {
  const containsValidation = recoveredQuestionnaire.some(entry => entry.id_answer == answeredItem.idAnswer);
  return containsValidation;
}

async function validateFreeAnswerValue(answeredItem: {freeAnswerValue: string | null}): Promise<boolean> {
  const validationResult = answeredItem.freeAnswerValue !== null;
  return validationResult;
}

//#endregion