<template>
  <headerMenu />

  <div class="container-fluid task-container">

    <div class="title">
      <weekAgenda @evtAgendaChangeDate="handleAgendaChangeDateEvent"/>
      <div class="content">
        <taskProgress :completed="2" :total="10" :enableLinkToAgenda="false"/>
      </div>
    </div> 
    <div class="list-task">
      <scheduledTask/>
      <scheduledTask/>
      <scheduledTask/>
      <scheduledTask/>
      <scheduledTask/>
    </div>
   

  </div>
  <footerMenu />
   
     
</template>
<script>
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
import WeekAgenda from '../components/WeekAgenda.vue';
import TasksProgress from '../components/completed-tasks-progress/TasksProgress.vue';
import ScheduledTask from '../components/common/ScheduledTask.vue';
export default {
  name:'AgendaView',
  components: {
    headerMenu: HeaderMenu,
    footerMenu: FooterMenu,
    weekAgenda: WeekAgenda,
    taskProgress: TasksProgress,
    scheduledTask:ScheduledTask
  },
  setup(){


  
    const handleAgendaChangeDateEvent = (msg) => {
      //
      console.log(msg);
    };



  return {handleAgendaChangeDateEvent};
  }
}
</script>

 