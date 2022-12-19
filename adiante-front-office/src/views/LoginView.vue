<template>
  <div class="login">
    <div class="content">
      <img alt="logo" class="logo" src="../assets/img/svg/logo.svg"/> 
       
      <form>
        <div class="mb-3">
          <label for="exampleInputEmail1" class="form-label">Usuario</label>
          <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
         </div>
        <div class="mb-3">
          <label for="exampleInputPassword1" class="form-label">Contraseña</label>
          <input type="password" class="form-control" id="exampleInputPassword1">
        </div>
        <div class="mb-3 form-check">
          <input type="checkbox" class="form-check-input" id="exampleCheck1">
          <label class="form-check-label" for="exampleCheck1">No cerrar sesión</label>
        </div>
        <button type="submit" class="btn btn-primary">Acceder</button>
      </form>
      <hr />
      <button type="submit" class="btn btn-outline-primary">Olvidé mi contraseña</button>

    </div>
  </div>
</template>

