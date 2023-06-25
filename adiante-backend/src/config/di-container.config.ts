import { Container } from 'inversify';
import {ILoginHandler } from '../features/auth/login/i-login.handler';
import { LoginHandler } from '../features/auth/login/login.handler';
import { IAuthController } from '../features/auth/i-auth.controller';
import { AuthController } from '../features/auth/auth.controller';
import { IGetPatientHandler } from '../features/shared/get-patient/i-get-patient.handler';
import { GetPatientHandler } from '../features/shared/get-patient/get-patient.handler';
import { TasksController } from '../features/tasks/tasks.controller';
import { ITasksController } from '../features/tasks/i-tasks.controller';
import { IGetScheduledTaskHandler } from '../features/tasks/get-scheduled-tasks/i-get-scheduled-task.handler';
import { GetScheduledTaskHandler } from '../features/tasks/get-scheduled-tasks/get-scheduled-task.handler';
import { IGetTaskHandler } from '../features/shared/get-task/i-get-task.handler';
import { GetTaskHandler } from '../features/shared/get-task/get-task.handler';
import { IGetTaskAttributesHandler } from '../features/shared/get-task-attributes/i-get-task-attributes.handler';
import { IGetQuestionnaireHandler } from '../features/shared/get-questionnaire/i-get-questionnaire.handler';
import { GetQuestionnaireHandler } from '../features/shared/get-questionnaire/get-questionnaire.handler';
import { GetTaskAttributesHandler } from '../features/shared/get-task-attributes/get-task-attributes.handler';
import { GetMoodQuestionnaireHandler } from '../features/tasks/get-mood-questionnaire/get-mood-questionnaire.handler';
import { IGetMoodQuestionnaireHandler } from '../features/tasks/get-mood-questionnaire/i-get-mood-questionnaire.handler';
import { IPatientActivityController } from '../features/patient-activity/i-patient-activity.controller';
import { PatientActivityController } from '../features/patient-activity/patient-activity.controller';
import { IPreparePatientActivityHandler } from '../features/patient-activity/save-answers/prepare-patient-activity/i-prepare-patient-activity.handler';
import { PreparePatientActivityHandler } from '../features/patient-activity/save-answers/prepare-patient-activity/prepare-patient-activity.handler';
import { ISaveAnswersHandler } from '../features/patient-activity/save-answers/i-save-answers.handler';
import { SaveAnswersHandler } from '../features/patient-activity/save-answers/save-answers.handler';
import { IGetTasksByTypeHandler } from '../features/tasks/get-tasks-by-type/i-get-task-by-type.handler';
import { GetTasksByTypeHandler } from '../features/tasks/get-tasks-by-type/get-task-by-type.handler';
class DiContainer {
  private container: Container;

  constructor() {
    this.container = new Container();
    this.configureHandlers();
    this.configureControllers();
  }

  private configureControllers(): void {
    this.container.bind<IAuthController>("IAuthController").to(AuthController).inRequestScope;
    this.container.bind<ITasksController>("ITasksController").to(TasksController).inRequestScope;
    this.container.bind<IPatientActivityController>("IPatientActivityController").to(PatientActivityController).inRequestScope;
  }

  private configureHandlers(): void {
    this.container.bind<ILoginHandler>("ILoginHandler").to(LoginHandler).inRequestScope;
    this.container.bind<IGetPatientHandler>("IGetPatientHandler").to(GetPatientHandler).inRequestScope;
    this.container.bind<IGetScheduledTaskHandler>("IGetScheduledTaskHandler").to(GetScheduledTaskHandler).inRequestScope;
    this.container.bind<IGetTaskHandler>("IGetTaskHandler").to(GetTaskHandler).inRequestScope;
    this.container.bind<IGetTaskAttributesHandler>("IGetTaskAttributesHandler").to(GetTaskAttributesHandler).inRequestScope;
    this.container.bind<IGetQuestionnaireHandler>("IGetQuestionnaireHandler").to(GetQuestionnaireHandler).inRequestScope;
    this.container.bind<IGetMoodQuestionnaireHandler>("IGetMoodQuestionnaireHandler").to(GetMoodQuestionnaireHandler).inRequestScope;
    this.container.bind<IPreparePatientActivityHandler>("IPreparePatientActivityHandler").to(PreparePatientActivityHandler).inRequestScope;
    this.container.bind<ISaveAnswersHandler>("ISaveAnswersHandler").to(SaveAnswersHandler).inRequestScope;
    this.container.bind<IGetTasksByTypeHandler>("IGetTasksByTypeHandler").to(GetTasksByTypeHandler).inRequestScope;
  }


  public getContainer(): Container {
    return this.container;
  }
}

export default DiContainer;
