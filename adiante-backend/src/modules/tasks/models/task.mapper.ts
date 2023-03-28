import { TaskType } from "./TaskType";
import { Task } from "./Task";

/**
 * @param {any} taskRowResults 
 * @returns {Task}
 */
export async function mapTask(taskRowResults: any): Promise<Task> {

    let task: Task | null = null;
    
    if (taskRowResults && taskRowResults.length > 0) {
        taskRowResults.map((result: any) => {
            const taskType = new TaskType(result.task_type_code_name);
            task = new Task(result.id, result.code_name, result.free_execution, result.updatedAt, taskType);
        });
    }
    return task!;
}

