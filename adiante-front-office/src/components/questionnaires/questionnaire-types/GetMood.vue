<template>
  <section class="widget widget-state">
    <div class="header">
      <h2>{{ (moodQuestionnaireResult.questionnaire.questions)[0].i18n }}</h2>
    </div>
    <div class="content">
      <div class="states">
        <div class="state" v-for="(answer, index) in (moodQuestionnaireResult.questionnaire.questions)[0].answers"
          :key="index" @click="finishQuestionnaire(answer)">
          <img :src="getImagePath(answer)" :alt="answer.answerValue">
          <span>{{ answer.answerValue }}</span>
        </div>
      </div>
    </div>
  </section>
</template>

<script>

import { defineComponent } from "vue";
import { ref } from "vue";

export default defineComponent({
  name: 'GetMood',

  props: ['loadedTask'],
  async setup(props,{ emit }) {

    const moodQuestionnaireResult = ref(props.loadedTask).value;

    const modalActive = ref(false);
    const toggleModal = () => {
      modalActive.value = !modalActive.value;
    };
    //#region methods declaration
    const getImagePath = (answer) => {
      return `img/questionnaires/get-mood-states/state` + answer.answerId + `.svg`;
    }

    const finishQuestionnaire = (answer) =>{
      const pantientAnswers =  {answersList:[{idQuestion:answer.questionId,idAnswer:answer.answerId}],answerRelatedTaskId:answer.answerRelatedTaskId,task: moodQuestionnaireResult };
    emit('evtPatientAnswers', pantientAnswers );
  };

    return {getImagePath,toggleModal,finishQuestionnaire,moodQuestionnaireResult}
  }
});


</script> 

