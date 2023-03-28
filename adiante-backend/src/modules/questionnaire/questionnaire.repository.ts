/** 
 * This Repository  is to define all the queries related to retrieve the questionnaire master data. It include the types and all the related questions/ansers.
 */

import dao from "../../middleware/dao";

async function getQuestionnaireById(idQuestionnaire: string) {
  const sqlQuery = `SELECT q.id  as 'id_questionnaire', qt.code_name as 'questionnaire_type', qq.id as 'id_question', qqt.code_name as 'question_type', a.id as 'id_answer'
                    FROM questionnaire q
                    INNER JOIN questionnaire_type qt ON q.id_questionnaire_type = qt.id
                    INNER JOIN question qq ON qq.id_questionnaire = q.id
                    INNER JOIN question_type qqt ON qq.id_question_type = qqt.id
                    LEFT OUTER JOIN answer a ON a.id_question = qq.id
                    WHERE q.id = '${idQuestionnaire}'`;

  const rows = await dao.executeQuery(sqlQuery);

  return rows;
}

export default {
  getQuestionnaireById,
};
