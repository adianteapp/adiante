<!-- eslint-disable vue/valid-v-on -->
<template>
  <section class="widget widget-state">
    <div class="header">
      <h2>{{ question.value }}</h2>
    </div>
    <div class="content">
      <div class="states">
        <div class="state" v-for="(answer, index) in question.answers" :key="index" @click="processAnswer(answer)">
          <img :src="getImagePath(answer)" :alt="answer.altText">
          <span>{{ answer.name }}</span>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import patientService from "../../../../services/patient.service";

export default {
  name: 'GetMood',
  setup() {
    const moodQuestion = {
      questionnaireId:1,
      taskId:1,
      question: {
        questionId:1,
        value: '¿Cómo te sientes?',
        answers: [
        {
          answerId:1,
          imgSrc: 'state1.svg',
          altText: 'Muy feliz',
          name: 'Muy feliz',
        },
        {
          answerId:2,
          imgSrc: 'state2.svg',
          altText: 'Muy bien',
          name: 'Muy bien',
        },
        {
          answerId:3,
          imgSrc: 'state3.svg',
          altText: 'Indiferente',
          name: 'Indiferente',
        },
        {
          answerId:4,
          imgSrc: 'state4.svg',
          altText: 'Mal',
          name: 'Mal',
        },
        {
          answerId:5,
          imgSrc: 'state5.svg',
          altText: 'Muy mal',
          name: 'Muy mal',
        },
      ]
      },
    };
    return moodQuestion;
  },
  methods: {
    getImagePath(answer) {
      return `img/questionnaires/get-mood-states/`+answer.imgSrc;
    },

    async processAnswer(selectedAnswer) {


      this.loading = true;
  
      //Retrieving info.
      const patientId =  this.$store.state.auth.user.id;

      const answersList =  [{idQuestion:this.question.questionId,idAnswer:selectedAnswer.answerId}];

      const saveResult = await patientService.saveQuestionnaire(patientId,this.taskId,this.questionnaireId,answersList);
      if(saveResult.isAxiosError)
      {
        this.loading = false;
        alert("Ha ocurrido un error salvando el estado del paciente");
      }else{
        this.loading = false;
        alert("Estado del paciente salvado correctamente");
      }
    },


  },
};
</script>
