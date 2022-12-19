// Required Modules
const config = require("../config/db.config.js");

// Fetch Connection
async function fetchConn() {
  let conn = await config.pool.getConnection();
  return conn;
}



///
///
///
async function executeQuery( sqlQuery) { 
  let conn;
  try {

	conn = await fetchConn();

	const rows = await conn.query(sqlQuery);
  
  return rows;
  } finally {
	if (conn) conn.release(); //release to pool
  }
}

module.exports = {
  executeQuery
};
