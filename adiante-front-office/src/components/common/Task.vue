<template>
  <div class="task" data-bs-toggle="modal" data-bs-target="#type-2">
    <div class="header">
      <h4>Título de la tarea</h4>
      <div class="state delayed"><span> No completada</span></div>
    </div>
    <div class="content">
      <div class="task-info date"><i class="icon-date"></i> 00/00/0000 </div>
      <div class="task-info time"><i class="icon-time"></i> 11:00 </div>
    </div>
    <div class="details">
      <p>Esta es la descripción larga de la tarea en donde se explica al usuario de manera detallada en qué
        consiste la tarea que debe realizar.</p>
    </div>
    <div class="alert error" role="alert">
      <p>Esta tarea tiene un retraso de 2h.</p>
    </div>
  </div>
</template> 
   
<script>
export default {
  name: 'Task',
  props: {
    msg: String
  }
}
</script>
    