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

    <generalFeedbackModal v-if="showGeneralFeedbackModal" 
                            :showButtonClose="true"
                            :isGetMoodFeedback="isMoodQuestionnaire"  
                            :taskType="feedbackModalTaskType"
                            @evtCloseTaskModal="handleCloseGeneralFeedback"/>

</template> 


<script>
import { ref } from "vue";
import patientService from "../../services/patient.service";
import taskService from    "../../services/task.service";
import TaskComponentsLoader from "./TaskComponentsLoader.vue";
import TaskModal from "./TaskModal.vue";
import GeneralFeedbackModal from "../feedback-modals/GeneralFeedbackModal.vue";

export default ({
  name: 'TaskManager',
  props: ['taskId','questionnaireType','showOnModal','taskData'],
  components: {
    taskComponentsLoader:TaskComponentsLoader,
    taskModal:TaskModal,
    generalFeedbackModal:GeneralFeedbackModal
  },
 async setup(props,{emit}) {

//#region Attributes init

const selectedTaskId = ref(props.taskId).value;
const selectedQuestionnaireType = ref(props.questionnaireType).value;
const providedScheduledTask = ref(props.taskData).value;
const feedbackModalTaskType = ref(undefined);
const paeId = ref(undefined);
let showOnModal = ref(props.showOnModal).value;


let componentsVisibility = {
    showTaskOnContent : (showOnModal == true) ? false : true,
    showTaskOnModal : (showOnModal == true) ? true : false,
};

const showTaskOnModalRef = ref( showOnModal ? true:false);
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

async function addScheduledTaskInfoToTask(taskData){
    if(taskData && taskData.task && providedScheduledTask != null ){
        taskData.task.scheduledTaskId = providedScheduledTask.scheduledId;
        taskData.task.startDateTimeLocal =providedScheduledTask.startDateTimeLocal;
        taskData.task.endDateTimeLocal =providedScheduledTask.endDateTimeLocal;
        taskData.task.executionDateTimeLocal =providedScheduledTask.executionDateTimeLocal;
    }
    return taskData;
}


async function retrieveTaskData(selectedTaskId,selectedQuestionnaireType,providedTask){
    
    if(providedTask && providedTask.taskTypeCode == "tt-completion-check"){
                return getTaskFromScheduledTask(providedTask);
    }

    if(providedTask && providedTask.questionnaire != null){
                return providedTask;
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
    showGeneralFeedbackModal.value = false;
    };  

 const handleCloseGeneralFeedback = () => {
      showGeneralFeedbackModal.value = false;
      emit('evtCloseTaskManagerModal');
    };  

const handleConfirmExecution = (msg) => {
        saveConfirmationExecution(msg);
    };  

async function saveConfirmationExecution(msg){
    const saveResult = await patientService.saveConfirmationExecution(msg.scheduledTask.task.taskId,msg.scheduledTask.task.scheduledTaskId,paeId.value);
    if(saveResult.isAxiosError)
    {
    alert("Ha ocurrido un error salvando el estado del paciente");
    }else{
        showTaskOnModalRef.value = false;
        feedbackModalTaskType.value = isMoodQuestionnaire ? undefined:  modalLoadedTask.value.task.taskTypeCode;
        showGeneralFeedbackModal.value = true;
        paeId.value = saveResult.data.paeId;
    }
}



const handlePatientAnswersEvent = (msg) => {
    savePatientActivity(msg);
    };

const handleCloseTaskModalEvent = () => {
            showTaskOnModalRef.value = false;
            emit('evtCloseTaskManagerModal');
    };


async function savePatientActivity(patientActivity) {


    //Retrieving info.
    const savedTask = patientActivity.task;
    let auxQuestionnaireId = undefined;
    if(savedTask.questionnaire && savedTask.questionnaire.questionnaireId){
        auxQuestionnaireId = savedTask.questionnaire.questionnaireId;
    }
    const saveResult = await patientService.saveQuestionnaire(savedTask.task.taskId,savedTask.task.scheduledTaskId,auxQuestionnaireId,patientActivity.answersList,paeId.value);
    if(saveResult.isAxiosError)
    {
          alert("Ha ocurrido un error salvando el estado del paciente");
    }else{
          paeId.value = saveResult.data.paeId;
          handleSavePatientActivy(patientActivity);
    }
}


async function handleSavePatientActivy(patientActivity){
   if(patientActivity && patientActivity.answerRelatedTaskId){
      //LoadRelatedTaskModal
      loadRelatedTaskModal(patientActivity.answerRelatedTaskId);
   }else{
      //CloseTaskModal
      showTaskOnModalRef.value = false;
      showGeneralFeedbackModal.value = true;
      feedbackModalTaskType.value = isMoodQuestionnaire ? undefined:  modalLoadedTask.value.task.taskTypeCode;
      //Reset paeId
      paeId.value = undefined;
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
        //Reset paeId
        paeId.value = undefined;
        //show feedback anyway;
        showGeneralFeedbackModal.value = true;
        feedbackModalTaskType.value = isMoodQuestionnaire ? undefined:  modalLoadedTask.value.task.taskTypeCode;
    }
}

//#endregion functions to handle the related task for the pantient selected answer




  
//#endregion Functions declaration to save patientActivity

  await initTaskComponent();

  return{componentsVisibility,showTaskOnModalRef,loadedTask,modalLoadedTask,showGeneralFeedbackModal,isMoodQuestionnaire,feedbackModalTaskType,
        handlePatientAnswersEvent,handleCloseTaskModalEvent,handleConfirmExecution,handleCloseGetMoodFeedback,handleCloseGeneralFeedback}
  }
})
</script>