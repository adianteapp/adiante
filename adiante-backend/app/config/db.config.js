require('dotenv').config()
const dbDialect = require(`${process.env.DB_DIALECT}`);

// Pool configuration
const pool = dbDialect.createPool({
   host: `${process.env.DB_HOST}`,
   user: `${process.env.DB_USER}`,
   password: `${process.env.DB_PASS}`,
   database: `${process.env.DB_NAME}`,
   connectionLimit: 100
});

module.exports = {
  pool
};
