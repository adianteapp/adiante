<template>
  <div class="login">
    <div class="content">
      <img alt="logo" class="logo" src="../assets/img/svg/logo.svg"/> 
       
      <form @submit="handleLogin">
        <div class="form-login">
          <div class="mb-3">
            <label for="InputEmail1" class="form-label">Usuario</label>
            <input type="text" class="form-control" id="InputEmail1" aria-describedby="emailHelp">
           </div>
          <div class="mb-4">
            <label for="InputPassword1" class="form-label">Contraseña</label>
            <input type="password" class="form-control" id="InputPassword1">
          </div>
          <button type="submit" class="btn btn-primary w-100">Acceder <span class="material-symbols-outlined">
            login
            </span></button>
        </div>
      </form>
      <div class="lost-pwd">
        <button type="submit" class="btn btn-outline-primary w-100 mt-4">Olvidé mi contraseña</button>
      </div>

      <div class="about">
        <a href="">About us</a>
      </div>

    </div>
  </div>
</template>


<script>
//import { Form, Field, ErrorMessage } from "vee-validate";
import * as yup from "yup";

export default {
  name: "Login",
  components: {},
  computed: {
    loggedIn() {
      return this.$store.state.auth.status.loggedIn;
    },
  },
  created() {
    if (this.loggedIn) {
      this.$router.push("/profile");
    }
  },
  data() {
    const schema = yup.object().shape({
      username: yup.string().required("Username is required!"),
      password: yup.string().required("Password is required!"),
    });

    return {
      loading: false,
      message: "",
      schema,
    };
  },
  methods: {
    handleLogin() {

      this.loading = true;
      var username = this.username;
      var password = this.password;
      var user =  {username,password};

      this.$store.dispatch("auth/login", user).then(
        () => {
          this.$router.push("/profile");
        },
        (error) => {
          this.loading = false;
          this.message =
            (error.response &&
              error.response.data &&
              error.response.data.message) ||
            error.message ||
            error.toString();
        }
      );
    },
  },
};
</script>