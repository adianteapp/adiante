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

  <div class="container-fluid task-container">

    <div class="title">
      <div class="week">
        <div class="row">
          <div class="col">Lun <br /> 8</div>
          <div class="col">Mar <br /> 9</div>
          <div class="col">Mie <br /> 10</div>
          <div class="col">Jue <br /> 11</div>
          <div class="col">Vue <br /> 12</div>
          <div class="col active">Sab <br /> 13</div>
          <div class="col">Dom <br /> 14</div>
        </div>
      </div>
      <div class="content">
        <div class="info">
          <h2>Tus tareas para hoy</h2>
          <p>Solo te faltan <strong>2</strong> tasks por completar.</p>
        </div>
        <div class="completed">
          <div class="flex-wrapper">
            <div class="single-chart">
              <svg viewBox="0 0 36 36" class="circular-chart green">
                <path class="circle-bg" d="M18 2.0845
                            a 15.9155 15.9155 0 0 1 0 31.831
                            a 15.9155 15.9155 0 0 1 0 -31.831" />
                <path class="circle" stroke-dasharray="60, 100" d="M18 2.0845
                            a 15.9155 15.9155 0 0 1 0 31.831
                            a 15.9155 15.9155 0 0 1 0 -31.831" />
                <text x="18" y="20.35" class="percentage">60%</text>
              </svg>
            </div>
          </div>
        </div>
      </div>
    </div>

    
    <div class="list-task">

     


    </div>
   

  </div>
  <FooterMenu />
   
     
</template>

 