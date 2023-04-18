<template>
    <p class="header">Texto de la pregunta </p>

    <div class="form-check">
        <input class="form-check-input" type="radio" name="radioname" id="radioname">
        <label class="form-check-label" for="radioname">
            Answer text
        </label>
    </div>

    <div class="form-check">
        <input class="form-check-input" type="radio" name="radioname" id="radioname">
        <label class="form-check-label" for="radioname">
            Answer text
        </label>
    </div>

    <div class="form-check">
        <input class="form-check-input" type="radio" name="radioname" id="radioname">
        <label class="form-check-label" for="radioname">
            Answer text
        </label>
    </div>
</template> 
   
<script>

export default {
    name: 'QuestionRadio',
    props: {
        msg: String
    }
}
</script>