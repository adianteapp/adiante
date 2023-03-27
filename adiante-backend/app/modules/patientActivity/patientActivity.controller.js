
const patientActivityService = require("./patientActivity.service");
const authService = require("../auth/auth.service");
const patientActivityEnum = require("./patientActivity.enum");

const loggerConfig = require("../../middleware/log4sConf");
const logger = loggerConfig.fileAppenderLogger;



  exports.savePatientActivity = async (req,res) => {
      

      const saveResult = await patientActivityService.save(req.body);

      switch  (saveResult.status){
            case patientActivityEnum.TaskRecordingStatusses.patRecOk:
                    //Recovery stats
                    // res
                    return res.status(200).send();

            case patientActivityEnum.TaskRecordingStatusses.patRecErrTaskValueMandatory:

                  return res.status(402).send({ message: "Task value mandatory", errorCode: patientActivityEnum.TaskRecordingStatusses.patRecErrTaskValueMandatory });

            case patientActivityEnum.TaskRecordingStatusses.patRecErrIncomp:
                    return res.status(402).send({ message: "Incomplete questionnaire answer", errorCode: patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers });

             case patientActivityEnum.TaskRecordingStatusses.patRecErrPatientNotFound:
                return res.status(422).send({ message: "Wrong data", errorCode: patientActivityEnum.TaskRecordingStatusses.patRecErrPatientNotFound });

             case patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers:
                    return res.status(402).send({ message: "Incomplete questionnaire answer", errorCode: patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireAnswers });

            case patientActivityEnum.TaskRecordingStatusses.patRecErrInvalidTaskId:
                      return res.status(422).send({ message: "Invalid taskId", errorCode: patientActivityEnum.TaskRecordingStatusses.patRecErrInvalidTaskId });

            case patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireId:
                      return res.status(422).send({ message: "Invalid questionnaireId", errorCode: patientActivityEnum.TaskRecordingStatusses.patRecErrIncompleteQuestionnaireId });  
            case patientActivityEnum.TaskRecordingStatusses.patRecErrInternalError:
                      return res.status(500).send({ message: "Internal server error"});  
            
            default:
                      logger.error("Unknow answer from patientActivityService.save(req.body):"+saveResult);
                      return res.status(500).send({ message: "Internal server error"});  
      }
}
