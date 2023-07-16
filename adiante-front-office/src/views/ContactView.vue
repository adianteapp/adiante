<template>
  <headerMenu/>
  <div class="container-fluid panel-container">
      <h2>Alume Saúde Mental</h2>
      <h3>Alume Saúde Mental Rúa Illa Coelleira, 3, 27002, Lugo</h3>
  </div>
  
  <footerMenu/>
</template>
<script>
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
export default {
  name: 'Contanct',
  components: {
    headerMenu:HeaderMenu,
    footerMenu: FooterMenu
  },
  setup() {
    return {}
  }
}
</script>
