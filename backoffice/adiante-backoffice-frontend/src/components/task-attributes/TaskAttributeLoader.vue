<template> 
       <embeddedVimeoVideo v-if="videoVimeoUrl" :videoSource="videoVimeoUrl"/>
  </template> 
<script>
import { ref } from 'vue'
import EmbeddedVimeoVideo from '../embedded-video/EmbeddedVimeoVideo.vue'
import TaskAttributesEnum from '../../constants/task-attributes-enum'
export default {
    name: "TaskAttributeLoaderModal",
    props: ['attributeList'],
    components: {
        embeddedVimeoVideo: EmbeddedVimeoVideo
    },
    setup(props){
       
        const attributeList = ref(props.attributeList).value;

        const videoVimeoUrl = ref(null);

       function parseAttributeList(attributeList){

            if(attributeList){
                attributeList.forEach(element => {

                  switch(element.attributeCode){
                      case TaskAttributesEnum.VimeoVideo:
                      videoVimeoUrl.value = element.attributeValue;
                          break;
                  }

                });
            }
            return videoVimeoUrl;
        }


        


        parseAttributeList(attributeList);

        return {videoVimeoUrl  };



    }

}
</script>