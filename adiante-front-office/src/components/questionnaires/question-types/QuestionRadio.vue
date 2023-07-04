<template>
    <div>
      <p class="header">{{ currentQuestion.questionValue }}</p>
  
      <div class="form-check" v-for="(answer, index) in currentQuestion.answers" :key="index">
        <input class="form-check-input" type="radio"  @change="updateSelectedAnswers" :checked="isAnswerSelected(answer.answerId)" :id="answer.answerId">
       <!-- <label class="form-check-label" :for="'answer-' + index"> -->
        <label class="form-check-label" :for="answer.answerId"> 
          {{ answer.answerValue }}
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

        currentAnswers.value= selectedAnswers.filter(answers => answers.idQuestion == currentQuestion.value.questionId);
      }


      const updateSelectedAnswers = (event) => {
        currentAnswers.value = [ {idQuestion:currentQuestion.value.questionId,idAnswer:event.target.id}];
    };

    const updateCurrentQuestion = (updatedQuestion) => {
        currentQuestion.value= updatedQuestion
      }; 
      


    const getAnswers = () => {
        return toRaw(currentAnswers.value);
      };
      
   const isAnswerSelected = (answerId) => {
      if(currentAnswers.value && (currentAnswers.value.length > 0)){
        return currentAnswers.value.some((answer) => answer.idAnswer == answerId);
      }
    };



      return {updateCurrentQuestion, updateSelectedAnswers, getAnswers, isAnswerSelected ,currentQuestion};
    }
  }
  </script>
  