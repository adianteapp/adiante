<template> 
  <div class="modal-box">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <div class="title-task">
            <h4>{{taskTitle}}</h4>
          </div>
          <button type="button" @click="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <!-- Task info-->
          <div v-if="componentsManager.taskDescriptionEnabled" class="description-task">
            <p>{{taskDescription}}</p>
          </div>
          <component v-if="showTaskComponents" :is="taskComponent" :data="taskData"></component>
          <!-- Questionnaries content -->
          <component v-if="showQuestionsComponents" :is="currentQuestionComponent" :data="currentQuestion"></component>
          <stepperQuestions/>
        </div>
        <div class="modal-footer footer-task-modal">
          <div class="buttons">
            <button v-if="false"  @click="taskContent"  type="button" class="btn btn-secondary" data-bs-dismiss="modal">{{$t('modal_close_button_label')}}</button>          
          </div>
        </div>
      </div>
    </div>
  </div>

</template> 
   
<script >
import StepperQuestions from '../questionnaires/questionnaire-types/get-mood/StepperQuestions.vue';
export default {
  name: 'Modal',
  components:{
    stepperQuestions: StepperQuestions
  },
  props: ['title','task','showButtonClose'],
  setup() {



 

     




    return {}
  }
}
</script>    