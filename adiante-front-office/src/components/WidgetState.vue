<template>
  <section class="widget widget-state">

    <div class="header">
      <h2>{{ $t('widgetstate_header_title') }}</h2>
      <span>0 {{ $t('widgetstate_header_register') }} </span>
    </div>

    <div class="content">

      <div class="states">

        <div class="state" data-bs-toggle="modal" data-bs-target="#modalState1">
          <img src="../../public/img/svg/states/state1.svg" alt="">
          <span>Muy felíz</span>
        </div>

        <div class="state" data-bs-toggle="modal" data-bs-target="#modalState1">
          <img src="../../public/img/svg/states/state2.svg" alt="">
          <span>Muy bien</span>
        </div>

        <div class="state" data-bs-toggle="modal" data-bs-target="#modalState1">
          <img src="../../public/img/svg/states/state3.svg" alt="">
          <span>Indiferente</span>
        </div>

        <div class="state" data-bs-toggle="modal" data-bs-target="#modalState1">
          <img src="../../public/img/svg/states/state3.svg" alt="">
          <span>Agobiado</span>
        </div>

        <div class="state" data-bs-toggle="modal" data-bs-target="#modalState1">
          <img src="../../public/img/svg/states/state4.svg" alt="">
          <span>Mal</span>
        </div>

        <div class="state" data-bs-toggle="modal" data-bs-target="#modalState1">
          <img src="../../public/img/svg/states/state5.svg" alt="">
          <span>Muy mal</span>
        </div>

      </div>

    </div>

    

  </section>
</template> 
   
<script>
export default {
  name: 'WidgetState',
  props: {
    msg: String
  }
}
</script>
    