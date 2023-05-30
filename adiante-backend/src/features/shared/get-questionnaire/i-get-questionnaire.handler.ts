import { GetQuestionnaireRequest } from "./dto/get-questionnaire.request";
import { GetQuestionnaireResponse } from "./dto/get-questionnaire.response";

export interface IGetQuestionnaireHandler{
    execute( taskRequest: GetQuestionnaireRequest):Promise<GetQuestionnaireResponse>; 
}