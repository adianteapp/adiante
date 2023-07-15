<template>
    <div class="card">

        <div class="img">
          <img :src="getMainImage" alt="">
        </div>

        <div class="content">
          <div class="info"> 
            <span class="title">{{task.title}}</span>  
            <span></span>
        </div>
          <div class="desc">
            {{task.description}}
          </div>

        </div>

        <div class="icon">
          <i class="icon-navigate_next"></i>
        </div>
      </div>
</template> 
   
 <script>
import { ref,computed } from 'vue';
export default {
  name: 'Card',
  props: ['taskData'],
  setup(props){
    const task = ref(props.taskData).value;


    const getMainImage = computed (() => {
      let imagePath = undefined;
      //const defaultPath = "../../../public/img/demo/reto.jpg"
      const defaultPath = "../../assets/img/demo/reto1.jpg";
      if( task != null && task.taskAttributeList != null && task.taskAttributeList.length > 0){
          
          const imageUri = task.taskAttributeList.find(attribute => attribute.attributeCode === "ImageUri")?.attributeValue;
          imagePath = imageUri != null ? imageUri : defaultPath;
      }else{
         imagePath = defaultPath;
      }
      return imagePath;
    });




     return{task,getMainImage}
  }

}
   </script>
    