import { Questionnaire } from "../../../../features/shared/get-questionnaire/dto/get-questionnaire.response";
import { Task } from "../../../../features/shared/get-task/dto/get-task.response";
import { GetMoodQuestionnaireStatus } from "../get-mood-questionnaire.enum";

export interface GetMoodQuestionnaireResponse {
     task:Task
     questionnaire: Questionnaire
     status: GetMoodQuestionnaireStatus;
  }
