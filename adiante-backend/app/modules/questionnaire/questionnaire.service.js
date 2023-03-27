require('dotenv').config()

const questionnaireRepository = require("./questionnaire.repository");
const questionnaireEnum = require("./questionnaire.enum");
const patientActivityEnum = require("../patientActivity/patientActivity.enum");

const loggerConfig = require("../../middleware/log4sConf");
const logger = loggerConfig.fileAppenderLogger;


  /**
   * @description This method is in charge to check the integrity of the reference data, idquestionnaire, idquestions and answers. Moreover in case of a free answer 
   * it validates the fullfilment of the freevalue
   * @param {Object} executedTaskItem
   * @returns {patientActivityEnum}
   */
  exports.validateQuestionnaireData = async (executedTaskItem) => {
      
      if( !executedTaskItem ||!(executedTaskItem.filledQuestionnaire) ||
         !(executedTaskItem.filledQuestionnaire.idQuestionnaire) ){

           return patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireId;

      }

      const filledQuestionnaire = executedTaskItem.filledQuestionnaire;

      const recoveredQuestionnaire = await questionnaireRepository.getQuestionnaireById(filledQuestionnaire.idQuestionnaire);
      
      if(!recoveredQuestionnaire){

          return patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireId;

      }

      const validateQuestionnaireAnswerDataResult = await validateAnswersData(filledQuestionnaire, recoveredQuestionnaire);
      return  validateQuestionnaireAnswerDataResult;

  };


 async function validateAnswersData(filledQuestionnaire, recoveredQuestionnaire){
       
        let validateAnswersDataResult = false;
        
        if(filledQuestionnaire.answersList && filledQuestionnaire.answersList.length > 0){
                  
                  for(const answer of filledQuestionnaire.answersList){

                      let filteredQuestionAnswers = await filterRelatedQuestionAnswer(answer,recoveredQuestionnaire);

                
                 
                      let questionType = filteredQuestionAnswers[0].question_type;
                      if(!questionType){
                        logger.error("Error retrieving question_type from database for questionId:"+answer.idQuestion)
                        return patientActivityEnum.TaskRecordingStatusses.patRecErrInternalError;
                      }

                      switch  (questionType){
                        case questionnaireEnum.QuestionType.freeAnswer:
                              validateAnswersDataResult = await validateFreeAnswerValue(answer);
                              break;
                        case questionnaireEnum.QuestionType.selectOneAnswer:
                                validateAnswersDataResult = await validateQuestionAnswerRelationship(answer,filteredQuestionAnswers);
                                break;
                        case questionnaireEnum.QuestionType.selectMultipleAnswer:
                                  validateAnswersDataResult = await validateQuestionAnswerRelationship(answer,filteredQuestionAnswers);
                                break;
                      }
                    
                      if(!validateAnswersDataResult){
                          return patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers;
                      }

                  }
 
          return patientActivityEnum.TaskRecordingStatusses.patRecOk;

        }else{

          logger.error("Error saving patient activity. Provided questionnaireId:"+filledQuestionnaire.idQuestionnaire+" doesn't have related answers");
          return patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers;

        }
 }

 /**
  * It filters the recoveredQuestionnaire keeping only the matched entries to the answer.idQuestion
  */
 async function filterRelatedQuestionAnswer(answer, recoveredQuestionnaire){

     let relatedQuestionAnswer = null;
     if(answer && answer.idQuestion){

      relatedQuestionAnswer = recoveredQuestionnaire.filter(questionAnswerEntry => questionAnswerEntry.id_question == answer.idQuestion);

     }
     
     return relatedQuestionAnswer;
 }
 
 /**
  * This function ensures that the provided answeredItem.IdAnswer is related to the right question on database.
  * @param {*} answeredItem 
  * @param {*} recoveredQuestionnaire
  * @returns 
  */
 async function validateQuestionAnswerRelationship(answeredItem,recoveredQuestionnaire){

      const containsValidation = recoveredQuestionnaire.some(entry => entry.id_answer ==  answeredItem.idAnswer);
      return containsValidation;
 }
 
 
 async function validateFreeAnswerValue(answeredItem){

      const validationResult = answeredItem.freeAnswerValue != null ?  true :  false;
      return validationResult;

}
 