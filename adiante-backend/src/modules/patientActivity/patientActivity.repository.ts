import dao from "../../middleware/dao";

import Logger from '../../config/logger';

async function getPatientByUsername(userName: string): Promise<any> {
  const sqlQuery = `SELECT id, name, email, password, createdAt, updatedAt FROM patient p WHERE p.email ='${userName}'`;
  const rows = await dao.executeQuery(sqlQuery);
  return rows;
}


async function getPatientScheduledTasks(patientId: string , startDate: Date ,endDate:Date): Promise<any> {

  const sqlQuery =`SELECT t.id AS 'taskId', tin.title_i18n AS 'taskTitle', tin.description_i18n AS 'taskDescription',
                    CONVERT_TZ(pst.start_datetime, '+00:00', @@session.time_zone) AS 'startDateTimeLocal',
                    CONVERT_TZ(pst.end_datetime, '+00:00', @@session.time_zone) AS 'endDateTimeLocal'
                  FROM adiante.patient_scheduled_task pst
                  INNER JOIN task t ON pst.id_task = t.id
                  INNER JOIN task_i18n tin ON t.id = tin.id_task
                  WHERE pst.id_patient = '${patientId}'
                  AND pst.start_datetime >= '${startDate}'
                  AND pst.end_datetime <  '${endDate}'`;

  const rows = await dao.executeQuery(sqlQuery);
  return rows;
}





async function insertPatientTaskEntry(patientActivityData: any): Promise<boolean> {
  // TODO: implementar esta función
  return false;
}

async function insertPatientTaskQuestionnaireEntry(patientActivityData: any): Promise<boolean> {
  let connection: any;
  try {
          connection = await dao.getConnection();
          connection.beginTransaction();


          const sql = "INSERT INTO patient_activity_entry (entry_datetime, id_patient, id_task) VALUES(UTC_TIMESTAMP(), @p2, @p3);";
          const sqlWithValues = sql
            .replace("@p2", patientActivityData.idPatient)
            .replace("@p3", patientActivityData.idTask);
          const result1 = await connection.execute(sqlWithValues);
          const insertIdPatientActivityData = result1.insertId;



          const sqlQuestionnaireExecution = "INSERT INTO questionnaire_execution (id_questionnaire, id_patient_activy_entry) VALUES(@id_questionnaire, @id_patient_activy_entry)";
          const sqlQuestionnaireExecutionWithValues = sqlQuestionnaireExecution
            .replace("@id_questionnaire", patientActivityData.questionnaireExecution.idQuestionnaire)
            .replace("@id_patient_activy_entry", insertIdPatientActivityData);
          const resultQuestionnaireExecution = await connection.execute(sqlQuestionnaireExecutionWithValues);
          const insertIdQuestionnaireExecution = resultQuestionnaireExecution.insertId;



          const sqlQuestionnaireExecutionAnswer = "INSERT INTO questionnaire_execution_answer (id_question, id_answer, id_questionnaire_execution) VALUES";
          let valueParamList = "";
          for (const questionnaireExecutionAnswer of patientActivityData.questionnaireExecution.questionnaireExecutionAnswersList) {
            const valueTuple = "(id_question, id_answer, id_questionnaire_execution)";

            const paramIdquestion = questionnaireExecutionAnswer.idQuestion;
            const paramIdAnswer = questionnaireExecutionAnswer.idAnswer;
            const paramIdQuestionnaireExecution = insertIdQuestionnaireExecution;

            const valueTupleReplaced = valueTuple
              .replace("id_question", paramIdquestion)
              .replace("id_answer", paramIdAnswer)
              .replace("id_questionnaire_execution", paramIdQuestionnaireExecution);
            valueParamList = valueParamList + valueTupleReplaced + ",";
          }
          valueParamList = valueParamList.substring(0, valueParamList.length - 1);
          let sqlQuestionnaireExecutionAnswerWithValues = sqlQuestionnaireExecutionAnswer + valueParamList;
          await connection.execute(sqlQuestionnaireExecutionAnswerWithValues);


          
          //await executeModifyQuery(connection, 'INSERT INTO table2 SET ?', {...data.table2Data, table1_id: insertId});
          await connection.commit();

          return true;
  } catch (err) {
    Logger.error("Error on patientActivity.repository.insertPatientTaskQuestionnaireEntry():" + err);
    if (connection) {
      await connection.rollback();
    }
    return false;
  } finally {
    // Close database connection;
    await connection.end();
  }
}

export { getPatientByUsername, insertPatientTaskEntry, insertPatientTaskQuestionnaireEntry,getPatientScheduledTasks };
