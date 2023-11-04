<template><div style="padding:160% 0 0 0;position:relative;">
  <iframe :src="videoUrl" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" style="position:absolute;top:0;left:0;width:100%;height:100%;"></iframe>
</div>
</template>
<script>
import {ref} from 'vue'
export default {
  name: "EmbeddedVimeoVideo",
  props: ['videoSource'],
  setup(props){
    const videoUrl = ref(props.videoSource).value;
    return {videoUrl};
  }
};
</script>