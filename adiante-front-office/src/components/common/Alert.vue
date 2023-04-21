<template>
  <div class="alert error" role="alert"> 
    <span class="icon material-symbols-outlined"> </span> 
    <p>Texto del mensaje</p>    
  </div>
</template> 
   
 <script>
   export default {
     name: 'Alert',
     props: {
       msg: String
     }
   }
   </script>
