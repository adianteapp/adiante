import {QuestionType} from './QuestionType';
import {Answer} from './Answer';
export class Question {
    id: number;
    idQuestionnaires: number;
    question_i18n: string;
    question_type: QuestionType;
    answers: Answer[];
  }