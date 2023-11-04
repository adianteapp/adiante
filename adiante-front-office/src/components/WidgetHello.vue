<template>
    <section class="widget widget-hello">
        <h1>{{ $t('widgethello_text_hello') }}, <strong>Nombre</strong> <img class="mx-2" src="../assets/img/svg/hand.svg"> </h1>
      </section>
  
   </template> 
   
         <script>
   export default {
     name: 'WidgetHello',
     props: {
       msg: String
     }
   }
   </script>
    