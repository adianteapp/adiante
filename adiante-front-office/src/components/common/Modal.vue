<template> 
  <div class="modal fade" id="type-1" tabindex="-1" aria-labelledby="modalid" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <div class="title-task">
            <h4>{{title}}</h4>
          </div>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          {{content}}
        </div>
        <div class="modal-footer footer-task-modal">
          <p class="title">Modal footer</p>
          <div class="buttons">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Button</button>
            <button type="button" class="btn btn-primary"  data-bs-toggle="modal" data-bs-target="#taskend" >Button</button>
          </div>
        </div>
      </div>
    </div>
  </div>

</template> 
   
<script>
export default {
  name: 'Modal',
  setup(props) {
    return {
      title: props.title,
      content: props.content
    }
  }
}
</script>    