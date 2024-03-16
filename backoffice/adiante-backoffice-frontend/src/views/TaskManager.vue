<template>
      <headerComponent/>
      <sideMenu/>
    <div class="container">
      <ul class="breadcrumb">
        <li class="breadcrumb-item home"><router-link to="/dashboard">Home</router-link></li>
        <li class="breadcrumb-item last">Page</li>
      </ul>
  
      <div class="head">
        <div class="title">
          <h1>Tareas Semanales</h1>
        </div>
  
        <div class="controls">
          <button class="btn btn-primary big" @click="createNewTask"> <i class="icon-plus"></i> Nueva tarea</button>
        </div>
      </div>
  
      <div class="filters">
        <div class="input select">
          <select v-model="selectedYear" @change="loadMonthSelectHtml">
            <option v-for="year in years" :key="year">{{ year }}</option>
          </select>
        </div>
        <div class="input select">
          <select v-model="selectedMonth" @change="loadWeekSelectHtml, loadWeekdaysHtml">
            <option v-for="(month, index) in months" :key="index">{{ month }}</option>
          </select>
        </div>
        <div class="input select">
          <select v-model="selectedWeek" @change="cleanWebHtml, loadWeekdaysHtml">
            <option v-for="(week, index) in weeks" :key="index">{{ week }}</option>
          </select>
        </div>
      </div>
  
      <div class="row col-2">
        <div class="col">
          <div class="title">
            <div class="week" id="daysWeek">
              {{ selectedWeekdays }}
            </div>
          </div>
          <div class="content">
            <div class="list-task" id="list-task">
              <!-- Renderizar tareas aquí -->
            </div>
          </div>
        </div>
        <div class="col">
          <div class="card secondary" id="dts-trs" v-show="dtsTrsVisible">
            <!-- Renderizar detalles de tarea aquí -->
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script>
  import { ref, onMounted } from 'vue';
  import HeaderComponent from '../components/common/HeaderComponent.vue';
  import SideMenu from '../components/common/SideMenu.vue';
  export default {
    components: {
      headerComponent: HeaderComponent,
      sideMenu: SideMenu
    },
    setup() {
      const selectedYear = ref('');
      const selectedMonth = ref('');
      const selectedWeek = ref('');
      const years = ref([]);
      const months = ref([]);
      const weeks = ref([]);
      const selectedWeekdays = ref('');
      const dtsTrsVisible = ref(false);
  
      const loadYears = () => {
        // Lógica para cargar los años disponibles
      };
  
      const loadMonthSelectHtml = () => {
        // Lógica para cargar los meses disponibles
      };
  
      const loadWeekSelectHtml = () => {
        // Lógica para cargar las semanas disponibles
      };
  
      const loadWeekdaysHtml = () => {
        // Lógica para cargar los días de la semana
      };
  
      const cleanWebHtml = () => {
        // Lógica para limpiar el HTML de la página web
      };
  
      const createNewTask = () => {
        // Lógica para crear una nueva tarea
      };
  
      onMounted(() => {
        loadYears();
      });
  
      return {
        selectedYear,
        selectedMonth,
        selectedWeek,
        years,
        months,
        weeks,
        selectedWeekdays,
        dtsTrsVisible,
        loadYears,
        loadMonthSelectHtml,
        loadWeekSelectHtml,
        loadWeekdaysHtml,
        cleanWebHtml,
        createNewTask
      };
    }
  };
  </script>