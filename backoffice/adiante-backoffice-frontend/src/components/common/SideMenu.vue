<template>
    <div class="navbar-left" id="nav-bar">
      <nav class="nav">
        <div>
          <a href="#" class="nav__logo">
            <i class="icon icon-adiante"></i>
            <span class="nav__logo-name">Adiante</span>
          </a>
          <div class="nav__list" id="icon_list_menu">
            <router-link to="/patient-list" class="nav__link" id="menu_pacientes">
              <i class="icon icon-person"></i>
              <span class="nav__name">Pacientes</span>
            </router-link>
            <router-link to="/patient-agenda" class="nav__link" id="menu_registros">
              <i class="icon icon-calendar"></i>
              <span class="nav__name">Registros</span>
            </router-link>
            <router-link to="/task-manager" class="nav__link" id="menu_retos_trsguiadas">
              <i class="icon icon-doc"></i>
              <span class="nav__name">Tasks</span>
            </router-link>
          </div>
        </div>
        <a href="#" class="nav__link" @click="logout">
          <i class="icon icon-close"></i>
          <span class="nav__name">Cerrar sesión</span>
        </a>
      </nav>
    </div>
  </template>
  
  <script>
  import { useRouter } from 'vue-router';
  
  export default {
    name: 'SideMenu',
    setup() {
      const router = useRouter();
  
      const logout = () => {
        localStorage.removeItem('token');
        router.push('/login');
      };
  
      return {
        logout
      };
    }
  };
  </script>