<template>
  <footer>
    <div class="modal-box" id="cp_modal">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <div class="title-task">
              <h4>Modal title</h4>
            </div>
            <button type="button" class="btn btn-link" @click="closeModal">
              <i class="icon-close"></i>
            </button>
          </div>
          <div class="modal-body">Modal content</div>
          <div class="modal-footer footer-task-modal">
            <button type="button" class="btn btn-secondary close" @click="closeModal">Close</button>
            <button type="button" class="btn btn-primary">Accept</button>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-box" id="cp_modal_alert"></div>
  </footer>
</template>

<script>
import { onMounted } from 'vue';

export default {
  name: 'FooterComponent',
  setup() {
    const closeModal = () => {
      // Cerrar el modal aquí (implementa la lógica necesaria)
    };

    onMounted(() => {
      // Reemplazar el textarea con CKEditor
      //CKEDITOR.replace('longDesc');
    });

    return {
      closeModal
    };
  }
};
</script>
