<template>
    <p class="header">Texto de la pregunta </p>

    <div class="input-group">
        <textarea class="form-control" placeholder="Placeholder text" aria-label="Placeholder text"></textarea>
    </div>

</template> 
   
<script>

export default {
    name: 'QuestionTextarea',
    props: {
        msg: String
    }
}
</script>
