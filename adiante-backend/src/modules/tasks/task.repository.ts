/**
 * This Repository  is to define all the queries related to retrieve the tasks master data. All the queries related to retrieve questionnaire master data must
 *  be addressed to the questionnaireRepository.
 */

import dao from "../../middleware/dao";
import {mapTask} from "./models/task.mapper";
import { mapToTaskQuestionnaire } from "./models/task.mapper";
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

/**
 * 
 * @returns (*)
 */
export async function getMoodQuestionnaire(): Promise<Task> {

const sqlQuery = `SELECT t.id  as 'id_task',t.code_name as 'task_code_name',t.free_execution,
                        tt.id  as 'id_task_type',tt.code_name  as 'task_type',
                        q.id as 'id_questionnaire',  qt.id  as 'questionnaire_id_type', qt.code_name  as 'questionnaire_type',
                        q2.id as 'id_question',q2in.i18n_value as 'question_value',qt2.code_name 'question_type',
                        a.id  as 'id_answer', ain.i18n_value as 'answer_value'
                  FROM  task t
                  INNER JOIN task_type tt ON t.id_task_type = tt.id
                  INNER JOIN  task_questionnaire tq ON  tq.id_task = t.id 
                  INNER JOIN questionnaire q on tq.id_questionnaire = q.id 
                  INNER JOIN questionnaire_type qt on qt.id = q.id_questionnaire_type 
                  INNER JOIN question q2 on q.id = q2.id_questionnaire
                  INNER JOIN question_i18n q2in on q2.id = q2in.id_question 
                  INNER JOIN question_type qt2 on qt2.id = q2.id_question_type 
                  INNER JOIN answer a  on a.id_question = q2.id
                  INNER JOIN answer_i18n ain on a.id = ain.id_answer  
                  WHERE qt.code_name = 'qt-dashboard' and ain.id_language = 1 and q2in.id_language = 1`;

const queryResult = await dao.executeQuery(sqlQuery);

return mapToTaskQuestionnaire(queryResult);
}






export default {
getTaskById,
getMoodQuestionnaire
};





