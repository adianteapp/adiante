<template>
  <div class="task">
    <div class="header">
      <h4 class="task-title">{{ currentScheduledTask.title }}</h4>
      <div v-if="status.completed" class="label small completed">
        <span>{{ $t('agenda.scheduled_task.status_completed') }}</span>
      </div>
      <div v-if="status.delayed" class="label small delayed">
        <span> {{ $t('agenda.scheduled_task.status_delayed') }}</span>
      </div>
      <div v-if="status.pending" class="label small incomplete">
        <span> {{ $t('agenda.scheduled_task.status_pending') }}</span>
      </div>

    </div>
    <div class="content">
      <div class="task-info date"><i class="icon-date"></i> {{ taskDate }}</div>
      <div class="task-info time"><i class="icon-time"></i> {{ taskStartTime }} - {{ taskEndTime }}</div>
    </div>

    <div v-if="showFullInformation">
      <div class="details">
        <p>{{ currentScheduledTask.description }}</p>
      </div>

      <div v-if="status.delayed" class="alert error" role="alert">
        <div class="icon">
          <i></i>
        </div>
        <div class="alert-text">
          {{ $t('agenda.scheduled_task.status_delayed_msg', { delayedTime: getDelayedTime }) }}
        </div> 
 
      </div>

      <div v-if="status.pending" class="alert info" role="alert">
        <div class="icon">
          <i></i>
        </div>
        <div class="alert-text">
          {{ $t('agenda.scheduled_task.status_pending_msg') }}
        </div> 
      </div>


      <div v-if="status.completed" class="alert success" role="alert">
        <div class="icon">
          <i></i>
        </div>
        <div class="alert-text">
          {{ $t('agenda.scheduled_task.status_completed_msg', { completedDate: getComplitedTime }) }}
        </div>  
      </div>
    </div>

  </div>
</template> 
   
<script>
import { computed, ref } from 'vue';
export default {
  name: 'ScheduledTask',
  props: ['scheduledTaskData', 'showFullInfo'],
  setup(props) {
    const providedTask = ref(props.scheduledTaskData).value;
    const showFullInformation = ref(props.showFullInfo);
    const currentDate = new Date();

    if (providedTask == null) {
      return;
    }
    const currentScheduledTask = providedTask.task != null ? providedTask.task : providedTask;


    const taskDate = ref(undefined);
    const taskStartTime = ref(undefined);
    const taskEndTime = ref(undefined);
    const status = ref({
      completed: (currentScheduledTask.executionDateTimeLocal) ? true : false,
      delayed: (!currentScheduledTask.executionDateTimeLocal && currentDate > new Date(currentScheduledTask.endDateTimeLocal)) ? true : false,
      pending: (!currentScheduledTask.executionDateTimeLocal && currentDate < new Date(currentScheduledTask.endDateTimeLocal)) ? true : false
    });


    function calculateTaskDates() {
      let dateStart = new Date(currentScheduledTask.startDateTimeLocal);
      let dateEnd = new Date(currentScheduledTask.endDateTimeLocal);

      const optionsDate = { day: '2-digit', month: '2-digit', year: 'numeric' };
      const formatter = new Intl.DateTimeFormat('es-ES', optionsDate);
      taskDate.value = formatter.format(dateStart);

      const optionsTime = { hour: '2-digit', minute: '2-digit', hour12: false };
      const formatterTime = new Intl.DateTimeFormat('es-ES', optionsTime);
      taskStartTime.value = formatterTime.format(dateStart);
      taskEndTime.value = formatterTime.format(dateEnd);
    }


    const getDelayedTime = computed(() => {
      // Get the current date
      const currentDate = new Date();
      // Calculate the difference in milliseconds between the two dates
      const difference = currentDate - new Date(currentScheduledTask.endDateTimeLocal);
      let delayedTime = '';
      // Use Intl.RelativeTimeFormat to format the difference in hours, minutes, or days

      let days = undefined;
      let hours = undefined;
      let minutes = undefined;

      switch (true) {
        case difference >= 86400000:
          // If more than 24 hours have passed, show the time in days
          days = Math.floor(difference / 86400000);
          delayedTime = days + (days > 1 ? ' días' : ' día');
          break;

        case difference >= 3600000:
          // If at least 1 hour has passed, show the time in hours and minutes
          hours = Math.floor(difference / 3600000);
          minutes = Math.floor((difference % 3600000) / 60000);
          delayedTime = hours + ' horas ' + (minutes != "" ? "y " + minutes + ' minutos' : '');
          break;

        case difference >= 60000:
          // If at least 1 minute has passed, show the time in minutes
          minutes = Math.floor(difference / 60000);
          delayedTime = minutes + (minutes > 1 ? ' minutos' : ' minuto');
          break;
      }

      return delayedTime; // Return the computed value
    });


    const getComplitedTime = computed(() => {
      const optionsDate = { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit', hour12: false };
      const formatter = new Intl.DateTimeFormat('es-ES', optionsDate);

      return formatter.format(new Date(currentScheduledTask.executionDateTimeLocal));
    });

    calculateTaskDates();
    return { currentScheduledTask, showFullInformation, status, taskDate, taskStartTime, taskEndTime, getDelayedTime, getComplitedTime }
  }

}
</script>
    