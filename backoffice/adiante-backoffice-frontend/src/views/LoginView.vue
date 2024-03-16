<template>
  <form @submit.prevent="doLogin">
    <div class="container">
      <div class="row">
        <div class="col">
          <div class="input text">
            <label for="input-example">Email</label>
            <input v-model="email" type="text" id="email" name="email" class="form-control" required>
          </div>
          <div class="input text">
            <label for="input-example">Contraseña</label>
            <input v-model="password" type="password" id="password" name="password" class="form-control" required>
          </div>
          <button type="submit" class="btn btn-primary big">Iniciar sesión</button>
        </div>
      </div>
    </div>
  </form>
</template>

<script>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
export default {
  setup() {
    const email = ref('');
    const password = ref('');
    const router = useRouter();
    const doLogin = async () => {
      router.push('/dashboard');   
    }



   

    return {
      email,password,doLogin
    };
  }
};
</script>

