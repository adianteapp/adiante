<template>
 <div class="navbar-header">
 
  
    <img alt="Adiante logo" class="logo" src="../../assets/logo.png">   
  <div class="dropdown text-end">
    <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" data-bs-toggle="modal" data-bs-target="#menuModal">
      
      <img  src="../../assets/img/user-demo.jpg" width="32" height="32" class="rounded-circle">  
    </a>
   
  </div>
    
    </div>
 

<!-- Modal -->
<div class="modal fade" id="menuModal" tabindex="-1" aria-labelledby="menuModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="menuModalLabel">Modal title</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        contenido de modal
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>



</template> 


<script>
export default {
  name: 'HeaderMenu',
  props: {
    msg: String
  }
}
</script>
 