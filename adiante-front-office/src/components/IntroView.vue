<template>
  <div class="introView">
    <div class="backlink">
      <a href="/retos"  ><span class="material-symbols-outlined"> arrow_back_ios </span> Volver al
        listado</a>
    </div>
   
    <img src="../assets/img/demo/reto.jpg" alt="">

    <h2>Título del reto</h2>

    <p class="header">Conoce un poco más acerca de esta enfermedad y sus síntomas. </p>

    <p class="desc">En este reto tienes como tarea visualizar el siguiente vídeo y contestar correctamente a la pregunta que se
      planteará.

      Pon mucha atención y suerte.
    </p>

    <button type="button" class="btn btn-primary  w-100" data-bs-toggle="modal" data-bs-target="#modalVideo">
      Comenzar reto
    </button>


  </div>
</template> 
   
<script>
export default {
  name: 'IntroView',
  props: {
    msg: String
  }
}
</script>
    

    