<template>
  <div>
    <header class="header" id="header">
      <div class="header__toggle">
        <i class='navbar__toggle' @click="toggleSidebar" id="header-toggle"></i>
      </div>

      <div class="search">
        <input type="text" placeholder="Buscar">
        <button type="submit">
          <i class="icon-search"></i>
        </button>
      </div>

      <div class="actions">
        <div class="header__img">
          <img src="../../assets/img/profile.png" alt="">
        </div>
        <span>{{ userName }}</span>
      </div>
    </header>
  </div>
</template>

<script>
import { ref } from 'vue';

export default {
  name: 'HeaderComponent',
  setup() {
    const userName = ref('Nombre');

    const toggleSidebar = () => {
      // Implementa la lógica para mostrar/ocultar la barra lateral
    };

    return {
      userName,
      toggleSidebar
    };
  }
};
</script>

<style scoped>
/* Estilos CSS pueden ir aquí */
</style>