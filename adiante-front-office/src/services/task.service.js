require('dotenv').config()
import axios from 'axios';
import authHeader from './auth-header';

const API_URL = `${process.env.VUE_APP_BACKEND_BASE_URL}`;



class TaskService {


/**
 * This method is in charge to save the related data of a questionnaire
 * @param {*} idPatient 
 * @param {*} taskInfo: it contains the taskId
 * @param {*} idQuestionnaire 
 * @param {*} answersList: list  of objects {"idQuestion": idQuestion,"idAnswer": idAnswer,"freeAnswerValue":"value"}.
                    }
 * @returns 
 */
   async getMoodQuestionnaireTask(idPatient) {
    return  axios.get(API_URL + '/'+ idPatient +'/tasks/questionnaires/get-mood' ,{ headers: authHeader()})
    .then((response) => {
          return response;
        })
    .catch(function (error) {
          return  error;
        });
 }
}


export default new TaskService();
