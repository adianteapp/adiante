import { SaveAnswersRequest } from "./dto/save-answers.request";
import { SaveAnswersResponse } from "./dto/save-answers.response";

export interface ISaveAnswersHandler{
    execute(saveAnswersRequest:SaveAnswersRequest):Promise<SaveAnswersResponse>
} 