<template>
  <div class="login">
    <div class="content">
      <img alt="logo" class="logo" src="../assets/img/svg/logo.svg"/> 
       
      <form @submit="handleLogin">
        <div class="mb-3">
          <label for="exampleInputEmail1" class="form-label">Usuario</label>
          <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
         </div>
        <div class="mb-3">
          <label for="exampleInputPassword1" class="form-label">Contraseña</label>
          <input type="password" class="form-control" id="exampleInputPassword1">
        </div>
        <div class="mb-3 form-check">
          <input type="checkbox" class="form-check-input" id="exampleCheck1">
          <label class="form-check-label" for="exampleCheck1">No cerrar sesión</label>
        </div>
        <button type="submit" class="btn btn-primary">Acceder</button>
      </form>
      <hr />
      <button type="submit" class="btn btn-outline-primary">Olvidé mi contraseña</button>

    </div>
  </div>
</template>


<script>
import * as yup from "yup";

export default {
  name: "Login",
  components: {},
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
  methods: {
    handleLogin(user) {
      this.loading = true;

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