/**
 * This Repository  is to define all the queries involved on the relationship between  patient and the tasks assigned to him or the ones that can be executed freely. It also includes the operations
 *  to save the execution of the activities.
 */
const dao = require("../../middleware/dao");
const util = require('util');

const loggerConfig = require("../../middleware/log4sConf");
const logger = loggerConfig.fileAppenderLogger;



async function getPatientByUsername(userName) {

    const sqlQuery =   `SELECT id, name, email, password, createdAt, updatedAt 
                        FROM patient p  
                        WHERE p.email ='${userName}'`;

    const rows = await dao.executeQuery(sqlQuery);
  
    return rows;
    }


/**
 * This function ins in charge to insert data related to task with task.type is not tt-questionnaire.
 */
async function insertPatientTaskEntry(patientActivityData){

}


/**
 * This function ins in charge to insert data related to task with task.type is tt-questionnaire.
 */
async function insertPatientTaskQuestionnaireEntry(patientActivityData){

  let connection;
  try {
    
    
    connection = await dao.getConnection();

    connection.beginTransaction();

    const sql = "INSERT INTO patient_activity_entry (entry_datetime, id_patient, id_task) VALUES(UTC_TIMESTAMP(), @p2, @p3);";
    const sqlWithValues = sql
      .replace("@p2", patientActivityData.idPatient)
      .replace("@p3", patientActivityData.idTask);
    const result1 = await connection.execute(sqlWithValues);
    const insertIdPatientActivityData = result1.insertId;


    const sqlQuestionnaireExecution = "INSERT INTO questionnaire_execution (id_questionnaire, id_patient_activy_entry)   VALUES(@id_questionnaire, @id_patient_activy_entry)";
    const sqlQuestionnaireExecutionWithValues = sqlQuestionnaireExecution
      .replace("@id_questionnaire", patientActivityData.questionnaireExecution.idQuestionnaire)
      .replace("@id_patient_activy_entry", insertIdPatientActivityData);
    const resultQuestionnaireExecution = await connection.execute(sqlQuestionnaireExecutionWithValues);
    const insertIdQuestionnaireExecution = resultQuestionnaireExecution.insertId;


    const sqlQuestionnaireExecutionAnswer = "INSERT INTO adiante.questionnaire_execution_answer (id_question, id_answer, id_questionnaire_execution) VALUES";
    let valueParamList  = "";
    for(  questionnaireExecutionAnswer of patientActivityData.questionnaireExecution.questionnaireExecutionAnswersList){
      
      const valueTuple = "(id_question, id_answer, id_questionnaire_execution)";

      const paramIdquestion = questionnaireExecutionAnswer.idQuestion;
      const paramIdAnswer = questionnaireExecutionAnswer.idAnswer;
      const paramIdQuestionnaireExecution = insertIdQuestionnaireExecution;


      const valueTupleReplaced =  valueTuple.replace("id_question",paramIdquestion)
                                            .replace("id_answer",paramIdAnswer)
                                            .replace("id_questionnaire_execution",paramIdQuestionnaireExecution);
      valueParamList = valueParamList+valueTupleReplaced+",";
    }
    valueParamList = valueParamList.substring(0, valueParamList.length - 1);
    let sqlQuestionnaireExecutionAnswerWithValues = sqlQuestionnaireExecutionAnswer+valueParamList;
    await connection.execute(sqlQuestionnaireExecutionAnswerWithValues);

    //await executeModifyQuery(connection, 'INSERT INTO table2 SET ?', {...data.table2Data, table1_id: insertId});
    await connection.commit();

    return true;
    
  } catch (err) {
      logger.error("Error on patientActivity.repository.insertPatientTaskQuestionnaireEntry():"+err);
    if (connection) {
      await connection.rollback();
    }
    return false;
  }finally {
    // Close database connection;
    await connection.end();
  }
}


  module.exports = {
    getPatientByUsername,insertPatientTaskEntry,insertPatientTaskQuestionnaireEntry
};