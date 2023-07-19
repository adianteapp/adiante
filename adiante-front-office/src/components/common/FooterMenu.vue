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
          <a v-if="activeLinks.agenda" href="/agenda" class="nav-link active">          
            <i class="icon-menu-calendar-2"> </i>
          </a>
          <a v-else href="/agenda" class="nav-link ">
            <i class="icon-menu-calendar-2"> </i>
          </a>
        </li>
        <li>
          <a v-if="activeLinks.challenge" href="/activities?type=tt-challenge" class="nav-link active">
            <i class="icon-menu-retos-2"> </i>
          </a>
          <a v-else href="/activities?type=tt-challenge" class="nav-link ">
            <i class="icon-menu-retos-2"> </i>
          </a>
        </li>
        <li>
          <a v-if="activeLinks.activity" href="/activities?type=tt-guided-activity" class="nav-link active">
            <i class="icon-menu-yoga"> </i>
          </a>
          <a v-else href="/activities?type=tt-guided-activity" class="nav-link ">
            <i class="icon-menu-yoga"> </i>
          </a>
        </li>
        
        <li>
          <a v-if="activeLinks.contact" href="/contact" class="nav-link  active">
            <i class="icon-menu-contact-2"> </i>
          </a>
          <a v-else href="/contact" class="nav-link  ">
            <i class="icon-menu-contact-2"> </i>
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
      activity: route.path === '/activities' && route.query.type === 'tt-guided-activity',
      challenge: route.path === '/activities' && route.query.type === 'tt-challenge',
      contact: route.path === '/contact',
    }


    return { activeLinks  }
  }
}
</script>
 