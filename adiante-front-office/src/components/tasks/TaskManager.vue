<!--
  This component is in charge to load the cuestionnaries based on the cuestionnaire-type value
-->
<template> 
     <QuestionnaireLoader :loadedTask="loadedTask" @evtPatientAnswers="handlePatientAnswersEvent"/>
     <!--
<component  :is="taskComponent" :loadedTask="loadedTask" @custom-event="handlePatientAnswersEvent"/>
     -->
     
</template> 
   

<script>
import { ref } from "vue";
import patientService from "../../services/patient.service";
import QuestionnaireLoader from "../questionnaires/QuestionnaireLoader.vue";
import { useStore } from 'vuex'
export default ({
  name: 'TaskManager',
  components: {
    QuestionnaireLoader:QuestionnaireLoader
  },
 setup() {

//#region Attributes init
const store = useStore()


const loadedTask = {
        idTask: 1,
        codeName: "t-01-get-mood",
        freeExecution: 1,
        taskTitle:"Responde a la pregunta",
        taskDescription:"Basado en tu estado de ánimo, vamos a pedirte que respondas a un par de preguntas:",
        taskType: {
            codeName: "tt-questionnaire"
        },
        questionnaire: {
            questions: [
                {
                    answers: [
                        {
                            id: 6,
                            idQuestion: 2,
                            i18n: "Me siento triste"
                        },
                        {
                            id: 7,
                            idQuestion: 2,
                            i18n: "Estoy muy cansado"
                        },
                        {
                            id: 8,
                            idQuestion: 2,
                            i18n: "No me apetece hacer nada"
                        }
                    ],
                    id: 2,
                    i18n: "¿Tienes alguno de los siguientes sintomas?",
                    questionType: {
                        codeName: "qt-select-one"
                    }
                },  {
                    answers: [
                        {
                            id: 9,
                            idQuestion: 3,


                            i18n: "Hablar con alguien"
                        },
                        {
                            id: 10,
                            idQuestion: 3,
                            i18n: "Leer un libro"
                        },
                        {
                            id: 11,
                            idQuestion: 3,
                            i18n: "Salir a caminar"
                        }
                    ],
                    id: 3,
                    i18n: "¿Qué crees que te animaría?",
                    questionType: {
                        codeName: "qt-select-mult"
                    }
                },  
                {
                    answers: [ ],
                    id: 4,
                    i18n: "Pregunta de respuesta libre",
                    questionType: {
                        codeName: "qt-free-answer"
                    }
                }


            ],
            id: 1,
            questionnaireType: {
                codeName: "qt-stepper"
            }
        }
    };
//const loadedTask = ref(props.loadedTask).value;
const taskComponent = ref(null);



//#endregion Attributes init

//#region Functions declaration init
 
function loadTaskComponent(taskType){
 

     switch (taskType) {
       case "tt-questionnaire":
       taskComponent.value = QuestionnaireLoader;
            break;
       default:
         console.log("Error there is no questionnaire for questionnaireType:"+taskType);
         break;
      }
    }

const handlePatientAnswersEvent = (msg) => {
    savePatientActivity(msg);
    };


async function savePatientActivity(patientActivity) {

   

    //Retrieving info.
    const patientId =  store.state.auth.user.id;
    let questionnaireId = undefined;
    if(loadedTask.questionnaire && loadedTask.questionnaire.id){
        questionnaireId = loadedTask.questionnaire.id;
    }
    const taskId = loadedTask.id;

    const saveResult = await patientService.saveQuestionnaire(patientId,taskId,questionnaireId,patientActivity);
    if(saveResult.isAxiosError)
    {

    alert("Ha ocurrido un error salvando el estado del paciente");
    }else{
        alert("Actividad del paciente salvada correctamente");
    }
}

  
//#endregion

  //Init the components
    if(loadedTask && loadedTask.taskType &&  loadedTask.taskType.codeName){
        loadTaskComponent(loadedTask.taskType.codeName);
  }else{
    console.log("Error loading task component");
  }


  return{taskComponent,loadedTask,handlePatientAnswersEvent}
  }
})
</script>
