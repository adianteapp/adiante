<template>
  <headerMenu />

  <div class="container-fluid panel-container"> 

    <section class="widget widget-hello"> 
        <h1>{{ $t('dashboard_label_main_message',{patientName:patientName}) }}<img class="mx-2" src="../assets/img/svg/hand.svg">  </h1>
    </section>

    <Suspense>
      <template #default>
      <!--<GetMoodQuestionnaire /> -->
      <taskManager :questionnaireType="'qt-dashboard'"/>
      </template>
      <template #fallback>
        <div>{{ $t('common.loading_text')}}</div>
      </template>
    </Suspense> 

   
    <section class="widget widget-task">
       <tasksProgress  :enableLinkToAgenda="true"/>
    </section>

    <routerLink class="container-card"  to="/activities?type=tt-challenge">
      
      <div class="card"> 
        <div class="title">
            <div class="img">
              <img src="../assets/img/svg/retos-icon.svg" class="icon-card" alt="">
            </div>
      
            <div class="content">
              <div class="info"> 
                <span class="title">{{$t('challenges.title')}}</span>   
              </div>
            </div>
          </div>

        <div class="icon">
          <i class="icon-navigate_next"></i>
        </div>
      </div>

    </routerLink>
    <routerLink class="container-card"  to="/activities?type=tt-guided-activity">
      <div class="card">
        <div class="title">
            <div class="img">
              <img src="../assets/img/svg/relax-icon.svg" class="icon-card" alt="">
            </div>
    
            <div class="content">
                <div class="info"> 
                  <span class="title">{{ $t('guided_activities.title')}}</span>   
                </div>
            </div>
          </div>
        <div class="icon">
          <i class="icon-navigate_next"></i>
        </div>
     </div>
    </routerLink> 


  </div>
 
  <footerMenu />
   
     
</template>

<script>
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
import TaskManager from '../components/tasks/TaskManager.vue';
import TasksProgress from '../components/completed-tasks-progress/TasksProgress.vue'; 
import { RouterLink } from 'vue-router';
import { useStore } from 'vuex'

export default {
  name: 'Dashboard',
  components: {
    headerMenu: HeaderMenu,
    footerMenu: FooterMenu,
    taskManager: TaskManager,
    routerLink: RouterLink,
    tasksProgress: TasksProgress
  },
  setup() {
    const store = useStore();
    const patientName = store.state.auth.user.name;
    
    return { patientName }
  }
};
</script>