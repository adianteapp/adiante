<template>

<Modal 
    :title="title" 
    :content="content"
    :showButtonClose="showButtonClose"
    />


</template>
<script>
   import Modal from '../common/Modal.vue';
   import { ref } from 'vue';
   import { useI18n } from 'vue-i18n';
   import getRandomFeedbackContent from '../../services/util/feedback-random-generator';
   export default {
     name: 'FeedbackModal',
     components:{
      Modal : Modal
     },
     props:['taskType','isGetMoodFeedback'],
     setup(props){

        const { t } = useI18n();

        const taskType = ref(props.taskType).value;
        const isGetMoodFeedback = ref(props.isGetMoodFeedback).value;
        let title = '';
        let content = '';

         switch(isGetMoodFeedback){
          case true:
               title =  t('feedback_modal.getmood.title');
               content =  t(getRandomFeedbackContent(2,'feedback_modal.getmood.content_'));
               break;
         default:
              title =  t('feedback_modal.'+taskType+'.title');
              content =  t('feedback_modal.'+taskType+'.content');
              break;
         }

 
        const showButtonClose = true;
        return{title,content,showButtonClose}
     }

   }
</script>