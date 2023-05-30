import { GetQuestionnaireStatus } from "../get-questionnaire.enum";

export interface GetQuestionnaireResponse {
     questionnaire?:Questionnaire;
     status: GetQuestionnaireStatus;
  }


 export interface Questionnaire {
   questionnaireId: number;
   questionnaireTypeId: number;
   questionnaireType: string;
   questions: Question[];
 }
 
 export interface Question {
   questionId: number;
   questionValue: string;
   questionType: string;
   answers: Answer[] | null;
 }
 
 export interface Answer {
   answerId: number;
   answerValue: string;
   answerRelatedTaskId: number | null;
 }

