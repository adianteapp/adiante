require('dotenv').config()
import axios from 'axios';

const API_URL = `${process.env.VUE_APP_BACKEND_BASE_URL}`+'/auth/';

class AuthService {
  


 login(user) {
    return  axios.post(API_URL + 'signin', {
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


  logout() {
    localStorage.removeItem('user');
  }

}

export default new AuthService();
