<template>
    
    <div class="content">
       <div v-if="total == 0">
             <h2>{{ $t('taskprogress_label_notasks')}}</h2> 
       </div> 
    <div v-else class="info">
        <h2>{{ $t('taskprogress_label_todaytasks')}}</h2> 

        <span>{{ $t('taskprogress_label_today_progress',{completed:completed,total,total}) }}</span>
        <a  v-if="showLinkToAgenda.value"  href="/agenda" class="btn btn-secondary small">{{ $t('widgettask_header_link') }}</a>
      </div>
        <div class="completed">
          <div class="flex-wrapper">
            <div class="single-chart">
              <svg viewBox="0 0 36 36" class="circular-chart green">
                <path class="circle-bg" d="M18 2.0845
                      a 15.9155 15.9155 0 0 1 0 31.831
                      a 15.9155 15.9155 0 0 1 0 -31.831" />
                <path class="circle"   :stroke-dasharray="`${percentage}, 100`" d="M18 2.0845
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
  import {  computed,ref } from 'vue';
  
  export default {
    name: 'TaskProgress',
    props: ['completed','total','enableLinkToAgenda','showProgressOnP','showProgressOnSpan'],
    setup(props) {

      const showLinkToAgenda = ref(props.enableLinkToAgenda);
      const percentage = computed(() => {
        if( props.total > 0)
        {
          return Math.round((props.completed / props.total) * 100);

        }else{
          return 0;
        }
      });


      return {
        percentage,showLinkToAgenda
      };
    }
  }
  </script>