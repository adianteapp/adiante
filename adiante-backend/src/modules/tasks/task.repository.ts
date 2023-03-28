/**
 * This Repository  is to define all the queries related to retrieve the tasks master data. All the queries related to retrieve questionnaire master data must
 *  be addressed to the questionnaireRepository.
 */

import dao from "../../middleware/dao";
import {mapTask} from "./models/task.mapper";
import {Task} from './models/Task';

/**
*

@param {*} taskId

@returns {Task}
*/
export async function getTaskById(taskId: string): Promise<Task> {

const sqlQuery = `SELECT t.id, t.code_name, t.free_execution ,tt.code_name as 'task_type_code_name' FROM task t INNER JOIN task_type tt ON t.id_task_type = tt.id WHERE t.id = '${taskId}'`;

const queryResult = await dao.executeQuery(sqlQuery);

return mapTask(queryResult);
}

export default {
getTaskById
};





