<!--
  This component is in charge to load the cuestionnaries based on the cuestionnaire-type value
-->
<template> 
     <component  :is="questionnaireComponent" :loadedTask="questionnaireTask"/>
</template> 
   

<script>
import StepperQuestions from "./questionnaire-types/StepperQuestions.vue";
import GetMood from "./questionnaire-types/GetMood.vue";
import { ref } from "vue";


export default({
  name: 'QuestionnaireLoader',
  props: ['loadedTask'],
  components: {
    StepperQuestions,
    GetMood
  },
 setup(props,{emit}) {

//#region Attributes init


const questionnaireTask = ref(props.loadedTask).value;

const questionnaireComponent = ref(null);



//#endregion Attributes init

//#region Functions declaration init
 
  function loadQuestionnaireComponent(questionnaireType){
 

     switch (questionnaireType) {
       case "qt-stepper":
       questionnaireComponent.value = StepperQuestions;
            break;
       case "qt-dashboard":
       questionnaireComponent.value = GetMood;
            break;
       default:
         console.log("Error there is no questionnaire for questionnaireType:"+questionnaireType);
         break;
      }
    }

const handleCuestionnaireAnswersEvent = (msg) => {
      emit('evtModalPatientAnswers',msg);
    };

  
//#endregion

  //Init the components
  if(questionnaireTask &&  questionnaireTask.questionnaire && questionnaireTask.questionnaire.questionnaireType){
    loadQuestionnaireComponent(questionnaireTask.questionnaire.questionnaireType);
  }else{
    console.log("Error loading questionnaire component");
  }
  

  //return{questionnaireComponent,questionnaireTask,handleCuestionnaireAnswersEvent}
  return{questionnaireComponent,questionnaireTask,handleCuestionnaireAnswersEvent}
  }
})
</script>
