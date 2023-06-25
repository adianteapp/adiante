require('dotenv').config()
import axios from 'axios';
import authHeader from './auth-header';

const API_URL = `${process.env.VUE_APP_BACKEND_BASE_URL}`;


export class TaskService {


/**
 * This method is in charge to save the related data of a questionnaire
 * @param {*} idPatient 
 * @param {*} taskInfo: it contains the taskId
 * @param {*} idQuestionnaire 
 * @param {*} answersList: list  of objects {"idQuestion": idQuestion,"idAnswer": idAnswer,"freeAnswerValue":"value"}.
                    }
 * @returns 
 */
   async getMoodQuestionnaireTask() {
    return  axios.get(API_URL + '/tasks/task/mood-questionnaire' ,{ headers: authHeader()})
    .then((response) => {
          return response;
        })
    .catch(function (error) {
          return  error;
        });
 }

/**
 * This method is in charge to save the related data of a questionnaire
 * @param {*} idPatient 
 * @param {*} taskInfo: it contains the taskId
 * @param {*} idQuestionnaire 
 * @param {*} answersList: list  of objects {"idQuestion": idQuestion,"idAnswer": idAnswer,"freeAnswerValue":"value"}.
                    }
 * @returns 
 */
  async getTaskById(taskId) {
    return axios.get(API_URL + '/tasks/'+taskId, { headers: authHeader() })
      .then((response) => {
        return response;
      })
      .catch(function (error) {
        return error;
      });
  }


  async retrieveTaskData(taskId,questionnaireType){
     if(taskId){
        return this.getTaskById(taskId);
     }
     if(questionnaireType === 'qt-dashboard'){
         return this.getMoodQuestionnaireTask();
     }
  }



}


export default new TaskService();
