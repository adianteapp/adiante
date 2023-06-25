import { GetMoodQuestionnaireRequest } from "./dto/get-mood-questionnaire.request";
import { GetMoodQuestionnaireResponse } from "./dto/get-mood-questionnaire.response";

export interface IGetMoodQuestionnaireHandler{
    execute( taskRequest: GetMoodQuestionnaireRequest):Promise<GetMoodQuestionnaireResponse>; 
}