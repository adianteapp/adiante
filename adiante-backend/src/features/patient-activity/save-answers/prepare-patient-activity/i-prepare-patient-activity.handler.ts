import { PreparePatientActivityRequest } from "./dto/prepare-patient-activity.request";
import { PreparePatientActivityResponse } from "./dto/prepare-patient-activity.response";

export interface IPreparePatientActivityHandler{
    execute(preparePatientActivityRequest: PreparePatientActivityRequest):Promise<PreparePatientActivityResponse>;
}