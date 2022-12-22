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
          
          <div class="state" data-bs-toggle="modal" data-bs-target="#modalState"> 
            <img src="../assets/img/svg/states/state1.svg"   alt="">
            <span>Muy felíz</span> 
          </div>

          <div class="state" data-bs-toggle="modal" data-bs-target="#modalState"> 
            <img src="../assets/img/svg/states/state2.svg"   alt="">
            <span>Muy bien</span> 
          </div>

          <div class="state" data-bs-toggle="modal" data-bs-target="#modalState"> 
            <img src="../assets/img/svg/states/state3.svg"   alt="">
            <span>Indiferente</span> 
          </div>


          <div class="state" data-bs-toggle="modal" data-bs-target="#modalState"> 
            <img src="../assets/img/svg/states/state4.svg"   alt="">
            <span>Mal</span> 
          </div>

          <div class="state" data-bs-toggle="modal" data-bs-target="#modalState"> 
            <img src="../assets/img/svg/states/state5.svg"   alt="">
            <span>Muy mal</span> 
          </div>

        
         
        </div>
        
      </div>

      <div class="footer">
        <a class="text-sm" href="">Ver mis registros </a> <span class="material-symbols-outlined">
          chevron_right
          </span>
      </div>

    </section>

    <section class="widget widget-task">
      <div class="content">
        <div class="info">
          <h2>Tus tareas para hoy</h2> 
          <span>1 de 4 completadas</span>
          <a href="#">Ver todas</a>
        </div>
        <div class="completed">
          
          

          <div class="flex-wrapper">
            
            
            <div class="single-chart">
              <svg viewBox="0 0 36 36" class="circular-chart green">
                <path class="circle-bg"
                  d="M18 2.0845
                    a 15.9155 15.9155 0 0 1 0 31.831
                    a 15.9155 15.9155 0 0 1 0 -31.831"
                />
                <path class="circle"
                  stroke-dasharray="60, 100"
                  d="M18 2.0845
                    a 15.9155 15.9155 0 0 1 0 31.831
                    a 15.9155 15.9155 0 0 1 0 -31.831"
                />
                <text x="18" y="20.35" class="percentage">60%</text>
              </svg>
            </div>
          
             
          </div>


        </div>
      </div>
      
    </section>
 

  </div>
  <FooterMenu />
   
     
</template>

 