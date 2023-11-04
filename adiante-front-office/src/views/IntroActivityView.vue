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
      <Suspense>
        <taskAttributeLoaderModal v-if="enableAttributeLoaderModal" :showOnModal="true" :taskData="retrievedTask"
          @evtCloseTaskAttributeLoaderModal="handleEvtCloseTaskAttributeLoaderModal" />
      </Suspense>





       </div>


       <div class="button-activity"> 
        

       <button v-if="showMoreInfoButton" type="button" @click.prevent="handleShowMoreInfo" class="btn btn-outline-primary mb-2 w-100"> <i class="icon-play-2"></i>
        {{ $t('intro_activities.showMoreInfoButton') }}
       </button>

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
import TaskManager from '../components/tasks/TaskManager.vue';
import TaskAttributeLoaderModal from '../components/task-attributes/TaskAttributeLoaderModal.vue';
import HeaderMenu from '../components/common/HeaderMenu.vue';
import FooterMenu from '../components/common/FooterMenu.vue';
import canBeShownTaskAttributeLoader from '../services/util/attribute-list-validator';

export default {
  name: 'IntroActivity',
  props: [],
  components: {
    headerMenu: HeaderMenu,
    FooterMenu: FooterMenu,
    taskManager: TaskManager,
    taskAttributeLoaderModal: TaskAttributeLoaderModal
  },
   setup() {
    const retrievedTask = ref(undefined);
    const route = useRoute();
    const type = route.query.type;
    const taskId = route.query.taskId;
    const returnPath = "/activities?type=" + type;

    const enableMainContent = ref(false);
   
    //modals
    const enableTaskManager = ref(false);
    const enableAttributeLoaderModal = ref(false);
    //buttons init
    const showMoreInfoButton = ref(false);
    const startChallenge = ref(false);


    const initComponent = async () => {
      const response = await taskService.getTaskById(taskId);
      if (response.isAxiosError) {
        console.log("Error retrieving task on IntroActivityView");
      } else {
        retrievedTask.value = response.data;
        enableMainContent.value = true;
        startChallenge.value = retrievedTask.value.questionnaire != null;
        showMoreInfoButton.value =  retrievedTask.value.task &&  canBeShownTaskAttributeLoader(retrievedTask.value.task.taskAttributeList)
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

    const handleShowMoreInfo = () => {
      enableAttributeLoaderModal.value = true;
    }

    const handleEvtCloseTaskManagerModal = () => {
      enableTaskManager.value = false;
    }

    const handleEvtCloseTaskAttributeLoaderModal = () => {
      enableAttributeLoaderModal.value = false;
    }

    initComponent();
    return {
      retrievedTask, returnPath, type, startChallenge, showMoreInfoButton, enableMainContent, enableTaskManager,enableAttributeLoaderModal,
      handleStartChallenge, getMainImage, getReturnPath,handleShowMoreInfo, handleEvtCloseTaskManagerModal,handleEvtCloseTaskAttributeLoaderModal
    }
  }
}
</script>
    

    