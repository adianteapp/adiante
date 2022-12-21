<script>
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'

export default {
  components: {
    HeaderMenu: HeaderMenu,
    FooterMenu: FooterMenu
  }
}
</script>

<template>
  <HeaderMenu />

  <div class="container-fluid panel-container"> 

    <div class="widget widget-hello"> 
        <h1>Hola, <strong>Nombre</strong> <img class="mx-2" src="../assets/img/svg/hand.svg">  </h1>
    </div>

    <section class="widget widget-state">

      <div class="header">
        <h2>¿Cómo te sientes?</h2>
        <span>0 registros hoy</span>
      </div>
      
      <div class="content"> 

        <div class="states">
          <div class="state">
            <img src="../assets/img/svg/states/state1.svg"   alt="">
            <span>Feliz</span>
          </div>

          <div class="state">
            <img src="../assets/img/svg/states/state1.svg"   alt="">
            <span>Feliz</span>
          </div>

          <div class="state">
            <img src="../assets/img/svg/states/state1.svg"   alt="">
            <span>Feliz</span>
          </div>

          <div class="state">
            <img src="../assets/img/svg/states/state1.svg"   alt="">
            <span>Feliz</span>
          </div>

          <div class="state">
            <img src="../assets/img/svg/states/state1.svg"   alt="">
            <span>Feliz</span>
          </div>

          <div class="state">
            <img src="../assets/img/svg/states/state1.svg"   alt="">
            <span>Feliz</span>
          </div>

          <div class="state">
            <img src="../assets/img/svg/states/state1.svg"   alt="">
            <span>Feliz</span>
          </div>

         
        </div>
        
      </div>

      <div class="footer">
        <a class="text-sm" href="">0 registros hoy</a>
      </div>

    </section>

    <section class="widget widget-tasks">
      <div class="header d-flex justify-content-between">
        <h2>Tus tareas para hoy</h2> 
      </div>
      
      
    </section>

    <nav>
      <router-link to="/">Home</router-link> |
      <router-link to="/about">About</router-link>
    </nav>
     
  
   
  </div>
  <FooterMenu />
</template>

 