/** 
 * This Repository  is to define all the queries related to retrieve the questionnaire master data. It include the types and all the related questions/ansers.
 */

const dao = require("../../middleware/dao");



async function getQuestionnaireById(idQuestionnaire) {

    const sqlQuery =   `SELECT q.id  as 'id_questionnaire',qt.code_name as 'questionnaire_type',
                            qq.id as 'id_question', qqt.code_name as 'question_type',
                            a.id as 'id_answer'
                        FROM  questionnaire q 
                        INNER JOIN questionnaire_type qt on q.id_questionnaire_type  = qt.id
                        INNER JOIN question qq on qq.id_questionnaire = q.id
                        INNER JOIN question_type  qqt on  qq.id_question_type = qqt.id
                        LEFT OUTER JOIN answer a  on a.id_question = qq.id                        
                        WHERE q.id = '${idQuestionnaire}'`;

    const rows = await dao.executeQuery(sqlQuery);
  
    return  rows;
    }


  module.exports = {
    getQuestionnaireById
};