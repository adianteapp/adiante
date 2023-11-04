import { SaveAnswersStatus } from "../save-answers.enum";

export interface SaveAnswersResponse{
   status: SaveAnswersStatus;
   patientActivityEntryId?: string;
}