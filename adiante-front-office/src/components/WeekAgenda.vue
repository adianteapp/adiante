<template>
  <div class="week">
    <div class="row">
      <div id="{{index}}"
        v-for="(item, index) in weekDays"
        :key="index"
        :class="['col', { active: index == selectedDayIndex }]"
        @click="changeSelectedDate(index)">
        {{ $t('task_week_day'+index) }} <br /> {{ item.day }}
      </div>
    </div>
  </div>
</template>

<script>
import {ref} from 'vue'
export default({
  name:'WeekAgenda',
  setup(props,{emit}){
    


    
    const today = new Date();
    const dayOfWeek = today.getDay();
    const diff = (dayOfWeek + 6) % 7;
    const selectedDayIndex = ref(diff);
    const mondayDate = new Date(today.setDate(today.getDate() - diff));

    const weekDays = []
    for (let i = 0; i < 7; i++) {
      const day = new Date(mondayDate)
      day.setDate(day.getDate() + i)
      weekDays.push({day: day.getDate(), date: day.toISOString().slice(0, 10) })
    }

    
    const changeSelectedDate = (index) => {
      selectedDayIndex.value = index;
      triggerChangeDate();
    }
  
    const triggerChangeDate = () => {
      const selectedDate = (weekDays[selectedDayIndex.value]);
      emit('evtAgendaChangeDate',selectedDate.date);
    };

   triggerChangeDate();
  return {weekDays,selectedDayIndex,changeSelectedDate};
  
}})

</script>