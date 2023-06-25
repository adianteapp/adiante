<!--
  This component is in charge to load the cuestionnaries based on the cuestionnaire-type value
-->
<template> 
    <taskComponentsLoader v-if="componentsVisibility.showTaskOnContent" :loadedTask="loadedTask" @evtPatientAnswers="handlePatientAnswersEvent"/>
    <div v-if="showTaskOnModalRef" >
        <taskModal :task="modalLoadedTask" :showButtonClose="true" @evtModalPatientAnswers.once="handlePatientAnswersEvent" @evtCloseTaskModal="handleCloseTaskModalEvent"/>
    </div>
    
    <getMoodFeedbackModal v-if="showMoodFeedbackModal" :showButtonClose="true"  @evtCloseTaskModal="handleCloseTaskModalEvent"/>
</template> 
   

<script>
import { ref } from "vue";
import patientService from "../../services/patient.service";
import taskService from    "../../services/task.service";
import TaskComponentsLoader from "./TaskComponentsLoader.vue";
import TaskModal from "./TaskModal.vue";
import GetMoodFeedbackModal from "../feedback-modals/GetMoodFeedbackModal.vue";

export default ({
  name: 'TaskManager',
  props: ['taskId','questionnaireType','showOnModal'],
  components: {
    taskComponentsLoader:TaskComponentsLoader,
    taskModal:TaskModal,
    getMoodFeedbackModal:GetMoodFeedbackModal
  },
 async setup(props) {

//#region Attributes init

const selectedTaskId = ref(props.taskId).value;
const selectedQuestionnaireType = ref(props.questionnaireType).value;
let showOnModal = ref(props.showOnModal).value;

let componentsVisibility = {
    showTaskOnContent : (showOnModal == true) ? false : true,
    showTaskOnModal : (showOnModal == true) ? true : false,
};

const showTaskOnModalRef = ref(false);
const showMoodFeedbackModal = ref(false);

let loadedTask = undefined;
const modalLoadedTask = ref(undefined);
const relatedTask = ref(undefined);



//#endregion Attributes init

//#region functions declaration to init task component
async function initTaskComponent(){
     const task = await retrieveTaskData(selectedTaskId,selectedQuestionnaireType);
     (showOnModal == true)? modalLoadedTask.value = task : loadedTask = task;
   
     if(!task || !task.task.taskTypeCode){
        console.log("Error loading task component for the criteria- taskId:"+selectedTaskId+" questionnaireType:"+selectedQuestionnaireType);
     }

}


async function retrieveTaskData(selectedTaskId,selectedQuestionnaireType){
    const retrievedTask = await taskService.retrieveTaskData(selectedTaskId,selectedQuestionnaireType);
      if(retrievedTask.isAxiosError)
      {
        console.log("Error loading  GetMood questionnaire");
      }else{
    
        return retrievedTask.data;
      }
}

//#region Functions declaration to save patientActivity




const handlePatientAnswersEvent = (msg) => {
    savePatientActivity(msg);
    };

const handleCloseTaskModalEvent = () => {
        showTaskOnModalRef.value = false;
        showMoodFeedbackModal.value = true;
    };


async function savePatientActivity(patientActivity) {


    //Retrieving info.
    const savedTask = await retriveTaskData();
    let auxQuestionnaireId = undefined;
    if(savedTask.questionnaire && savedTask.questionnaire.questionnaireId){
        auxQuestionnaireId = savedTask.questionnaire.questionnaireId;
    }
    const saveResult = await patientService.saveQuestionnaire(savedTask.task.taskId,auxQuestionnaireId,patientActivity.answersList);
    if(saveResult.isAxiosError)
    {

    alert("Ha ocurrido un error salvando el estado del paciente");
    }else{
        handleSavePatientActivy(patientActivity);
    }
}

async function retriveTaskData(){
    if( relatedTask.value && relatedTask.value.task)
    {
        return relatedTask.value
    }else{
        if(loadedTask){
            return loadedTask;
        }else{
           return modalLoadedTask.value; 
        }


    }

}




async function handleSavePatientActivy(patientActivity){
   if(patientActivity && patientActivity.answerRelatedTaskId){
      //LoadRelatedTaskModal
      loadRelatedTaskModal(patientActivity.answerRelatedTaskId);
   }else{
    showMoodFeedbackModal.value = true;
    showTaskOnModalRef.value = false;
   }
}






//#region functions to handle the related task for the pantient selected answer
async function loadRelatedTaskModal(relatedTaskId){
    modalLoadedTask.value =  await retrieveTaskData(relatedTaskId,null);
    relatedTask.value = modalLoadedTask.value;
    if(modalLoadedTask.value){
        showTaskOnModalRef.value = true;
    }else{
        console.log("Error retrieving the relatedtask for taskId:"+relatedTaskId);
        //show feedback anyway;
        showMoodFeedbackModal.value = true;
    }
}

//#endregion functions to handle the related task for the pantient selected answer




  
//#endregion Functions declaration to save patientActivity

  await initTaskComponent();

  return{componentsVisibility,showTaskOnModalRef,loadedTask,modalLoadedTask,showMoodFeedbackModal,handlePatientAnswersEvent,handleCloseTaskModalEvent}
  }
})
</script>
