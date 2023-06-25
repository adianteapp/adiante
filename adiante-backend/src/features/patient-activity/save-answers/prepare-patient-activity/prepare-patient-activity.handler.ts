import { injectable } from "inversify";
import { FilledQuestionnaire } from "../dto/save-answers.request";
import { PreparePatientActivityRequest } from "./dto/prepare-patient-activity.request";
import { PatientActivityEntry, PreparePatientActivityResponse, QuestionnaireExecution, QuestionnaireExecutionAnswer } from "./dto/prepare-patient-activity.response";
import { IPreparePatientActivityHandler } from "./i-prepare-patient-activity.handler";

@injectable()
export class PreparePatientActivityHandler implements IPreparePatientActivityHandler{

    async execute(preparePatientActivityRequest: PreparePatientActivityRequest):Promise<PreparePatientActivityResponse>{
        let patientActivityEntry:  PatientActivityEntry =
        {
            idPatient : preparePatientActivityRequest.patientActivityData.patientId,
            idTask : preparePatientActivityRequest.patientActivityData.executedTask.idTask
        } as PatientActivityEntry

        if(preparePatientActivityRequest.patientActivityData.executedTask.filledQuestionnaire != undefined){
            patientActivityEntry.questionnaireExecution = await this.getPatientQuestionnaireData(preparePatientActivityRequest.patientActivityData.executedTask.filledQuestionnaire);
        }


        return {patientActivityEntry: patientActivityEntry} as PreparePatientActivityResponse;
    }

    
    async  getPatientQuestionnaireData(filledQuestionnaire: FilledQuestionnaire): Promise<QuestionnaireExecution> {

        let questionnaireExecutionAnswerList: QuestionnaireExecutionAnswer[] = [];

        for (const answer of filledQuestionnaire.answersList) {
    
        const freeAnswerValue = answer.answerFreeValue ? answer.answerFreeValue : null;
        questionnaireExecutionAnswerList.push( { idQuestion: answer.idQuestion, freeAnswerValue: freeAnswerValue, idAnswer:answer.idAnswer} as QuestionnaireExecutionAnswer);
        }

        const questionnaireExecution:QuestionnaireExecution  = {idQuestionnaire: filledQuestionnaire.idQuestionnaire, questionnaireExecutionAnswersList:questionnaireExecutionAnswerList} as QuestionnaireExecution;
        return questionnaireExecution;
    }
 
}