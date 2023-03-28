import {ExecutedTaskDto} from './ExecutedTaskDto';

class PatientExecutionDto {
  idPatient: number;
  executedTask: ExecutedTaskDto;

  constructor(idPatient: number, executedTask: ExecutedTaskDto) {
    this.idPatient = idPatient;
    this.executedTask = executedTask;
  }
}

export default PatientExecutionDto;
