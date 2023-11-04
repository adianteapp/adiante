
import { GetPatientRequest } from './dto/get-patient.request';
import { GetPatientResponse } from './dto/get-patient.response';

export interface IGetPatientHandler {

  getPatientByCriteria(patientRequest: GetPatientRequest): Promise<GetPatientResponse>;
}