class Task {
  constructor(id, codeName, freeExecution, updatedAt, taskType) {
    this.id = id;
    this.codeName = codeName;
    this.freeExecution = freeExecution;
    this.updatedAt = updatedAt;
    this.taskType = taskType;
  }
}
module.exports = Task;