<template>
    <div>
    <headerComponent/>
    <sideMenu/>
  
      <main>
        <div class="container">
          <ul class="breadcrumb">
            <li class="breadcrumb-item home"><a href="#">Home</a></li>
            <li class="breadcrumb-item last">Page</li>
          </ul>
          <div class="head">
            <div class="title">
              <h1>Pacientes</h1>
            </div>
            <div class="controls">
              <button class="btn btn-primary big"> <i class="icon-plus"></i> Action</button>
            </div>
          </div>
          <div class="table-responsive-vertical">
            <table id="table" class="table table-hover">
              <thead>
                <tr>
                  <th class="sorting">ID</th>
                  <th>Nombre</th>
                  <th>Apellido</th>
                  <th>Fecha de alta</th>
                  <th></th>
                  <th></th>
                </tr>
              </thead>
              <tbody id="dtsweb"></tbody>
            </table>
          </div>
  
          <nav aria-label="Page navigation">
            <ul class="pagination" id="paginador"></ul>
          </nav>
  
        </div>
      </main>
    </div>
  </template>
  
  <script>
  import HeaderComponent from '../components/common/HeaderComponent.vue';
  import SideMenu from '../components/common/SideMenu.vue';

  export default {
    name: 'DashboardView',
    components: {
      headerComponent: HeaderComponent,
      sideMenu: SideMenu
    }
  };
  </script>

  