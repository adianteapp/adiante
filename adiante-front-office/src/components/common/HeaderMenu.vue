<template>
  <div class="navbar-header  fixed-top">

    <a href="/panel"><img alt="Adiante logo" class="logo" src="../../assets/logo.png"> </a>


    <div class="dropdown text-end">
      <button class="btn btn-menu small dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
        <img src="../../assets/img/user-demo.jpg" width="32" height="32" class="rounded-circle">
        <div class="name"> Nombre Apellido</div>
      </button>
      <ul class="dropdown-menu w-100" aria-labelledby="dropdownMenuButton1"> 
        <li><a class="dropdown-item" href="#">
          <span class="material-symbols-outlined">
          logout
          </span> Cerrar sesión</a></li>
      </ul>
    </div>
 
  </div>



</template> 


<script>
import authService from '../../services/auth.service';
export default {
  name: 'HeaderMenu',
  props: {
    msg: String
  },
  methods:{
    handleLogout(){
      authService.logout();
      this.$store.commit('auth/logout')
    }
  }
}
</script>
 