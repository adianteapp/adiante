<template>
    <div class="card">

        <div class="img">
          <img src="../../../public/img/demo/reto.jpg" alt="">
        </div>

        <div class="content">
          <div class="info"> 
            <span class="title">Title card</span>  <div class="label small completed"> <span></span></div>
        </div>
          <div class="desc">
            Vestibulum lectus mauris ultrices eros cursus turpis massa tincidunt.
          </div>

        </div>

        <div class="icon">
            <span class="material-symbols-outlined">
                navigate_next
                </span>
        </div>
      </div>
</template> 
   
 <script>
   export default {
     name: 'Card',
     props: {
       msg: String
     }
   }
   </script>
    