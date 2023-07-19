<template>
  <headerMenu/>
  <div class="container-fluid contact-container">

      <h1>Hola, soy Paquita</h1>

      <img class="img-profesional" src="https://templates.joomla-monster.com/joomla30/jm-news-portal/components/com_djclassifieds/assets/images/default_profile.png" alt="" />
      
    
    <br />   
      <p>Soy tu terapeuta y puedes contactar conmigo a través cuando lo necesites.</p>
      <br />
      <a href="https://wa.me/628546755/?text=Hola" target="_blank" class="btn big btn-whatsapp">Enviame un Whatsapp</a>
      <br />
      <p>¿Es una emergencia?</p>

      <a href="tel:+34628546755" class="btn big btn-alert">Llámame ahora</a>


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
