<template> 
  <div class="modal-box">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <div class="title-task">
            <h4>{{retrievedTask.task.title}}</h4>
          </div>
          <button v-if="enableButtonClose" type="button" @click="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <taskComponentsLoader v-if="enableTaskComponentLoader" :loadedTask="retrievedTask" @evtModalPatientAnswers="handlePatientAnswersEvent"/>
        </div>
      </div>
    </div>
  </div>

</template> 
   
<script >
import { ref } from "vue";
import TaskComponentsLoader from "./TaskComponentsLoader.vue";
export default {
  name: 'TaskModal',
  components:{
    taskComponentsLoader:TaskComponentsLoader
  },
  props: ['task','showButtonClose'],
  setup(props,{emit}) {

  const retrievedTask = ref(props.task).value;
  const enableButtonClose = ref(props.showButtonClose).value;
  // If the task has 
  let enableTaskComponentLoader = (retrievedTask && retrievedTask.task.taskTypeCode) ? true : false;
  
  const closeModal = () => {
      emit("evtCloseTaskModal");
    };
  

    const handlePatientAnswersEvent = (msg) => {
      emit('evtModalPatientAnswers',msg);
    };

  return {enableTaskComponentLoader,retrievedTask,enableButtonClose,closeModal,handlePatientAnswersEvent}
  }
}
</script>    