<template>
  <iframe :src="videoUrl" width="540" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
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