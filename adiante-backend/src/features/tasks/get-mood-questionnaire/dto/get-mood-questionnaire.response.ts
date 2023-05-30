import { GetMoodQuestionnaireStatus } from "../get-mood-questionnaire.enum";

export interface GetMoodQuestionnaireResponse {
     questionnaire?:MoodQuestionnaire;
     status: GetMoodQuestionnaireStatus;
  }


 export interface MoodQuestionnaire {
   questionnaireId: string;
   questionnaireTypeId: string;
   questionnaireType: string;
   questions: Question[];
 }
 
 export interface Question {
   questionId: string;
   questionValue: string;
   questionType: string;
   answers: Answer[] | null;
 }
 
 export interface Answer {
   answerId: string;
   answerValue: string;
   answerRelatedTaskId: string | null;
 }

