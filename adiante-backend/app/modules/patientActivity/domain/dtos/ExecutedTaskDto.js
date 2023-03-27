class ExecutedTaskDto {
  constructor(idTask, value, filledQuestionnaire) {
    this.idTask = idTask;
    this.value = value;
    this.filledQuestionnaire = filledQuestionnaire ;
  }
}
module.exports = ExecutedTaskDto;