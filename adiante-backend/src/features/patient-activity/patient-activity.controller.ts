import * as express from 'express';
import { IPatientActivityController } from './i-patient-activity.controller';
import { inject } from 'inversify';
import { controller, httpPost } from 'inversify-express-utils';
import Logger from '../../config/logger';
import { ISaveAnswersHandler } from './save-answers/i-save-answers.handler';
import { SaveAnswersStatus } from './save-answers/save-answers.enum';
import verifyToken from '../../middleware/token-validation.middleware';
import { SaveAnswersRequest } from './save-answers/dto/save-answers.request';
import { SaveAnswersResponse } from './save-answers/dto/save-answers.response';

@controller("/activity")
export class PatientActivityController implements IPatientActivityController {

   @inject("ISaveAnswersHandler") private readonly _saveAnswersHandler: ISaveAnswersHandler;


   @verifyToken
   @httpPost("/")
   async saveActivity(req: express.Request, res: express.Response): Promise<void> {

      let saveAnswersRequest: SaveAnswersRequest = undefined;

      try {
         saveAnswersRequest = JSON.parse(JSON.stringify(req.body));
      } catch (Error) {
         Logger.error(`Error parsing req.body: ${req.body}`);
         res.status(400).send({ message: "Bad request", errorCode: 'Error parsing req.body' });
      }

      //Set the patientId after verifyToken validation
      saveAnswersRequest.patientId = req.params.patientId;

      const saveAnswersResponse: SaveAnswersResponse = await this._saveAnswersHandler.execute(saveAnswersRequest);

      switch (saveAnswersResponse.status) {
         case SaveAnswersStatus.Success:
            res.status(200).send();
            break;
         case SaveAnswersStatus.TaskValueMandatory:
            res.status(402).send({ message: "Task value mandatory", errorCode: SaveAnswersStatus.TaskValueMandatory });
            break;
         case SaveAnswersStatus.IncompleteQuestionnaireAnswers:
            res.status(402).send({ message: "Incomplete questionnaire answer", errorCode: SaveAnswersStatus.IncompleteQuestionnaireAnswers });
            break;
         case SaveAnswersStatus.PatientNotFound:
            res.status(422).send({ message: "Wrong data", errorCode: SaveAnswersStatus.PatientNotFound });
            break;
         case SaveAnswersStatus.InvalidTaskId:
            res.status(422).send({ message: "Invalid taskId", errorCode: SaveAnswersStatus.InvalidTaskId });
            break;
         case SaveAnswersStatus.IncompleteQuestionnaireId:
            res.status(422).send({ message: "Invalid questionnaireId", errorCode: SaveAnswersStatus.IncompleteQuestionnaireId });
            break;
        case SaveAnswersStatus.QuestionIdNotFound:
               res.status(422).send({ message: "QuestionID not found por provided taskId", errorCode: SaveAnswersStatus.QuestionIdNotFound });
               break;
        case SaveAnswersStatus.QuestionnaireIdNotFound:
                  res.status(422).send({ message: "QuestionnnaireID not found por provided taskId", errorCode: SaveAnswersStatus.QuestionnaireIdNotFound });
                  break;
         case SaveAnswersStatus.InternalError:
            Logger.error(`Internal error: patientActivityService.save(req.body): ${saveAnswersResponse}`);
            res.status(500).send({ message: "Internal server error" });
            break;
         default:
            Logger.error(`Unknown answer from patientActivityService.save(req.body): ${saveAnswersResponse}`);
            res.status(500).send({ message: "Internal server error" });
            break;
      }
   }



}