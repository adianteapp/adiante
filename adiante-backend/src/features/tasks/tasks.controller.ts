import { Request, Response } from 'express';

import * as express from 'express';
import { controller, httpGet, httpPost, request, response } from "inversify-express-utils";
import { ITasksController } from './i-tasks.controller';
import { inject } from 'inversify/lib/annotation/inject';

import { IGetScheduledTaskHandler } from './get-scheduled-tasks/i-get-scheduled-task.handler';
import { GetScheduledTasksRequest } from './get-scheduled-tasks/dto/get-scheduled-task.request';
import { GetScheduledTasksResponse } from './get-scheduled-tasks/dto/get-scheduled-task.response';
import { GetScheduledTasksStatus } from './get-scheduled-tasks/get-scheduled-task.enum';

import { IGetTaskHandler } from '../shared/get-task/i-get-task.handler';
import { GetTaskRequest } from '../shared/get-task/dto/get-task.request';
import { GetTaskResponse } from '../shared/get-task/dto/get-task.response';
import { GetTaskStatus } from '../shared/get-task/get-task.enum';
import { IGetMoodQuestionnaireHandler } from './get-mood-questionnaire/i-get-mood-questionnaire.handler';
import { GetMoodQuestionnaireRequest } from './get-mood-questionnaire/dto/get-mood-questionnaire.request';
import { GetMoodQuestionnaireStatus } from './get-mood-questionnaire/get-mood-questionnaire.enum';
import { GetMoodQuestionnaireResponse } from './get-mood-questionnaire/dto/get-mood-questionnaire.response';
import verifyToken from '../../middleware/token-validation.middleware';
import { IGetTasksByTypeHandler } from './get-tasks-by-type/i-get-task-by-type.handler';
import { GetTasksByTypeStatus } from './get-tasks-by-type/get-tasks-by-type.enum';
import { GetTasksByTypeRequest } from './get-tasks-by-type/dto/get-tasks-by-type.request';
import { GetTasksByTypeResponse } from './get-tasks-by-type/dto/get-tasks-by-type.response';



@controller("/tasks")
export class TasksController implements ITasksController {

  @inject("IGetScheduledTaskHandler") private readonly _getScheduledTaskHandler: IGetScheduledTaskHandler;
  @inject("IGetTaskHandler") private readonly _getTaskHandler: IGetTaskHandler;
  @inject("IGetMoodQuestionnaireHandler") private readonly _getMoodQuestionnaire: IGetMoodQuestionnaireHandler;
  @inject("IGetTasksByTypeHandler") private readonly _getTasksByTypeHandler: IGetTasksByTypeHandler;

// GENERATE tests for all endpoints


  @verifyToken
  @httpGet("/scheduled-task")
  async getScheduledTasks(@request() req: express.Request, @response() res: express.Response): Promise<void> {

    const getScheduledTaskRequest: GetScheduledTasksRequest = { selectedDate: req.query.selectedDate, patientId: req.params.patientId } as GetScheduledTasksRequest

    const getScheduledTaskResponse: GetScheduledTasksResponse = await this._getScheduledTaskHandler.execute(getScheduledTaskRequest);

    switch (getScheduledTaskResponse.status) {
      case GetScheduledTasksStatus.Succesfull:
        if (getScheduledTaskResponse.tasksList && getScheduledTaskResponse.tasksList.length > 0) {
          res.status(200).send(getScheduledTaskResponse);
        } else {
          res.status(204).send({ message: "No content" });
        }
        break;
      case GetScheduledTasksStatus.MissedSelectedDate:
        res.status(400).send({ message: "Missed selectedDate", errorCode: GetScheduledTasksStatus.MissedSelectedDate });
        break;
      case GetScheduledTasksStatus.InvalidSelectedDate:
        res.status(400).send({ message:  "Invalid selectedDate", errorCode: GetScheduledTasksStatus.InvalidSelectedDate });
        break;
      case GetScheduledTasksStatus.MissedPatientId:
        res.status(400).send({ message:  "Missed patientId", errorCode: GetScheduledTasksStatus.MissedPatientId });
        break;
      case GetScheduledTasksStatus.PatientIdNotFound:
        res.status(404).send({ message:  "PatientId id not found", errorCode: GetScheduledTasksStatus.PatientIdNotFound });
        break;
      default:
        res.status(500).send({ message: "Internal server error!" });
    }

  }

