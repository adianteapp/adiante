<template>
  <div class="login">
    <div class="content">
      <div class="login-form">

     
      <img alt="logo" class="logo" src="../assets/img/svg/logo.svg"/> 
      <div v-if="loginError != undefined" class="alert error">{{loginError}}</div>
      <form @submit.prevent="handleLogin">
        <div class="form-login">
          <div class="mb-3">
            <label for="InputEmail1" class="form-label">{{ $t('loginform_label_user') }}</label>
            <input type="text"  v-model="username" class="form-control" id="InputEmail1" aria-describedby="emailHelp">
           </div>
          <div class="mb-4">
            <label for="InputPassword1" class="form-label">{{ $t('loginform_label_pwd') }}</label>
            <input type="password" v-model="password" class="form-control" id="InputPassword1">
          </div>
          <button type="submit" class="btn btn-primary w-100">{{ $t('loginform_button_access') }} <i class="icon-navigate_next"></i></button>
        </div>
      </form>
    </div>
      <div class="lost-pwd">
        <button type="submit" class="btn btn-outline-primary w-100 mt-4">{{ $t('loginform_label_forgotpwd') }}</button>
      </div>

      
      <div class="about">

        <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Licencia de Creative Commons" style="border-width:0" src="../../public/img/licencia.png" /></a><br /> <small> Esta aplicación est&aacute; bajo una <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">licencia de Creative Commons Reconocimiento-NoComercial-SinObraDerivada 4.0 Internacional</a></small>.
        
      </div>

    </div>
  </div>
</template>


<script>
import authService from "../services/auth.service";
export default {
  name: "Login",
  data() {
            return {
              username:null,
              password:null,
              loginError: null
            }
        },
  components: {},
  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    },
  },
  created() {
    if (this.loggedIn) {
      this.$router.push('/dashboard');
    }
  }, 
  methods: {
    handleErrorMessage(loginResult){
      if(loginResult.response && loginResult.response.data && loginResult.response.data.errorCode)
        {
          const errorTag = 'loginform_errorcode_'+loginResult.response.data.errorCode;
          this.loginError = this.$t(errorTag);
        }else
        {
          this.loginError = this.$t('loginform_errorcode_default');
        }
    }
    
    ,async handleLogin() {
      this.loading = true;
     
      var username = this.username;
      var password = this.password;
      const user =  {username,password};
      const loginResult = await authService.login(user);
      if(loginResult.isAxiosError)
      {
        this.loading = false;
        this.handleErrorMessage(loginResult);
      }else{
        this.loading = false;
        
        this.$store.commit('auth/loginSuccess',  JSON.parse(loginResult));
        this.$router.push('/dashboard');
      }
     }
  }
}
</script>