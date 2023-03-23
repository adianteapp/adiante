const dao = require("../middleware/dao");



async function getPatientByUsername(userName) {

    const sqlQuery =   `SELECT id, name, email, password, createdAt, updatedAt 
                        FROM patient p  
                        WHERE p.email ='${userName}'`;

    const rows = await dao.executeQuery(sqlQuery);
  
    return       rows;
    }


  module.exports = {
    getPatientByUsername
};