  @verifyToken
  @httpGet("/type/:selectedTaskType")
  async getTasksByType(@request() req: express.Request, @response() res: express.Response): Promise<void> {

    const getTasksByTypeRequest: GetTasksByTypeRequest = { taskType: req.params.selectedTaskType, patientId: req.params.patientId } as GetTasksByTypeRequest

    const getTasksByTypeResponse: GetTasksByTypeResponse = await this._getTasksByTypeHandler.execute(getTasksByTypeRequest);

    switch (getTasksByTypeResponse.status) {
      case GetTasksByTypeStatus.Succesfull:
        if (getTasksByTypeResponse.tasksList && getTasksByTypeResponse.tasksList.length > 0) {
          res.status(200).send(getTasksByTypeResponse);
        } else {
          res.status(204).send({ message: "No content" });
        }
        break;
      case GetTasksByTypeStatus.InvalidTaskType:
        res.status(400).send({ message:  "Invalid taskType", errorCode: GetTasksByTypeStatus.InvalidTaskType });
        break;
      case GetTasksByTypeStatus.PatientIdNotFound:
        res.status(404).send({ message:  "PatientId id not found", errorCode: GetTasksByTypeStatus.PatientIdNotFound });
        break;
      default:
        res.status(500).send({ message: "Internal server error!" });
    }

  }


  @verifyToken
  @httpGet("/:id")
  async getTaskById(@request() req: express.Request, @response() res: express.Response): Promise<void> {

    const getTaskRequest: GetTaskRequest = { taskId: req.params.id, patientId: req.params.patientId } as GetTaskRequest

    const getTaskResponse: GetTaskResponse = await this._getTaskHandler.execute(getTaskRequest);
    
    switch (getTaskResponse.status) {
      case GetTaskStatus.Succesfull:
        if (getTaskResponse.task != undefined) {
          res.status(200).send(getTaskResponse);
        } else {
          res.status(204).send({ message: "No content" });
        }
        break;
      case GetTaskStatus.MissedCriteria:
        res.status(400).send({ message: "Missed any criteria filter", errorCode: GetTaskStatus.MissedCriteria });
        break;
      case GetTaskStatus.MissedPatientId:
        res.status(400).send({ message:  "Missed patientId", errorCode: GetTaskStatus.MissedPatientId });
        break;
      case GetTaskStatus.PatientIdNotFound:
        res.status(404).send({ message:  "PatientId id not found", errorCode: GetTaskStatus.PatientIdNotFound });
        break;
      default:
        res.status(500).send({ message: "Internal server error!" });
    }

  }

    @verifyToken
    @httpGet("/task/mood-questionnaire")
    async getMoodQuestionnaire  ( req: express.Request, res: express.Response): Promise<void>{

    const patientId :string = req.params.patientId !== undefined ? req.params.patientId:undefined;
    const getMoodRequest: GetMoodQuestionnaireRequest = { patientId: patientId} as GetMoodQuestionnaireRequest

    const getMoodQuestionnaireResponse: GetMoodQuestionnaireResponse = await this._getMoodQuestionnaire.execute(getMoodRequest);
    
    switch (getMoodQuestionnaireResponse.status) {
      case GetMoodQuestionnaireStatus.Succesfull:
        res.status(200).send(getMoodQuestionnaireResponse);
        break;
      case GetMoodQuestionnaireStatus.NoContent:
        res.status(204).send({ message: "No content" });
        break;
      case GetMoodQuestionnaireStatus.MissedPatientId:
        res.status(400).send({ message:  "Missed patientId", errorCode: GetTaskStatus.MissedPatientId });
        break;
      default:
        res.status(500).send({ message: "Internal server error!" });
        break;
    }
  }
}


