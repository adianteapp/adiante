import * as dotenv from 'dotenv';
dotenv.config();

import { createPool } from 'mariadb';

// Pool configuration
const pool = createPool({
   host: `${process.env.DB_HOST}`,
   user: `${process.env.DB_USER}`,
   password: `${process.env.DB_PASS}`,
   database: `${process.env.DB_NAME}`,
   connectionLimit: 100
});

export default pool;
