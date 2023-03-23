<template>
  <HeaderMenu />

  <div class="container-fluid panel-container"> 

    <section class="widget widget-hello"> 
        <h1>Hola, <strong>{{$store.state.auth.user.name}}</strong> <img class="mx-2" src="../assets/img/svg/hand.svg">  </h1>
    </section>

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

      <div class="footer d-none">
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
          <a href="/agenda">Ver todas</a>
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
    
    <section class="widget widget-retos">
        <div class="retos">

        </div>
        <div class="relax">
          
        </div>
    </section>

    <section class="widget widget-actividades">
  

    </section>

  </div>


  <!-- Modal registro síntomas -->
  <div class="modal fade" id="modalState" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modalState" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">           
          <h5 class="modal-title">Registro de síntomas</h5>

          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p>¿Tienes alguno de estos síntomas?</p>
          
          
          <div class="form-check">
            <input class="form-check-input" type="checkbox" value="" id="sintom1">
            <label class="form-check-label" for="sintom1">
              Síntoma
            </label>
          </div>

          <div class="form-check">
            <input class="form-check-input" type="checkbox" value="" id="sintom2">
            <label class="form-check-label" for="sintom2">
              Síntoma
            </label>
          </div>

          <div class="form-check">
            <input class="form-check-input" type="checkbox" value="" id="sintom3">
            <label class="form-check-label" for="sintom3">
              Síntoma
            </label>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary w-100"  data-bs-target="#modalFeedback" data-bs-toggle="modal" data-bs-dismiss="modal">Registrar síntomas</button>
          <button type="button" class="btn btn-link w-100" data-bs-target="#modalFeedback" data-bs-toggle="modal" data-bs-dismiss="modal">No tengo ninguno</button>
        </div>
      </div>
    </div>
    </div>

    <!-- Modal feedback-->
    <div class="modal fade" id="modalFeedback" tabindex="-1" aria-labelledby="modalFeedback" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="modalFeedback">Enhorabuena <img src="../assets/img/svg/celebrate.svg" alt=""></h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            
            <p>Has ganado <strong>2 puntos</strong> por registrar tu estado.</p>
            <p>¡Sigue así!</p>
          </div>
          <div class="modal-footer"> 
            <button type="button" class="btn btn-primary w-100"  data-bs-dismiss="modal">Aceptar</button>
          </div>
        </div>
      </div>
    </div>


  <FooterMenu />
   
     
</template>

<script>
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
import { useStore } from 'vuex'
//import { computed } from 'vue'

export default {
  name: 'Dashboard',
  components: {
    HeaderMenu: HeaderMenu,
    FooterMenu: FooterMenu
  },
  setup() {
    const store = useStore();

    return   { store }
   },
  mounted() {
    if (!this.$store.state.auth) {
      this .$router.push('/login');
    }
  }
};
</script>