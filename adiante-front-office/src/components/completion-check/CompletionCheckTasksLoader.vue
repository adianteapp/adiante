<template>
    <scheduledTask  :scheduledTaskData="retrievedTask" :showFullInfo="true" />
    <div class="modal-footer footer-task-modal">
          <div class="buttons">
            <button v-if="buttonsManager.close"  @click.prevent="closeScheduledTask"  type="button" class="btn btn-secondary" data-bs-dismiss="modal">{{$t('agenda.scheduled_task.modal.close')}}</button>          
            <button v-if="buttonsManager.confirm"  @click.prevent="saveConfirmExecution"  type="button" class="btn btn-primary" data-bs-dismiss="modal">{{$t('agenda.scheduled_task.modal.confirm')}}</button>
          </div>
    </div>
</template>
<script>
import { ref } from "vue";
import ScheduledTask from "../tasks/ScheduledTask.vue";
export default ({
  name: 'CompletionCheckTasksLoader',
  props: ['loadedTask','scheduledTask'],
components: {
    scheduledTask:ScheduledTask,
  },
  async setup(props,{ emit }) {

 //#region Attributes
    const retrievedTask = ref(props.loadedTask).value;

    const enableScheduledTask = retrievedTask != null ? true : false;


    const isTaskExecuted = retrievedTask != null && retrievedTask.task != null &&  retrievedTask.task.executionDateTimeLocal != null ? true : false;

    let buttonsManager = {
     close : true,
     confirm : !isTaskExecuted ? true : false,
    }

  //#endregion Attributes 


  //#region Functions declaration 
  const closeScheduledTask = () =>{
    emit('evtCloseTaskManagerModal');
  };

  const saveConfirmExecution = () =>{
    emit('evtConfirmExecution',{scheduledTask:retrievedTask});
  };


  //#endregion Functions declaration 
    return {
      retrievedTask,buttonsManager,enableScheduledTask,
      closeScheduledTask,saveConfirmExecution
    }
  }
})
</script>