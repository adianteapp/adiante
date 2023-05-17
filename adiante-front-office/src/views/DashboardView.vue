<template>
  <HeaderMenu />

  <div class="container-fluid panel-container"> 

    <section class="widget widget-hello"> 
        <h1>{{ $t('dashboard_label_main_message',{patientName:patientName}) }}<img class="mx-2" src="../assets/img/svg/hand.svg">  </h1>
    </section>

    <Suspense>
      <template #default>
      <GetMoodQuestionnaire />
      </template>
      <template #fallback>
        <div>Cargando...</div>
      </template>
    </Suspense> 

   
    <section class="widget widget-task">
       <TasksProgress :completed="2" :total="10" />
    </section>

  </div>
 
  <FooterMenu />
   
     
</template>

<script>
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
import GetMoodQuestionnaire from '../components/questionnaires/questionnaire-types/get-mood/GetMood.vue';
import TasksProgress from '../components/completed-tasks-progress/TasksProgress.vue'; 

import { useStore } from 'vuex'

import { computed } from 'vue'

export default {
  name: 'Dashboard',
  components: {
    HeaderMenu: HeaderMenu,
    FooterMenu: FooterMenu,
    GetMoodQuestionnaire: GetMoodQuestionnaire,
    TasksProgress : TasksProgress
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