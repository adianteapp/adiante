import { GetQuestionnaireStatus } from "../get-questionnaire.enum";

export interface GetQuestionnaireResponse {
     questionnaire?:Questionnaire;
     status: GetQuestionnaireStatus;
  }


 export interface Questionnaire {
   questionnaireId: string;
   questionnaireTypeId: string;
   questionnaireType: string;
   questions: Question[];
 }
 
 export interface Question {
   questionId: string;
   questionValue: string;
   questionType: string;
   questionnaireId: string;
   answers: Answer[] | null;
 }
 
 export interface Answer {
   answerId: string;
   questionId: string;
   answerValue: string;
   answerRelatedTaskId: string | null;
 }

