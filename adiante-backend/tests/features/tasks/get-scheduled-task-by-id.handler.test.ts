import { GetScheduledTaskByIdRequest } from '../../../src/features/tasks/get-scheduled-task-by-id/dto/get-scheduled-task-by-id.request'
import { GetScheduledTaskByIdResponse } from '../../../src/features/tasks/get-scheduled-task-by-id/dto/get-scheduled-task-by-id.response'
import { GetScheduledTaskByIdHandler } from '../../../src/features/tasks/get-scheduled-task-by-id/get-scheduled-task-by-id.handler';
import { GetScheduledTaskByIdStatus } from '../../../src/features/tasks/get-scheduled-task-by-id/get-scheduled-task-by-id.enum';
import { mock, when } from 'ts-mockito';




describe('GetScheduledTaskHandler', () => {
  let getScheduledTaskHandler: GetScheduledTaskByIdHandler;

  beforeEach(() => {
    getScheduledTaskHandler = new GetScheduledTaskByIdHandler();
  });

  describe('execute', () => {
    it('should return a successful response when the scheduled task exists', async () => {
      const scheduledId = '123';
      const request: GetScheduledTaskByIdRequest = { scheduledId };
      const expectedResponse: GetScheduledTaskByIdResponse = {
        status: GetScheduledTaskByIdStatus.Succesfull,
        scheduledId: '',
        startDateTimeLocal: '',
        endDateTimeLocal: '',
        activityEntryId: '',
        patientId: ''
      };
      const mockGetScheduledTaskByIDFromDB = jest.fn().mockResolvedValue(expectedResponse);
      getScheduledTaskHandler.getscheduledTaskByIDFromDB = mockGetScheduledTaskByIDFromDB;

      const response = await getScheduledTaskHandler.execute(request);

      expect(mockGetScheduledTaskByIDFromDB).toHaveBeenCalledWith(scheduledId);
      expect(response).toEqual(expectedResponse);
    });

    it('should return a not found response when the scheduled task does not exist', async () => {
      const scheduledId = '123';
      const request: GetScheduledTaskByIdRequest = { scheduledId };
      const expectedResponse: GetScheduledTaskByIdResponse = {
        status: GetScheduledTaskByIdStatus.ScheduledIdNotFound,
        scheduledId: '',
        startDateTimeLocal: '',
        endDateTimeLocal: '',
        activityEntryId: '',
        patientId: ''
      };
      const mockGetScheduledTaskByIDFromDB = jest.fn().mockResolvedValue(undefined);
      getScheduledTaskHandler.getscheduledTaskByIDFromDB = mockGetScheduledTaskByIDFromDB;

      const response = await getScheduledTaskHandler.execute(request);

      expect(mockGetScheduledTaskByIDFromDB).toHaveBeenCalledWith(scheduledId);
      expect(response).toEqual(expectedResponse);
    });
  });

  describe('getscheduledTaskByIDFromDB', () => {
    it('should return the scheduled task when it exists', async () => {
      const scheduledId = '123';
      const expectedResponse: GetScheduledTaskByIdResponse = {
        scheduledId: '',
        startDateTimeLocal: '',
        endDateTimeLocal: '',
        activityEntryId: '',
        patientId: '',
        status: GetScheduledTaskByIdStatus.Succesfull
      };
      const mockExecuteQuery = jest.fn().mockResolvedValue([{ id: scheduledId }]);
      getScheduledTaskHandler.dao.executeQuery = mockExecuteQuery;

      const response = await getScheduledTaskHandler.getscheduledTaskByIDFromDB(scheduledId);

      expect(mockExecuteQuery).toHaveBeenCalledWith(expect.any(String));
      expect(response).toEqual(expectedResponse);
    });

    it('should return undefined when the scheduled task does not exist', async () => {
      const scheduledId = '123';
      const mockExecuteQuery = jest.fn().mockResolvedValue([]);
      getScheduledTaskHandler.dao.executeQuery = mockExecuteQuery;

      const response = await getScheduledTaskHandler.getscheduledTaskByIDFromDB(scheduledId);

      expect(mockExecuteQuery).toHaveBeenCalledWith(expect.any(String));
      expect(response).toBeUndefined();
    });
  });
});