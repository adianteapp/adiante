<!-- eslint-disable vue/valid-v-on -->
<template>
  
  <section class="widget widget-state">
    <div class="header">
      <h2>{{ (this.taskMoodQuestionnaire.questionnaire.questions)[0].i18n }}</h2>
    </div>
    <div class="content">
      <div class="states">
        <div class="state" v-for="(answer, index) in (this.taskMoodQuestionnaire.questionnaire.questions)[0].answers" :key="index" @click="processAnswer(answer)">
          <img :src="getImagePath(answer)" :alt="answer.i18n">
          <span>{{ answer.i18n }}</span>
        </div>
      </div>
      <div>
        <getMoodFeedbackModal    v-if="modalActive" @close="toggleModal" />
      </div>
    </div>
  </section>
</template>

<script>
import patientService from "../../../../services/patient.service";
import taskService from    "../../../../services/task.service";
import { defineComponent } from "vue";
import { useStore } from 'vuex'
import { computed } from 'vue'
import { ref } from "vue";
import GetMoodFeedbackModal from "../../../feedback-modals/GetMoodFeedbackModal.vue";

export default defineComponent({
  name: 'GetMood',
  components:{
    getMoodFeedbackModal : GetMoodFeedbackModal
  },
  async setup() {
     
      const store = useStore();
      const patientId = computed( () => store.state.auth.user.id);

      const modalActive = ref(false);
      const toggleModal = () => {
                                  modalActive.value = !modalActive.value;
                                };

    
      const moodQuestionnaireResult = await taskService.getMoodQuestionnaireTask(patientId.value);
      if(moodQuestionnaireResult.isAxiosError)
      {
        console.log("Error loading  GetMood questionnaire");
      }else{
        const taskMoodQuestionnaire = moodQuestionnaireResult.data.task;
        return {modalActive, toggleModal,taskMoodQuestionnaire};
      }
  },
  methods: {
    getImagePath(answer) {
      return `img/questionnaires/get-mood-states/state`+answer.id+`.svg`;
    },

    async processAnswer(selectedAnswer) {

      this.loading = true;
  
      //Retrieving info.
      const patientId =  this.$store.state.auth.user.id;
      const questionId = (this.taskMoodQuestionnaire.questionnaire.questions)[0].id;
      const questionnaireId = this.taskMoodQuestionnaire.questionnaire.id;
      const taskId = this.taskMoodQuestionnaire.id;
      const answersList =  [{idQuestion:questionId,idAnswer:selectedAnswer.id}];

      const saveResult = await patientService.saveQuestionnaire(patientId,taskId,questionnaireId,answersList);
      if(saveResult.isAxiosError)
      {
        this.loading = false;
        alert("Ha ocurrido un error salvando el estado del paciente");
      }else{
        this.loading = false;
        this.toggleModal();
      }
    },


  },
});
</script>
