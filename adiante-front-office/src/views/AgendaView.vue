<template>
  <headerMenu />

  <div class="container-fluid task-container">

    <div class="title">
      <weekAgenda @evtAgendaChangeDate="handleAgendaChangeDateEvent" />
    </div>


    <div class="content">
        
      <section class="widget widget-task small">
            <taskProgress :completed="2" :total="10" :enableLinkToAgenda="true"/>
      </section>
      <Suspense>
        <template #default>
            <taskManager v-if="enableTaskManager" 
                        :showOnModal="true"
                        :scheduledTask="selectedTask"      
                        @evtCloseTaskManagerModal="handleTaskModalCloseEvent" />
        </template>
      </Suspense>

      <Suspense>
        <template #default>
          
          <div class="list-task">
            <div v-for="(scheduledTaskItem) in state.scheduledTaskList" :key="scheduledTaskItem.scheduledId">
              <scheduledTask :scheduledTaskData="scheduledTaskItem" @click.prevent="maximizeScheduledTask(scheduledTaskItem)"/>
            </div>
          </div>
        </template>
        <template #fallback>
          <div>{{ $t('common.loading_text')}}</div>
        </template>
      </Suspense> 
    </div>
    
  </div>
  <footerMenu />
</template>
<script>
import { reactive, ref } from 'vue';
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
import WeekAgenda from '../components/WeekAgenda.vue';
import TasksProgress from '../components/completed-tasks-progress/TasksProgress.vue';
import ScheduledTask from '../components/tasks/ScheduledTask.vue'
import taskService from '../services/task.service';
import TaskManager from '../components/tasks/TaskManager.vue';
export default {
  name:'AgendaView',
  components: {
    headerMenu: HeaderMenu,
    footerMenu: FooterMenu,
    weekAgenda: WeekAgenda,
    taskProgress: TasksProgress,
    scheduledTask:ScheduledTask,
    taskManager:TaskManager
  },
 setup(){

  const enableTaskManager = ref(false);
  const selectedTask = ref(undefined);
  const state = reactive({
      scheduledTaskList: undefined
    });
  
    const handleAgendaChangeDateEvent = (msg) => {
      retrieveScheduledTasks(msg);
    };

    const handleTaskModalCloseEvent = () => {
      enableTaskManager.value = false;
    };

  async function retrieveScheduledTasks(date){

    const response =  await taskService.getScheduledTasks(date);
    if(response.isAxiosError){
      console.log("Error retrieving scheduled tasks");
    }else{
      state.scheduledTaskList = response.tasksList;
    }
  }

  function maximizeScheduledTask(scheduledTask){
    selectedTask.value = scheduledTask;
    enableTaskManager.value = true;
  }


  return {state,enableTaskManager,selectedTask,
          handleAgendaChangeDateEvent, handleTaskModalCloseEvent,maximizeScheduledTask};
  }
}
</script>

 