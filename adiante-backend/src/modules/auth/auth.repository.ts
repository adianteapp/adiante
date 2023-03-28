import  dao from '../../middleware/dao';



async function getPatientByUsername(userName: string) {

    const sqlQuery =   `SELECT id, name, email, password, createdAt, updatedAt 
                        FROM patient p  
                        WHERE p.email ='${userName}'`;

    const rows = await dao.executeQuery(sqlQuery);
  
    return rows;
    }

async function getPatientByPatientId(patientId: string) {

      const sqlQuery =   `SELECT id, name, email, password, createdAt, updatedAt 
                          FROM patient p  
                          WHERE p.id ='${patientId}'`;
  
      const rows = await dao.executeQuery(sqlQuery);
    
      return rows;
      }
  


  export {
    getPatientByUsername,getPatientByPatientId
};