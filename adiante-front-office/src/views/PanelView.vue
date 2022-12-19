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
  <div class="container-fluid"> 

    <div class="row">
      <div class="col-12">
        <h1>Hola, <strong>Nombre</strong> <img class="mx-2" src="../assets/img/svg/hand.svg">  </h1>
      </div>
    </div>

    <section class="widget-state">
      <div class="header d-flex justify-content-between">
        <h2>¿Cómo te sientes?</h2>
        <a class="text-sm" href="">0 registros hoy</a>
      </div>
      
      <div class="row"> 
        <div class="col-2 card">
          1
        </div>
        <div class="col-2 card">
          2
        </div>
        <div class="col-2 card">
          3
        </div>
        <div class="col-2 card">
          4
        </div> 
        <div class="col-2 card">
          5
        </div> 
      </div>
    </section>

    <section class="widget-tasks">
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

 