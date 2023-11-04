import dao from '../../../middleware/dao';
import { GetPatientRequest } from './dto/get-patient.request';
import { GetPatientResponse } from './dto/get-patient.response';

import { injectable } from 'inversify/lib/annotation/injectable';
import { IGetPatientHandler } from './i-get-patient.handler';
import Logger from '../../../config/logger';

enum SearchCriteria {
    byId,
    byUserName
};

@injectable()
export class GetPatientHandler implements IGetPatientHandler {



    public async getPatientByCriteria(patientRequest: GetPatientRequest): Promise<GetPatientResponse> {
        let patient: GetPatientResponse = null;

        const searchCriteria = this.getSearchCriteria(patientRequest);

        switch (searchCriteria) {
            case SearchCriteria.byId:
                patient = await this.getPatientByPatientId(patientRequest);
                break;
            case SearchCriteria.byUserName:
                patient = await this.getPatientByUsername(patientRequest);
                break;
        }

        return patient;
    }


    private getSearchCriteria(patientRequest: GetPatientRequest): SearchCriteria {
        if (patientRequest.patientId != undefined) {
            return SearchCriteria.byId;
        } else {
            return SearchCriteria.byUserName;
        }

    }


    private async getPatientByUsername(patientRequest: GetPatientRequest): Promise<GetPatientResponse> {

        const sqlQuery = `SELECT p.id as 'patientId' , p.name, p.email , p.password  
                            FROM patient p   
                            WHERE p.email ='${patientRequest.email}'`;

        const rows = await dao.executeQuery(sqlQuery);

        return  this.mapRowToPatientResponse(rows);
    }

    private async getPatientByPatientId(patientRequest: GetPatientRequest): Promise<GetPatientResponse> {

        const sqlQuery = `SELECT p.id as 'patientId' , p.name, p.email , p.password  
                              FROM patient p  
                              WHERE p.id ='${patientRequest.patientId}'`;

        const rows = await dao.executeQuery(sqlQuery);

        return this.mapRowToPatientResponse(rows);
    }


    private async mapRowToPatientResponse(queryResult: any): Promise<GetPatientResponse> {
        let patientResponse: GetPatientResponse = undefined;

        if (queryResult && queryResult.length == 1) {

            patientResponse = {
                patientId: queryResult[0].patientId,
                password: queryResult[0].password,
                name: queryResult[0].name,
                email: queryResult[0].email,
            };
        }
        else {
            Logger.error("Error retrieving patient from database, non unique result was given");
        }
        return patientResponse;
    }


}



