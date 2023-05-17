<template>
    <p class="header">{{currentQuestion.i18n}}</p>

    <div class="input-group">
        <textarea ref="answerInput" v-model="currentAnswer" class="form-control" placeholder="Placeholder text" aria-label="Placeholder text"></textarea>
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
              currentAnswers= props.selectedAnswers.find(answers => answers.idQuestion == currentQuestion.value.id);
         }

        let currentAnswer =  currentAnswers && currentAnswers.freeAnswerValue ? ref(currentAnswers.freeAnswerValue)  : ref('');

        const getAnswers = () => {
            return toRaw([{idQuestion:currentQuestion.value.id,freeAnswerValue:currentAnswer.value}]);
        };

        return { currentAnswer,currentQuestion, getAnswers};
    }
}
</script>
