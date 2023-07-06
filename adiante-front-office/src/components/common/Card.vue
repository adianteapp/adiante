<template>
    <div class="card">

        <div class="img">
          <img src="../../../public/img/demo/reto.jpg" alt="">
        </div>

        <div class="content">
          <div class="info"> 
            <span class="title">currentScheduledTask.value.taskTitle</span>  
            <div v-if="cardStatus.completed" class="label small completed"></div> 
            <div v-if="cardStatus.delayed" class="label small delayed"></div>
            <span></span>
        </div>
          <div class="desc">
            currentScheduledTask.value.taskDescription
          </div>

        </div>

        <div class="icon">
          <i class="icon-navigate_next"></i>
        </div>
      </div>
</template> 
   
 <script>
import { ref } from 'vue';
export default {
  name: 'Card',
  props: ['scheduledTaskData'],
  setup(props){
    const currentScheduledTask = ref(props.scheduledTaskData);
    const currentDate = new Date();
    const cardStatus = {
      completed : (currentScheduledTask.value.executionDateTimeLocal) ? true:false,
      delayed :(currentScheduledTask.value.executionDateTimeLocal && currentDate > currentScheduledTask.value.endDateTimeLocal) ? false:true
    }
     return{currentScheduledTask,cardStatus}
  }

}
   </script>
    