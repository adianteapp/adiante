<template>
    <div>
      <headerComponent/>
      <sideMenu/>
  
      <main>
        <div class="container">
          <ul class="breadcrumb">
            <li class="breadcrumb-item home"><a href="#">Home</a></li>
            <li class="breadcrumb-item"><router-link :to="{ path: '/patient-list', query: { name: name_patient } }" id="name_patient"></router-link></li>
            <li class="breadcrumb-item last">Registros de actividad</li>
          </ul>
  
          <div class="head">
            <div class="title">
              <h1>Registros de estado</h1>
            </div>
            <a class="controls">
              <button class="btn btn-primary big" @click="exportToXlsx"> <i class="icon-plus"></i> Exportar</button>
            </a>
          </div>
  
          <div class="row col-1 ">
            <div class="col d-flex">
              <div class="dropdown">
                <ul>
                  <li><a href="#" class="btn btn-secondary">Estado<div id="down-triangle"></div></a>
                    <ul id="filter-estado">
                      <!-- Opciones de filtro de estado -->
                    </ul>
                  </li>
                </ul>
              </div>
  
              <div class="dropdown">
                <ul>
                  <li><a href="#" class="btn btn-secondary">Fecha<div id="down-triangle"></div></a>
                    <ul>
                      <li>
                        <div class="input text small">
                          <label for="date1"> Desde</label>
                          <input v-model="date_inicial" type="date" class="form-control" required="" aria-describedby=" ">
                        </div>
                      </li>
                      <li>
                        <div class="input text small">
                          <label for="date2"> Hasta</label>
                          <input v-model="date_fin" type="date" class="form-control" required="" aria-describedby=" ">
                        </div>
                      </li>
                      <li> <button class="btn btn-secondary small" @click="applyFilters">  Aplicar  </button> </li>
                    </ul>
                  </li>
                </ul>
              </div>
            </div>
  
            <div class="col d-flex" id="search_filters">
              <!-- Etiquetas de filter -->
            </div>
          </div>
  
          <div class="table-responsive-vertical">
            <table id="table" class="table table-hover ">
              <thead>
                <tr>
                  <th>Fecha</th>
                  <th>Hora</th>
                  <th>Paciente</th>
                  <th>Estado</th>
                  <th> </th>
                </tr>
              </thead>
              <tbody id="lst-registros">
                <!-- Datos de registros de actividad -->
              </tbody>
            </table>
          </div>
  
          <nav aria-label="Page navigation">
            <ul class="pagination" id="paginador">
              <!-- Paginación -->
            </ul>
          </nav>
        </div>
      </main>
  
      <footerComponent/>
    </div>
  </template>
  
  <script>
  import HeaderComponent from '../components/common/HeaderComponent.vue';
  import SideMenu from '../components/common/SideMenu.vue';
  import FooterComponent from '../components/common/FooterComponent.vue';
  import { ref } from 'vue';
  //import { useRouter } from 'vue-router';
  
  export default {
    components: {
      headerComponent: HeaderComponent,
      footerComponent: FooterComponent,
      sideMenu: SideMenu
    },
    setup() {
      //const router = useRouter();
      const name_patient = ref('');
  
      const date_inicial = ref('');
      const date_fin = ref('');
  
      const exportToXlsx = () => {
        // Lógica para exportar a Excel
      };
  
      const applyFilters = () => {
        // Lógica para aplicar filtros
      };
  
      return {
        name_patient,
        date_inicial,
        date_fin,
        exportToXlsx,
        applyFilters
      };
    }
  };
  </script>

  