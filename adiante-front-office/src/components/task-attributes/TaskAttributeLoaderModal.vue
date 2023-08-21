<template> 
    <div class="modal-box">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <div class="title-task">
              <h4>{{retrievedTask.task.title}}</h4>
            </div>
            <button type="button" @click="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
                <taskAttributeLoader v-if="attributeList" :attributeList="attributeList"/>
          </div>
        </div>
      </div>
    </div>
  
  </template> 
<script>
import { ref } from 'vue'
import TaskAttributeLoader from './TaskAttributeLoader.vue';

export default {
    name: "TaskAttributeLoaderModal",
    props: ['taskData'],
    components: {
      taskAttributeLoader: TaskAttributeLoader
    },
    setup(props,{emit}){
       
        const retrievedTask = ref(props.taskData).value;     
        const attributeList = ref(retrievedTask && retrievedTask.task && retrievedTask.task.taskAttributeList && retrievedTask.task.taskAttributeList.length > 0 ? retrievedTask.task.taskAttributeList : undefined);

        const closeModal = () => {
      emit("evtCloseTaskAttributeLoaderModal");
    };
  
        return {retrievedTask,attributeList
               ,closeModal};
    }

}
</script>