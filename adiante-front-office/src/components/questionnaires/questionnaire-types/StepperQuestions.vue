<template>  
          
          <scheduledTask 
              v-if="showScheduledTask"
               :scheduledTaskData="loadedTask" 
               :showFullInfo="true"/>
          <!-- Questionnaries content -->
          <component  
                  v-if="showQuestionnaire"
                  :is="questionComponent" 
                  :question="currentQuestion" 
                  :selectedAnswers="selectedAnswers"
                  :key="currentQuestion.questionId"
                  ref="questionComponentRef" />
     
        <div class="modal-footer footer-task-modal">
          <div class="buttons">
            <button v-if="buttonsManager.buttonCloseEnabled"  @click.prevent="closeQuestionnaire"  type="button" class="btn btn-secondary" data-bs-dismiss="modal">
              {{$t('agenda.scheduled_task.modal.close')}}
            </button>          
            <button v-if="buttonsManager.buttonStartEnabled"  @click.prevent="startQuestionnaire"  type="button" class="btn btn-primary" data-bs-dismiss="modal">
              {{$t('agenda.scheduled_task.modal.start')}}
            </button>
            <button v-if="buttonsManager.buttonBackEnabled"  @click.prevent="backOnQuestion"  type="button" class="btn btn-secondary" data-bs-dismiss="modal">
              {{$t('modal_prev_button_label')}}
            </button>          
            <button v-if="buttonsManager.buttonNextEnabled"  @click.prevent="nextOnQuestion"  type="button" class="btn btn-primary" data-bs-dismiss="modal">
              {{$t('modal_next_button_label')}}
            </button>
            <button v-if="buttonsManager.buttonFinishEnabled"   @click.prevent="finishQuestionnaire"  type="button" class="btn btn-primary" data-bs-dismiss="modal">
              {{$t('modal_finish_button_label')}}
            </button>           
          </div>
        </div>
</template> 
   

<script>
import { defineComponent } from "vue";
import QuestionCheckbox from "../question-types/QuestionCheckbox.vue";
import QuestionRadio from "../question-types/QuestionRadio.vue";
import QuestionTextarea from "../question-types/QuestionTextarea.vue";
import ScheduledTask from "../../tasks/ScheduledTask.vue";
import { ref,toRaw } from "vue";


export default defineComponent({
  name: 'StepperQuestions',
  components: {
      scheduledTask:ScheduledTask,
      QuestionCheckbox,
      QuestionRadio,
      QuestionTextarea
  },
  props:['loadedTask'],
  async setup(props,{ emit }) {

//#region Attributes init

const loadedTask = ref(props.loadedTask).value;
  
const showScheduledTask = ref( loadedTask.task.scheduledTaskId != undefined ? true : false);
const isCompletedScheduledTask = ref(loadedTask.task.executionDateTimeLocal != null ? true : false);
const showQuestionnaire = ref(loadedTask.task.scheduledTaskId == undefined ? true : false);


  let buttonsManager = {
     buttonStartEnabled : showScheduledTask.value && !isCompletedScheduledTask.value ?true :false,
     buttonCloseEnabled : showScheduledTask.value ?true :false,
     buttonBackEnabled : false,
     buttonNextEnabled :   !showScheduledTask.value && loadedTask.questionnaire.questions.length > 1 ? true: false ,
     buttonFinishEnabled : !showScheduledTask.value && loadedTask.questionnaire.questions.length == 1 ? true : false ,
  }



  let questionnaireCurrentIndex = ref(0);

  let questionComponent = ref(null);
  let questionComponentRef = ref(null);
  let currentQuestion = ref(loadedTask.questionnaire.questions[questionnaireCurrentIndex.value]);
  const selectedAnswers = ref([]);

//#endregion Attributes init

//#region Functions declaration init
  
   const backOnQuestion = () =>{
      const nextIndex = questionnaireCurrentIndex.value  - 1;
      changeQuestionComponent(nextIndex)
  };

  const nextOnQuestion = () =>{
    const nextIndex = questionnaireCurrentIndex.value  + 1;
    changeQuestionComponent(nextIndex);
  };

  function changeQuestionComponent(nextIndex){
   
    //To avoid the validation on the last question
    if(nextIndex > questionnaireCurrentIndex.value){
      if(validateAnswersOnComponent()){

        getAnswersFromCurrentComponent();
        loadNextQuestionComponent(nextIndex);
        updateButtonsVisibility(nextIndex);
      }

    }else{
      getAnswersFromCurrentComponent();
      loadNextQuestionComponent(nextIndex);
      updateButtonsVisibility(nextIndex);
    }
  }

 


  function loadNextQuestionComponent(questionIndex){
     
     questionnaireCurrentIndex.value = questionIndex;
     currentQuestion.value = loadedTask.questionnaire.questions[questionnaireCurrentIndex.value];
 
     const questionType = currentQuestion.value.questionType;
     switch (questionType) {
       case "qt-select-one":
           questionComponent.value = QuestionRadio;
           
            break;
       case "qt-select-mult":
           questionComponent.value = QuestionCheckbox;
            break;
       case "qt-free-answer":
           questionComponent.value = QuestionTextarea;
            break; 
       default:
         console.log("Error there is no component for questionType");
         break;
      }
      if(questionComponentRef && questionComponentRef.value){
        questionComponentRef.value.updateCurrentQuestion(currentQuestion.value);
      }
      
    }

  function updateButtonsVisibility(nextIndex){
    buttonsManager.buttonBackEnabled = nextIndex == 0 ? false: true;
    buttonsManager.buttonNextEnabled =  nextIndex == (loadedTask.questionnaire.questions.length - 1) ? false: true;
    buttonsManager.buttonFinishEnabled = nextIndex == (loadedTask.questionnaire.questions.length - 1) ? true: false;
  }


  function validateAnswersOnComponent(){
    return questionComponentRef.value.validateAnswers();
  }


  function getAnswersFromCurrentComponent(){
   
   
    //Clean previous answers for the current question.
    selectedAnswers.value =  Array.from(toRaw(selectedAnswers.value).filter(answer => answer.idQuestion != currentQuestion.value.questionId));
   

    let currentAnswers = questionComponentRef.value.getAnswers();
    console.log("Retrieved answers:"+currentAnswers);

    if(currentAnswers && currentAnswers.length > 0){
      //Adding the new answers
      selectedAnswers.value.push(...currentAnswers);
    }
  } 

  const startQuestionnaire = () =>{
      showScheduledTask.value = false;
      showQuestionnaire.value = true;
      buttonsManager.buttonStartEnabled = false;
      buttonsManager.buttonCloseEnabled = false;
      buttonsManager.buttonNextEnabled =   loadedTask.questionnaire.questions.length > 1 ? true: false;
      buttonsManager.buttonFinishEnabled = loadedTask.questionnaire.questions.length == 1 ? true : false;
  };

  const finishQuestionnaire = () =>{
    getAnswersFromCurrentComponent();
    emit('evtModalPatientAnswers', {answersList:toRaw(selectedAnswers.value),task:loadedTask} );
  };

  const closeQuestionnaire = () =>{
    emit('evtCloseTaskModal');
  };

//#endregion

  //Init the components
  loadNextQuestionComponent(0);

  return{buttonsManager,questionComponent,questionComponentRef,currentQuestion,selectedAnswers,showScheduledTask,showQuestionnaire,
         closeQuestionnaire,startQuestionnaire,backOnQuestion,nextOnQuestion,finishQuestionnaire}
  }
})
</script>
