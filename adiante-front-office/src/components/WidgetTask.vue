<template>
  <section class="widget widget-task">
    
    <div class="content">
      <div class="info">
        <h2>{{ $t('widgettask_header_title') }}</h2>
        <span>1 {{ $t('widgettask_header_desc1') }} 4 {{ $t('widgettask_header_desc2') }}</span>
        <a href="/agenda" class="btn btn-secondary small">{{ $t('widgettask_header_link') }}</a>
      </div>
      <div class="completed">
        <div class="flex-wrapper">
          <div class="single-chart">
            <svg viewBox="0 0 36 36" class="circular-chart green">
              <path class="circle-bg" d="M18 2.0845
                    a 15.9155 15.9155 0 0 1 0 31.831
                    a 15.9155 15.9155 0 0 1 0 -31.831" />
              <path class="circle" stroke-dasharray="60, 100" d="M18 2.0845
                    a 15.9155 15.9155 0 0 1 0 31.831
                    a 15.9155 15.9155 0 0 1 0 -31.831" />
              <text x="18" y="20.35" class="percentage">60%</text>
            </svg>
          </div>
        </div>
      </div>
    </div>
  
  </section>
</template> 
   
<script>
export default {
  name: 'WidgetTask',
  props: {
    msg: String
  }
}
</script>
    