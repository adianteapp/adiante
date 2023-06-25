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
        <div>Cargando...</div>
      </template>
    </Suspense> 

   
    <section class="widget widget-task">
       <tasksProgress :completed="2" :total="10" :enableLinkToAgenda="true"/>
    </section>

  </div>
 
  <footerMenu />
   
     
</template>

<script>
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
import TaskManager from '../components/tasks/TaskManager.vue';
import TasksProgress from '../components/completed-tasks-progress/TasksProgress.vue'; 

import { useStore } from 'vuex'

import { computed } from 'vue'

export default {
  name: 'Dashboard',
  components: {
    headerMenu: HeaderMenu,
    footerMenu: FooterMenu,
    taskManager: TaskManager,
    tasksProgress : TasksProgress
},
  setup() {
    const store = useStore();
    const patientName = computed( () => store.state.auth.user.name);
    return   {patientName}
   },
  mounted() {
    if (!this.$store.state.auth) {
      this .$router.push('/login');
    }
  }
};
</script>