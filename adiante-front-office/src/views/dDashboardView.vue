<script>
import HeaderMenu from '../components/common/HeaderMenu.vue'
import FooterMenu from '../components/common/FooterMenu.vue'
import WidgetHello from '../components/WidgetHello.vue'
import WidgetState from '../components/WidgetState.vue'
import WidgetTask from '../components/WidgetTask.vue'
import WidgetWeek from '../components/WidgetWeek.vue'
import Card from '../components/common/Card.vue'
import Task from '../components/common/Task.vue'

import QuestionCheckbox from '../components/common/QuestionCheckbox.vue'
import QuestionRadio from '../components/common/QuestionRadio.vue'
import QuestionTextarea from '../components/common/QuestionTextarea.vue'
import IntroView from '../components/IntroView.vue'


export default {
  components: {
    HeaderMenu: HeaderMenu,
    FooterMenu: FooterMenu,
    WidgetHello: WidgetHello,
    WidgetState: WidgetState,
    WidgetTask: WidgetTask,
    WidgetWeek: WidgetWeek,
    Card: Card,
    Task: Task,
    QuestionRadio: QuestionRadio,
    QuestionTextarea: QuestionTextarea,
    QuestionCheckbox: QuestionCheckbox,
    IntroView: IntroView
  }
}
</script>

<template>
  <HeaderMenu />
  <div class="app">

    <WidgetHello />
    <WidgetState />
    <WidgetTask />
    
    <Card />

    <WidgetWeek />

    <Task />

    <a href="" data-bs-toggle="modal" data-bs-target="#modalid"> abre modal</a>

    <Modal />

    <QuestionRadio />

    <QuestionTextarea />

    <QuestionCheckbox />

    <IntroView />

  </div>
 
  <FooterMenu />

</template>
   