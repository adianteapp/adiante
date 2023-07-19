<template>
  <div class="content">

   
      <div  v-if="total == 0" class="alert default">

        <div class="icon">
          <i class="icon-star"></i>
        </div>

        <div class="alert-text">
          {{ notTasksLabel }}
        </div>
        
       </div>
     

    <div v-else class="info-task">
      <h2>{{ selectedDayLabel }}</h2> 
      <span class="number">{{ $t('taskprogress_label_today_progress', { completed: completed, total: total }) }}</span>
      <a v-if="showLinkToAgenda" href="/agenda" class="btn btn-secondary small">{{ $t('widgettask_header_link') }}</a>
    </div>

    <div v-if="total > 0" class="completed percent">
      <div class="flex-wrapper">
        <div class="single-chart">
          <svg viewBox="0 0 36 36" class="circular-chart green">
            <path class="circle-bg" d="M18 2.0845
                      a 15.9155 15.9155 0 0 1 0 31.831
                      a 15.9155 15.9155 0 0 1 0 -31.831" />
            <path class="circle" :stroke-dasharray="`${percentage}, 100`" d="M18 2.0845
                      a 15.9155 15.9155 0 0 1 0 31.831
                      a 15.9155 15.9155 0 0 1 0 -31.831" />
            <text x="18" y="20.35" class="percentage">{{ percentage }}%</text>
          </svg>
        </div>
      </div>
    </div>




  </div>
</template>
  
<script>
import { useI18n } from "vue-i18n";
import { computed, ref, watchEffect } from 'vue';
import taskService from '../../services/task.service';

export default {
  name: 'TaskProgress',
  props: ['selectedDate', 'tasks', 'enableLinkToAgenda'],
  setup(props) {

    const { t } = useI18n();

    const showLinkToAgenda = ref(props.enableLinkToAgenda);
    let tasks = ref(props.tasks).value;
    let selectedDate = ref(props.selectedDate).value;
    const today = new Date().toISOString().slice(0, 10);

    const total = ref(undefined);
    const completed = ref(undefined);

    const selectedDayLabel = ref(undefined);
    const notTasksLabel = ref(undefined);
    let dayLabel = "";

    const percentage = computed(() => {
      if (total.value > 0) {
        return Math.round((completed.value / total.value) * 100);

      } else {
        return 0;
      }
    });

    const getStatsFromTaskList = (tasks) => {
      if (tasks && tasks.length > 0) {
        return { total: tasks.length, completed: tasks.filter(task => task.executionDateTimeLocal != null).length }
      } else {
        return { total: 0, completed: 0 };

      }
    };

    const getDayLabel = (day) => {
      const dayNumber = (day + 6) % 7;
      return t('task_week_day' + dayNumber);
    };


    const initComponent = async () => {


      let stats = undefined;
      if (tasks == undefined) {

        const response = await taskService.getScheduledTasks(today);

        if (response.isAxiosError) {
          console.log("Error retrieving patient stats");
          return null;
        } else {
          stats = getStatsFromTaskList(response.tasksList);
          dayLabel = t('taskprogress_label_today');
        }
      } else {
        //data provided by params
        if (selectedDate != undefined && selectedDate.value != today) {
          dayLabel = getDayLabel(new Date(selectedDate.value).getDay());
        } else {
          dayLabel = t('taskprogress_label_today');
        }
        stats = getStatsFromTaskList(tasks);

      }
      total.value = stats.total;
      completed.value = stats.completed;
      if (total.value > 0) {
        selectedDayLabel.value = t('taskprogress_label_day', { day: dayLabel });
      } else {
        notTasksLabel.value = t('taskprogress_label_notasks', { day: dayLabel });
      }

    };

    //This function is to handle the changes on the props
    watchEffect(() => {
      tasks = ref(props.tasks) ? ref(props.tasks).value : undefined;
      selectedDate = ref(props.selectedDate) ? ref(props.selectedDate).value : undefined;

      if (tasks && tasks.length > 0) {


        const stats = getStatsFromTaskList(tasks);
        total.value = stats.total;
        completed.value = stats.completed;

        if (selectedDate != undefined && selectedDate != today) {
          dayLabel = getDayLabel(new Date(selectedDate).getDay());
        } else {
          dayLabel = t('taskprogress_label_today');
        }
        selectedDayLabel.value = t('taskprogress_label_day', { day: dayLabel });
      } else {
        if (selectedDate != undefined) {
          total.value = 0;
          dayLabel = selectedDate != today ? getDayLabel(new Date(selectedDate).getDay()) : t('taskprogress_label_today');
          notTasksLabel.value = t('taskprogress_label_notasks', { day: dayLabel });
        }

      }

    })


    initComponent();
    return {
      percentage, showLinkToAgenda, total, completed, selectedDayLabel, notTasksLabel
    };
  }
}
</script>