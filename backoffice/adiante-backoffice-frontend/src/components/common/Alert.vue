<template>
  <div class="alert error" role="alert"> 
    <i> </i> 
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
