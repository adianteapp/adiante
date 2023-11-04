<template>
<headerMenu />
  <div class="container-fluid">
    <h2 v-if="selectedActivityType == 'tt-challenge'">{{$t('challenges.title')}}</h2>
    <h2 v-if="selectedActivityType == 'tt-guided-activity'">{{ $t('guided_activities.title')}}</h2>

        <div v-for="(taskItem) in taskList" :key="taskItem.taskId">
            <card  :taskData="taskItem"  @click.prevent="showActivityIntroInfo(taskItem)"/>
        </div>
  </div>
  <footerMenu />
</template> 
   
<script>
import { useRoute,useRouter } from 'vue-router';
import { ref } from 'vue';
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
import Card from '../components/common/Card.vue';
import taskService from '../services/task.service';

export default {
  name: 'ActivitiesView',
  props: {
    msg: String
  },
  components: {
    headerMenu: HeaderMenu,
    footerMenu: FooterMenu,
    card: Card
  },
  setup() {
    const route = useRoute();
    const router = useRouter()
    const selectedActivityType = route.query.type;
    const taskList = ref([]);

    const initComponent = async () => {
      const response = await taskService.getTasksByType(selectedActivityType);
      if(response.isAxiosError){
        console.log("Error retrieving tasks on ActivitiesView");
      }else{
        taskList.value = response.tasksList;
      }
    }

    const showActivityIntroInfo = (taskItem) => {
      router.push(`/activity-intro?type=`+`${selectedActivityType}`+`&taskId=`+`${taskItem.taskId}`)
    }


    initComponent();
    return { selectedActivityType,taskList,
             showActivityIntroInfo}
  }
}
</script>
    

    