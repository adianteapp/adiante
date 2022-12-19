const dao = require("../middleware/dao");



async function getPatientByUsername(userName) {

    const sqlQuery =   `SELECT id, username, email, password, createdAt, updatedAt 
                        FROM users u  
                        WHERE u.username ='${userName}'`;

    const rows = await dao.executeQuery(sqlQuery);
  
    return       rows;
    }


  module.exports = {
    getPatientByUsername
};