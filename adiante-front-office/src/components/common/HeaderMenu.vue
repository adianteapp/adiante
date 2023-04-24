<template>
  <div class="navbar-header fixed-top">

    <a href="/dashboard"><img alt="Adiante logo" class="logo" src="../../assets/logo.png"> </a>


    <label class="dropdown">

      <div class="dd-button">
        <span class="material-symbols-outlined">
          person
          </span> {{patientName}}
      </div>
    
      <input type="checkbox" class="dd-input" id="test">
    
      <ul class="dd-menu">
         
        <li>
          <a class="dropdown-item" href="#" @click="handleLogout()">
            <span class="material-symbols-outlined">
            logout
            </span>{{ $t('header_label_logout')}}</a>
        </li>
      </ul>
      
    </label>
    
 
  </div>

</template> 


<script>
import authService from '../../services/auth.service';
import { useStore } from 'vuex'
import { computed } from 'vue'

export default {
  name: 'HeaderMenu'
  ,
  setup() {
    const store = useStore();
    const patientName = computed( () => store.state.auth.user.name);
    return   {patientName}
   },
  methods:{
    handleLogout(){
      authService.logout();
      this.$store.commit('auth/logout')
    }
  }
}
</script>
 