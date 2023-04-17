import { QuestionnaireType } from "./QuestionnaireType";
import {Question} from './Question';

export class Questionnaire {
    id: number;
    questionnaire_type: QuestionnaireType;
    questions: Question[];
  }
  