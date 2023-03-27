const TaskType = require("./TaskType");
const Task = require("./Task");
/**
 * 
 * @param {*} taskId 
 * @returns {Task}
 */
async function mapTask(taskRowResults) {

    let task = null;
   if( taskRowResults && taskRowResults.length > 0){

    taskRowResults.map(result => {

        const taskType = new TaskType(result.task_type_code_name);
        task = new Task(result.id, result.code_name, result.free_execution, result.updatedAt, taskType);
        
      });
   }
   return task;
}


module.exports = {
       mapTask
    };