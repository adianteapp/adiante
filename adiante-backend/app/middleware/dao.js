// Required Modules
const config = require("../config/db.config.js");
const util = require('util');

//Logger imports
const loggerConfig = require("./log4sConf");
const logger = loggerConfig.fileAppenderLogger;

async function fetchConn() {
  let conn = await config.pool.getConnection();
  return conn;
}

module.exports = {

  getConnection: async function () {
    return fetchConn();
  },


  executeQuery: async function (sqlQuery) {
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