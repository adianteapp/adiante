<!--
  This component is in charge to load the different task loaders based on the task-type value
-->
<template> 
    <!-- <QuestionnaireLoader :loadedTask="loadedTask" @evtPatientAnswers="handlePatientAnswersEvent"/>-->
    <component  :is="loaderComponent" 
                :loadedTask="loadedTask"  
                @evtModalPatientAnswers="handlePatientAnswersEvent" 
                @evtCloseTaskManagerModal="handleCloseTaskModalEvent"/>
</template> 
   

<script>
import { ref } from "vue";
import QuestionnaireLoader from "../questionnaires/QuestionnaireLoader.vue";
import CompletionCheckTasksLoader from "../completion-check/CompletionCheckTasksLoader.vue";

export default ({
  name: 'TaskComponentsLoader',
  props: ['loadedTask'],
  components: {
    QuestionnaireLoader,
    CompletionCheckTasksLoader
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
       case "tt-completion-check":
            loaderComponent.value = CompletionCheckTasksLoader;
            break;
       case "tt-challenge":
            loaderComponent.value = QuestionnaireLoader;
            break;
       default:
         console.log("Error retrieving loaderComponent for taskType:"+retrievedTask.task.taskTypeCode);
         break;
      }
    }

    const handleConfirmExecution = (msg) => {
      emit('evtConfirmExecution',msg);
    };

    const handlePatientAnswersEvent = (msg) => {
      emit('evtModalPatientAnswers',msg);
    };

const handleCloseTaskModalEvent = () => {
  emit('evtCloseTaskModal');
}



await initTaskComponent();


  return{loaderComponent,retrievedTask,
        handlePatientAnswersEvent,handleConfirmExecution,handleCloseTaskModalEvent}
  }
})
</script>
