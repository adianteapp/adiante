/**
 * This Repository  is to define all the queries related to retrieve the tasks master data. All the queries related to retrieve questionnaire master data must
 *  be addressed to the questionnaireRepository.
 */

const dao = require("../../middleware/dao");
const taskMapper = require("../tasks/models/task.mapper");
/**
 * 
 * @param {*} taskId 
 * @returns {Task}
 */
async function getTaskById(taskId) {

    const sqlQuery =   `SELECT t.id, t.code_name, t.free_execution ,tt.code_name as 'task_type_code_name'
                        FROM task t
                        INNER JOIN task_type tt ON t.id_task_type  = tt.id
                        WHERE t.id = '${taskId}'`;

    
    const queryResult = await dao.executeQuery(sqlQuery);
  
    return taskMapper.mapTask(queryResult);
    }


  module.exports = {
    getTaskById
};