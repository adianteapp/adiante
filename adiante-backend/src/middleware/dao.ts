// Required Modules
import dbConfig from '../config/db.config.js';


//Logger imports
const loggerConfig = require("./log4sConf");
const logger = loggerConfig.fileAppenderLogger;

async function fetchConn() {
  let conn = await dbConfig.getConnection();
  return conn;
}

const dao = {

  getConnection: async function () {
    return fetchConn();
  },


  executeQuery: async function (sqlQuery:string) {
    let conn;
    try {

      conn = await fetchConn();

      const rows = await conn.query(sqlQuery);

      return rows;
    } catch (exception) {
      logger.error("Error:" + exception + " executing query:" + sqlQuery)
    }
    finally {
      if (conn) conn.release(); //release to pool
    }
  }

}
export default dao;