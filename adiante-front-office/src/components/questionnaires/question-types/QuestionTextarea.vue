<template>
    <p class="header">{{currentQuestion.questionValue}}</p>

    <div class="input-group">
        <textarea ref="answerInput" v-model="currentAnswer" class="form-control" placeholder="Escribe aquí tu respuesta" aria-label="Escribe aquí tu respuesta"></textarea>
    </div>

</template> 
   
<script>
import { ref , toRaw} from "vue";
export default {
    name: 'FreeAnswerQuestion',
    props: ['question','selectedAnswers'],
    setup(props){
        let currentQuestion = ref(props.question);
 
        //retriving the previous patient feedback
        let currentAnswers = undefined;
        if(props.selectedAnswers != undefined)
         {
              currentAnswers= props.selectedAnswers.find(answers => answers.idQuestion == currentQuestion.value.questionId);
         }

        let currentAnswer =  currentAnswers && currentAnswers.freeAnswerValue ? ref(currentAnswers.freeAnswerValue)  : ref('');

        const getAnswers = () => {
            return toRaw([{idQuestion:currentQuestion.value.questionId,freeAnswerValue:currentAnswer.value}]);
        };

        const updateCurrentQuestion = (updatedQuestion) => {
        currentQuestion.value= updatedQuestion
      };

      const validateAnswers = () => {
        // Initially there is no validation on free answer questions.
          return true;
      };

        return { currentAnswer,currentQuestion,
                 updateCurrentQuestion, getAnswers,validateAnswers};
    }
}
</script>
