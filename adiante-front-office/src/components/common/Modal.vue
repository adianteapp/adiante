<template> 
  <div class="modal-box">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <div class="title-task">
            <h4>{{title}}</h4>
          </div>
          <button type="button" @click="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          {{content}}
        </div>
        <div class="modal-footer footer-task-modal">
          <div class="buttons">
            <button v-if="buttonCloseEnabled"  @click="closeModal"  type="button" class="btn btn-secondary" data-bs-dismiss="modal">{{$t('modal_close_button_label')}}</button>          
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
export default {
  name: 'Modal',
  props: ['title','content','showButtonClose'],
  setup(props, { emit }) {

    const buttonCloseEnabled = ref(props.showButtonClose);
    const closeModal = () => {
      emit("evtCloseTaskModal");
    };
    return {buttonCloseEnabled,closeModal}
  }
}
</script>