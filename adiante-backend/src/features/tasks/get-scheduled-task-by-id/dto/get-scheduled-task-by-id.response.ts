import {GetScheduledTaskByIdStatus} from "../get-scheduled-task-by-id.enum";
export interface GetScheduledTaskByIdResponse {
  scheduledId: string;
  startDateTimeLocal: string;
  endDateTimeLocal: string;
  activityEntryId: string;
  patientId: string;
  status: GetScheduledTaskByIdStatus;
  }
