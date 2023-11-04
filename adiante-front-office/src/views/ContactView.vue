<template>
  <headerMenu/>
  <div class="container-fluid contact-container">

      <h1 style="text-align:center">Hola, somos el equipo PAPEP</h1>

       
      <br />
      <p>Puedes contactar con nosotros cuando lo necesites.</p>
      
      <a href="https://wa.me/604016521/?text=Hola" target="_blank" class="btn big btn-whatsapp">Envíanos un Whatsapp</a>
      <br />

      <br />
      <p><strong>¿Es una emergencia?</strong></p> 

      <a href="tel:+3604016521" class="btn big btn-alert">Llámanos ahora</a>


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
