<!--
  This component is in charge to load the different task loaders based on the task-type value
-->
<template> 
    <!-- <QuestionnaireLoader :loadedTask="loadedTask" @evtPatientAnswers="handlePatientAnswersEvent"/>-->
    <component  :is="loaderComponent" :loadedTask="loadedTask"  @evtModalPatientAnswers="handlePatientAnswersEvent"/>
</template> 
   

<script>
import { ref } from "vue";
import QuestionnaireLoader from "../questionnaires/QuestionnaireLoader.vue";


export default ({
  name: 'TaskComponentsLoader',
  props: ['loadedTask'],
  components: {
    QuestionnaireLoader:QuestionnaireLoader
  },
 async setup(props,{emit}) {

//#region Attributes init

const retrievedTask = ref(props.loadedTask).value;

const loaderComponent = ref(null);



//#endregion Attributes init

//#region functions declaration to init task component
async function initTaskComponent(){
      
     if(retrievedTask && retrievedTask.task.taskTypeCode){
        getLoaderComponent();
     }else{ 
        console.log("Error selecting the loader component for the - taskId:"+retrievedTask.taskId);
     }

}


async function  getLoaderComponent(){
 
     switch (retrievedTask.task.taskTypeCode) {
       case "tt-questionnaire":
       loaderComponent.value = QuestionnaireLoader;
            break;
       default:
         console.log("Error retrieving loaderComponent for taskType:"+retrievedTask.task.taskTypeCode);
         break;
      }
    }

    const handlePatientAnswersEvent = (msg) => {
      emit('evtModalPatientAnswers',msg);
    };


await initTaskComponent();


  return{loaderComponent,retrievedTask,handlePatientAnswersEvent}
  }
})
</script>
