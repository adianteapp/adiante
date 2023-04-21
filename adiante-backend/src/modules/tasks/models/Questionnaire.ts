import { QuestionnaireType } from "./QuestionnaireType";
import {Question} from './Question';

export class Questionnaire {
    id: number | undefined;
    questionnaireType: QuestionnaireType | undefined;
    questions: Question[] = [];
  }
  