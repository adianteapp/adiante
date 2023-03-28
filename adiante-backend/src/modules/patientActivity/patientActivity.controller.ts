import { Request, Response } from 'express';
import * as patientActivityService from './patientActivity.service';

import  TaskRecordingStatusses  from "../patientActivity/patientActivity.enum";

import loggerConf from '../../middleware/log4sConf';
const logger = loggerConf.logger;

export const savePatientActivity = async (req: Request, res: Response) => {
  const saveResult = await patientActivityService.save(req.body);

  switch (saveResult.status) {
    case TaskRecordingStatusses.patRecOk:
      return res.status(200).send();

    case TaskRecordingStatusses.patRecErrTaskValueMandatory:
      return res.status(402).send({ message: "Task value mandatory", errorCode: TaskRecordingStatusses.patRecErrTaskValueMandatory });

    case TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers:
      return res.status(402).send({ message: "Incomplete questionnaire answer", errorCode: TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers });

    case TaskRecordingStatusses.patRecErrPatientNotFound:
      return res.status(422).send({ message: "Wrong data", errorCode: TaskRecordingStatusses.patRecErrPatientNotFound });

    case TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers:
      return res.status(402).send({ message: "Incomplete questionnaire answer", errorCode: TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers });

    case TaskRecordingStatusses.patRecErrInvalidTaskId:
      return res.status(422).send({ message: "Invalid taskId", errorCode: TaskRecordingStatusses.patRecErrInvalidTaskId });

    case TaskRecordingStatusses.patRecErrIncompleteQuestionnaireId:
      return res.status(422).send({ message: "Invalid questionnaireId", errorCode: TaskRecordingStatusses.patRecErrIncompleteQuestionnaireId });

    case TaskRecordingStatusses.patRecErrInternalError:
      return res.status(500).send({ message: "Internal server error" });

    default:
      logger.error(`Unknown answer from patientActivityService.save(req.body): ${saveResult}`);
      return res.status(500).send({ message: "Internal server error" });
  }
}
