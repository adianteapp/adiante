<template>
  <headerMenu />
  <div class="introView">

   
    
    <div v-if="retrievedTask">
        <br/><br/><br/>
        <h2>{{retrievedTask.task.title}}</h2>
        <div class="backlink">
          <a :href="getReturnPath()">
                 <i class="icon-navigate_before"></i>
                 {{$t('intro_activities.backLink')}}
          </a>
        </div>
        <img :src="getMainImage()" alt="">
        <div v-if="retrievedTask.task.additionalInfo != null"  v-html="retrievedTask.task.additionalInfo"></div>
        <div v-else>{{retrievedTask.task.description}}</div>
    
      <Suspense>
        <taskManager 
              v-if="enableTaskManager" 
              :showOnModal="true"
              :taskData="retrievedTask"
               @evtCloseTaskManagerModal="handleEvtCloseTaskManagerModal"/>
      </Suspense>
        

        <button v-if="startChallenge" type="button"  @click.prevent="handleStartChallenge" class="btn btn-primary  w-100" data-bs-toggle="modal" data-bs-target="#modalVideo">
          {{$t('intro_activities.startChallengeButton')}}
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
import HeaderMenu from '../components/common/HeaderMenu.vue';
import FooterMenu from '../components/common/FooterMenu.vue';
export default {
  name: 'IntroActivity',
  props: [],
  components: {
    headerMenu: HeaderMenu,
    footerMenu: FooterMenu,
    taskManager: TaskManager
  },
  setup(){
    const retrievedTask = ref(undefined);
    const route = useRoute();
    const type = route.query.type;
    const taskId = route.query.taskId;
    const returnPath = "/activities?type="+type;
    const enableTaskManager = ref(false);

    const startChallenge = ref(false);
    

    const initComponent = async () => {
      const response = await taskService.getTaskById(taskId);
      if(response.isAxiosError){
        console.log("Error retrieving task on IntroActivityView");
      }else{
        retrievedTask.value = response.data;
        startChallenge.value = retrievedTask.value.questionnaire != null;
      }
    }
    const getReturnPath = () => {
      return returnPath;
    }

    const getMainImage =  () => {
      let imagePath = undefined;
      const defaultPath = "../assets/img/demo/reto.jpg"

      if(retrievedTask.value != null && retrievedTask.value.task != null && 
         retrievedTask.value.task.taskAttributeList != null && retrievedTask.value.task.taskAttributeList.length > 0){
          
          const imageUri = retrievedTask.value.task.taskAttributeList.find(attribute => attribute.attributeCode === "ImageUri")?.attributeValue;
          imagePath = imageUri != null ? imageUri : defaultPath;
      }else{
         imagePath = defaultPath;
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
    return{retrievedTask, returnPath,type,startChallenge,enableTaskManager,
           handleStartChallenge,getMainImage,getReturnPath,handleEvtCloseTaskManagerModal}
  }
}
</script>
    

    