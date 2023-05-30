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
    let currentDate = new Date();
    const selectedDayIndex = ref((currentDate.getDay())-1);
    let monday = new Date(currentDate);  
    monday.setDate(monday.getDate() - currentDate.getDay() + 1)

    const weekDays = []
    for (let i = 0; i < 7; i++) {
      const day = new Date(monday)
      day.setDate(day.getDate() + i)
      weekDays.push({day: day.getDate(), dateUtc: day.toISOString()})
    }

    
    const changeSelectedDate = (index) => {
      selectedDayIndex.value = index
    }
  
    const triggerChangeDate = () => {
      const selectedDate = (weekDays[selectedDayIndex.value]);
      emit('evtAgendaChangeDate',selectedDate.dateUtc)
    };

    //Initially it triggers the current date to notify to the parent component to load the tasks.
    triggerChangeDate();
   
  return {weekDays,selectedDayIndex,changeSelectedDate};
  
}})

</script>