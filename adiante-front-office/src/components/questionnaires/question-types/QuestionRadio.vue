<template>
    <div>
      <p class="header">{{ currentQuestion.i18n }}</p>
  
      <div class="form-check" v-for="(answer, index) in currentQuestion.answers" :key="index">
        <input class="form-check-input" type="radio"  @change="updateSelectedAnswers" :checked="isAnswerSelected(answer.id)" :id="answer.id">
        <label class="form-check-label" :for="'answer-' + index">
          {{ answer.i18n }}
        </label>
      </div>
    </div>
  </template> 
  
  <script>
  import { ref } from 'vue';
  import { toRaw } from 'vue';
  export default {
    name: 'SelectOneQuestion',
    props: ['question','selectedAnswers'],
    setup(props ) {
      
      const currentQuestion = ref(props.question);
      const selectedAnswers = ref(props.selectedAnswers).value;

      const currentAnswers= ref();
      if(selectedAnswers && (selectedAnswers.length > 0)){

        currentAnswers.value= selectedAnswers.filter(answers => answers.idQuestion == currentQuestion.value.id);
      }


      const updateSelectedAnswers = (event) => {
        currentAnswers.value = [ {idQuestion:currentQuestion.value.id,idAnswer:event.target.id}];
    };


    const getAnswers = () => {
        return toRaw(currentAnswers.value);
      };
      
   const isAnswerSelected = (answerId) => {
      if(currentAnswers.value && (currentAnswers.value.length > 0)){
        return currentAnswers.value.some((answer) => answer.idAnswer == answerId);
      }
    };



      return { updateSelectedAnswers, getAnswers, isAnswerSelected ,currentQuestion};
    }
  }
  </script>
  