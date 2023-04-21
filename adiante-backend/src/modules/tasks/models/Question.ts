import {QuestionType} from './QuestionType';
import {Answer} from './Answer';
export class Question {
    id: number | undefined;
    idQuestionnaires: number | undefined;
    i18n: string | undefined;
    questionType: QuestionType | undefined;
    answers: Answer[] = [];
  }