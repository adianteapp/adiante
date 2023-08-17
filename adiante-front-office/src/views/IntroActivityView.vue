<template>
  <headerMenu />


  <div class="container-fluid introView">
 
    <div  class="header-activity" v-if="enableMainContent">
      <div class="backlink">
        <a :href="getReturnPath()">
          <i class="icon-navigate_before"></i>
          {{ $t('intro_activities.backLink') }}
        </a> 
      </div> 
      
    </div>
 
    <div class="container-activity"> 
      <Suspense>
          <div v-if="enableMainContent">
            <h2>{{  retrievedTask.task.title  }}</h2>

            <img v-if="getMainImage()" :src="getMainImage()" alt="">
            <img v-else src="../assets/img/demo/reto1.jpg" alt="">
            
            <div v-if="retrievedTask.task.additionalInfo != null" v-html="retrievedTask.task.additionalInfo"></div>
            <div v-else>{{ retrievedTask.task.description }}</div>
          </div>
      </Suspense>
      <Suspense>
        <taskManager v-if="enableTaskManager" :showOnModal="true" :taskData="retrievedTask"
          @evtCloseTaskManagerModal="handleEvtCloseTaskManagerModal" />
      </Suspense>


       </div>


       <div class="button-activity"> 
        <button v-if="startChallenge" type="button" @click.prevent="handleStartChallenge" class="btn btn-primary  w-100">
        {{ $t('intro_activities.startChallengeButton') }}
       </button>

       </div>
    </div>
 
  <footerMenu />
</template> 
   
<script>
import { ref } from 'vue';
import { useRoute } from 'vue-router';
import taskService from '../services/task.service';
import TaskManager from '../components/tasks/TaskManager.vue'; // change import statement to match file name casing
import HeaderMenu from '../components/common/HeaderMenu.vue';
import FooterMenu from '../components/common/FooterMenu.vue';

export default {
  name: 'IntroActivity',
  props: [],
  components: {
    headerMenu: HeaderMenu,
    FooterMenu: FooterMenu,
    taskManager: TaskManager
  },
   setup() {
    const retrievedTask = ref(undefined);
    const route = useRoute();
    const type = route.query.type;
    const taskId = route.query.taskId;
    const returnPath = "/activities?type=" + type;
    const enableTaskManager = ref(false);
    const enableMainContent = ref(false);

    const startChallenge = ref(false);


    const initComponent = async () => {
      const response = await taskService.getTaskById(taskId);
      if (response.isAxiosError) {
        console.log("Error retrieving task on IntroActivityView");
      } else {
        retrievedTask.value = response.data;
        enableMainContent.value = true;
        startChallenge.value = retrievedTask.value.questionnaire != null;
        console.log(response.data);
       }
    }
    const getReturnPath = () => {
      return returnPath;
    }

    const getMainImage = () => {
      let imagePath = undefined;

      if (retrievedTask.value != null && retrievedTask.value.task != null &&
        retrievedTask.value.task.taskAttributeList != null && retrievedTask.value.task.taskAttributeList.length > 0) {

        const imageUri = retrievedTask.value.task.taskAttributeList.find(attribute => attribute.attributeCode === "ImageUri");
        imagePath = imageUri != null ? imageUri.attributeValue : undefined;
      }
      return imagePath;
    };

    const handleStartChallenge = () => {
      enableTaskManager.value = true;
    }

    const handleEvtCloseTaskManagerModal = () => {
      enableTaskManager.value = false;
    }

    initComponent();
    return {
      retrievedTask, returnPath, type, startChallenge, enableMainContent, enableTaskManager,
      handleStartChallenge, getMainImage, getReturnPath, handleEvtCloseTaskManagerModal
    }
  }
}
</script>
    

    