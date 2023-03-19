require('dotenv').config()
import axios from 'axios';
import store from '../store/index';

const API_URL = `${process.env.VUE_APP_BACKEND_BASE_URL}`+'/api/auth/patient/';

class AuthService {
  


 login(user) {
    return  axios.post(API_URL + 'signin', {
        username: user.username,
        password: user.password
      }).then((response) => {
        
        localStorage.setItem('user', JSON.stringify(response.data));
        store.ac
        //auth.login(user);
        return response.data;
      })
      .catch(function (error) {
        return  error;
      });

  }


  logout() {
    localStorage.removeItem('user');
  }

  register(user) {
    return axios.post(API_URL + 'signup', {
      username: user.username,
      email: user.email,
      password: user.password
    });
  }
}

export default new AuthService();
