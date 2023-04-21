<template>
  <div class="week"> 
      <div class="day">{{ $t('task_week_day1') }} <br /> 8</div>
      <div class="day">{{ $t('task_week_day2') }} <br /> 9</div>
      <div class="day">{{ $t('task_week_day3') }} <br /> 10</div>
      <div class="day">{{ $t('task_week_day4') }} <br /> 11</div>
      <div class="day">{{ $t('task_week_day5') }} <br /> 12</div>
      <div class="day active">{{ $t('task_week_day6') }} <br /> 13</div>
      <div class="day">{{ $t('task_week_day7') }} <br /> 14</div>
    
  </div>
   </template> 
   
         <script>
   export default {
     name: 'WidgetWeek',
     props: {
       msg: String
     }
   }
   </script>
    

    