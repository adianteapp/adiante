<template>
    <div class="card ">
      <div class="container-card">
        <div class="img">
          <img v-if="getMainImage()" :src="getMainImage()" alt="">
          <img v-else src="../../assets/img/demo/reto1.jpg" alt="">
        </div>

        <div class="content">
          
          <div class="info"> 
            <span class="title">{{task.title}}</span>   
          </div>

          <div v-if="task.description" class="desc">
            {{task.description}}
          </div>

          <div class="label small completed"> <span></span>Hecho x veces</div>
          
          
        </div>

        
      </div>
      </div>
</template> 
   
 <script>
import { ref } from 'vue';
export default {
  name: 'Card',
  props: ['taskData'],
  setup(props){
    const task = ref(props.taskData).value;


    const getMainImage = () => {
      let imagePath = undefined;
  
      if( task != null && task.taskAttributeList != null && task.taskAttributeList.length > 0){
          
        const imageUri = task.taskAttributeList.find(attribute => attribute.attributeCode === "ImageUri");
        imagePath = imageUri != null ? imageUri.attributeValue : undefined;
      }
      return imagePath;
    };




     return{task,getMainImage}
  }

}
   </script>
    