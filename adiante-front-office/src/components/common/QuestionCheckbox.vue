<template>
    <p class="header">Texto de la pregunta </p>

    <div class="form-check">
        <input class="form-check-input" type="checkbox" value="" id="checkboxname" name="checkboxname">
        <label class="form-check-label" for="checkboxname">
            Answer text
        </label>
    </div>

    <div class="form-check">
        <input class="form-check-input" type="checkbox" value="" id="checkboxname" name="checkboxname">
        <label class="form-check-label" for="checkboxname">
            Answer text
        </label>
    </div>

    <div class="form-check">
        <input class="form-check-input" type="checkbox" value="" id="checkboxname" name="checkboxname">
        <label class="form-check-label" for="checkboxname">
            Answer text
        </label>
    </div>
</template> 
   
<script>

export default {
    name: 'QuestionCheckbox',
    props: {
        msg: String
    }
}
</script>