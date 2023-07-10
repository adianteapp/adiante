require('dotenv').config()
import axios from 'axios';
import authHeader from './auth-header';

const API_URL = `${process.env.VUE_APP_BACKEND_BASE_URL}`;



class PatientService {


async  savePatientActivity(patientActivity) {
  return  axios.post(API_URL +'/activity/', patientActivity ,{ headers: authHeader()})
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
   async  saveQuestionnaire(taskId,idQuestionnaire,answersList) {
      const patientActivity = {
    executedTask:{
        idTask: taskId,
        filledQuestionnaire:{
          idQuestionnaire: idQuestionnaire,
          answersList: answersList
        }
      }
    }
   return this.savePatientActivity (patientActivity);
 }

  async saveConfirmationExecution(taskId, scheduledId) {
    const patientActivity = {
      executedTask: {
        idTask: taskId,
        idScheduledTask: scheduledId
      }
    }
    return this.savePatientActivity(patientActivity);
  }

}


export default new PatientService();
