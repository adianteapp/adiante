<!--
  This component is in charge to load the cuestionnaries based on the cuestionnaire-type value
-->
<template> 

    <taskComponentsLoader v-if="componentsVisibility.showTaskOnContent" 
                         :loadedTask="loadedTask" 
                         @evtPatientAnswers="handlePatientAnswersEvent"/>
    <div v-if="showTaskOnModalRef" >
        <taskModal :task="modalLoadedTask" 
                   :showButtonClose="true" 
                   @evtModalPatientAnswers.once="handlePatientAnswersEvent" 
                   @evtCloseTaskModal="handleCloseTaskModalEvent" 
                   @evtConfirmExecution="handleConfirmExecution"/>
    </div>
    
    <getMoodFeedbackModal v-if="showMoodFeedbackModal" 
                            :showButtonClose="true"  
                            @evtCloseTaskModal="handleCloseGetMoodFeedback"/>

    <generalFeedbackModal v-if="showGeneralFeedbackModal" 
                            :showButtonClose="true"  
                            :title="$t('agenda.general_feedback.title')" 
                            :content="$t('agenda.general_feedback.content')"
                            @evtCloseTaskModal="handleCloseGeneralFeedback"/>

</template> 


<script>
import { ref } from "vue";
import patientService from "../../services/patient.service";
import taskService from    "../../services/task.service";
import TaskComponentsLoader from "./TaskComponentsLoader.vue";
import TaskModal from "./TaskModal.vue";
import Modal from "../common/Modal.vue";
import GetMoodFeedbackModal from "../feedback-modals/GetMoodFeedbackModal.vue";

export default ({
  name: 'TaskManager',
  props: ['taskId','questionnaireType','showOnModal','scheduledTask'],
  components: {
    taskComponentsLoader:TaskComponentsLoader,
    taskModal:TaskModal,
    generalFeedbackModal:Modal,
    getMoodFeedbackModal:GetMoodFeedbackModal
  },
 async setup(props,{emit}) {

//#region Attributes init

const selectedTaskId = ref(props.taskId).value;
const selectedQuestionnaireType = ref(props.questionnaireType).value;
const providedScheduledTask = ref(props.scheduledTask).value;
let showOnModal = ref(props.showOnModal).value;

let componentsVisibility = {
    showTaskOnContent : (showOnModal == true) ? false : true,
    showTaskOnModal : (showOnModal == true) ? true : false,
};

const showTaskOnModalRef = ref( showOnModal ? true:false);
const showMoodFeedbackModal = ref(false);
const showGeneralFeedbackModal = ref(false);

const isMoodQuestionnaire = selectedQuestionnaireType != null && selectedQuestionnaireType == "qt-dashboard" ? true : false;

let loadedTask = undefined;
const modalLoadedTask = ref(undefined);
const relatedTask = ref(undefined);



//#endregion Attributes init

//#region functions declaration to init task component
async function initTaskComponent(){
     const task = await retrieveTaskData(selectedTaskId,selectedQuestionnaireType,providedScheduledTask);
     (showOnModal == true)? modalLoadedTask.value = task : loadedTask = task;
   
     if(!task || !task.task.taskTypeCode){
        console.log("Error loading task component for the criteria- taskId:"+selectedTaskId+" questionnaireType:"+selectedQuestionnaireType);
     }

}

async function getTaskFromScheduledTask(scheduledTask){
    const task = {task:{taskId:scheduledTask.taskId,
                        title:scheduledTask.title,
                        description:scheduledTask.description,
                        taskTypeCode:scheduledTask.taskTypeCode,
                        relatedQuestionnaireId:scheduledTask.relatedQuestionnaireId,
                        scheduledTaskId:scheduledTask.scheduledId,
                        startDateTimeLocal:scheduledTask.startDateTimeLocal,
                        endDateTimeLocal:scheduledTask.endDateTimeLocal,
                        executionDateTimeLocal:scheduledTask.executionDateTimeLocal}}
    return task;
}

async function addScheduledTaskInfoToTask(task){
    if(task && task.task && providedScheduledTask != null ){
        task.task.scheduledTaskId = providedScheduledTask.scheduledId;
        task.task.startDateTimeLocal =providedScheduledTask.startDateTimeLocal;
        task.task.endDateTimeLocal =providedScheduledTask.endDateTimeLocal;
        task.task.executionDateTimeLocal =providedScheduledTask.executionDateTimeLocal;
    }
    return task;
}


async function retrieveTaskData(selectedTaskId,selectedQuestionnaireType,providedTask){
    if(providedTask && providedTask.taskTypeCode == "tt-completion-check"){
                return getTaskFromScheduledTask(providedTask);
    }

    const taskId = (providedTask && providedTask.relatedQuestionnaireId != null) ? providedTask.taskId : selectedTaskId;

    const retrievedTask = await taskService.retrieveTaskData(taskId,selectedQuestionnaireType);
    if(retrievedTask.isAxiosError){
            console.log("Error loading  GetMood questionnaire");
    }else{
        return  addScheduledTaskInfoToTask(retrievedTask.data);
    }
    
}

//#region Functions declaration to save patientActivity

const handleCloseGetMoodFeedback = () => {
       showMoodFeedbackModal.value = false;
    };  

 const handleCloseGeneralFeedback = () => {
      showGeneralFeedbackModal.value = false;
    };  

const handleConfirmExecution = (msg) => {
        saveConfirmationExecution(msg);
    };  

async function saveConfirmationExecution(msg){
    const saveResult = await patientService.saveConfirmationExecution(msg.scheduledTask.task.taskId,msg.scheduledTask.task.scheduledTaskId);
    if(saveResult.isAxiosError)
    {
    alert("Ha ocurrido un error salvando el estado del paciente");
    }else{
        showTaskOnModalRef.value = false;

        isMoodQuestionnaire ? showMoodFeedbackModal.value = true : showGeneralFeedbackModal.value = true;
    }
}



const handlePatientAnswersEvent = (msg) => {
    savePatientActivity(msg);
    };

const handleCloseTaskModalEvent = () => {

            emit('evtCloseTaskManagerModal');
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
      //CloseTaskModal
      showTaskOnModalRef.value = false;
      isMoodQuestionnaire ? showMoodFeedbackModal.value = true : showGeneralFeedbackModal.value = true;
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
        isMoodQuestionnaire ? showMoodFeedbackModal.value = true : showGeneralFeedbackModal.value = true;
    }
}

//#endregion functions to handle the related task for the pantient selected answer




  
//#endregion Functions declaration to save patientActivity

  await initTaskComponent();

  return{componentsVisibility,showTaskOnModalRef,loadedTask,modalLoadedTask,showMoodFeedbackModal,showGeneralFeedbackModal,
        handlePatientAnswersEvent,handleCloseTaskModalEvent,handleConfirmExecution,handleCloseGetMoodFeedback,handleCloseGeneralFeedback}
  }
})
</script>