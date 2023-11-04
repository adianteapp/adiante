<template>
  <div class="login">
    <div class="content">
      <img alt="logo" class="logo" src="../assets/img/svg/logo.svg"/> 
      <div class="alert info">Se ha enviado un email con las instrucciones para recuperar tu contraseña</div>
      <form @submit.prevent="handleLogin">
        <div class="form-login">
          <div class="mb-3">
            <label for="InputEmail1" class="form-label">{{ $t('loginform_label_user') }}</label>
            <input type="text"  v-model="username" class="form-control" id="InputEmail1" aria-describedby="emailHelp">
           </div>
          
          <button type="submit" class="btn btn-primary w-100">{{ $t('lostpwdform_button_access') }} <i class="icon-navigate_next"></i></button>
        </div>
      </form>

      
      <div class="about">
        <a href="">{{ $t('loginform_label_aboutus') }}</a>
      </div>

    </div>
  </div>
</template>


<script>
 
</script>