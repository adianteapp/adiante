<template>
  <div class="navbar-footer fixed-bottom">

    <ul class="nav">
        <li>
          <a v-if="activeLinks.dashboard" href="/dashboard" class="nav-link active"> 
            <i class="icon-menu-home"> </i>
          </a>
          <a v-else href="/dashboard" class="nav-link  "> 
            <i class="icon-menu-home"> </i>
          </a>
        </li>
        <li>
          <a v-if="activeLinks.challenge" href="/activities?type=tt-challenge" class="nav-link active">
            <i class="icon-menu-retos"> </i>
          </a>
          <a v-else href="/activities?type=tt-challenge" class="nav-link ">
            <i class="icon-menu-retos"> </i>
          </a>
        </li>
        <li>
          <a v-if="activeLinks.agenda" href="/agenda" class="nav-link active">          
            <i class="icon-menu-calendar"> </i>
          </a>
          <a v-else href="/agenda" class="nav-link ">
            <i class="icon-menu-calendar"> </i>
          </a>
        </li>
        
        <li>
          <a v-if="activeLinks.contact" href="/contact" class="nav-link  active">
            <i class="icon-menu-contact"> </i>
          </a>
          <a v-else href="/contact" class="nav-link  ">
            <i class="icon-menu-contact"> </i>
          </a>
        </li>
      </ul>
    </div>
</template> 

<script>
import { useRoute } from 'vue-router';
export default {
  name: 'FooterMemu',
  setup() {
     
    const route = useRoute();
    const activeLinks ={
      agenda: route.path === '/agenda',
      dashboard: route.path === '/dashboard',
      challenge: route.path === '/activities' && route.query.type === 'tt-challenge',
      contact: route.path === '/contact',
    }


    return { activeLinks  }
  }
}
</script>
 