<template>

<Modal :title="getmoodFeedbackModalTitle" :content="getmoodFeedbackModalContent"/>

</template>
<script>
   import Modal from '../common/Modal.vue';
   import { useI18n } from 'vue-i18n';
   import getRandomFeedbackContent from '../../services/util/feedback-random-generator';
   export default {
     name: 'FeedbackModal',
     components:{
      Modal : Modal
     },
     setup(){
        const { t } = useI18n();
        const getmoodFeedbackModalTitle =  t('getmood_feedback_modal_title');

        const getmoodFeedbackModalContent = getRandomFeedbackContent(2,'getmood_feedback_modal_content_')
        return{getmoodFeedbackModalTitle,getmoodFeedbackModalContent}
     }

   }
</script>