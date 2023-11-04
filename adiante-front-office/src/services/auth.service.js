import axios from 'axios';
import authHeader from './auth-header';

const API_URL = `${process.env.VUE_APP_BACKEND_BASE_URL}`+'/auth/';

class AuthService {
  


 login(user) {
    return  axios.post(API_URL + 'session', {
        username: user.username,
        password: user.password
      }).then((response) => {
        var user = JSON.stringify(response.data);
        localStorage.setItem('user', user );
       
        return user;
      })
      .catch(function (error) {
        return  error;
      });

  }


  async validateToken() {
    const validateToken = authHeader();
      if(validateToken){
        try {
          await axios.get(API_URL + 'session', { headers: validateToken });
          return true;
        } catch (error) {
          return false;
        }    
      }else return false;
   
  }


  logout() {
    localStorage.removeItem('user');
  }

}

export default new AuthService();
