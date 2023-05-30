class PatientScheduledTask {
    taskId: number;
    title: string;
    description: string;
    startDateTimeLocal: Date;
    endDateTimeLocal : Date;

    constructor( taskId: number,title: string, description: string,startDateTimeLocal: Date, endDateTimeLocal : Date) {
        this.taskId = taskId;
        this.title = title;
        this.description = description;
        this.startDateTimeLocal = startDateTimeLocal;
        this.endDateTimeLocal = endDateTimeLocal;
    }
  }
  
  export default PatientScheduledTask;