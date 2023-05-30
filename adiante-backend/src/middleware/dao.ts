// Required Modules
import dbConfig from '../config/db.config.js';
import Logger from '../config/logger'

//Logger imports


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
      Logger.error("Error:" + exception + " executing query:" + sqlQuery)
    }
    finally {
      if (conn) conn.release(); //release to pool
    }
  }

}
export default dao;