import { createWebHistory, createRouter } from "vue-router";
import Login from "./views/LoginView.vue";
import authService from "./services/auth.service";
import Dashboard from "./views/DashboardView.vue";
import PatientAgenda from "./views/PatientAgenda.vue";
import  TaskManager from "./views/TaskManager.vue";
// lazy-loaded
const tabTitle = 'Adiante Backoffice';
const routes = [
  {
    path: "/",
    name: "home",
    component: Login
  },
  {
    path: "/home",
    component: Dashboard,
  },
  {
    path: "/dashboard",
    component: Dashboard,
  },
  {
    path: "/patient-agenda",
    component: PatientAgenda,
  },
  {
    path: "/task-manager",
    component: TaskManager,
  },
  {
    path: "/login",
    component: Login
  },
  
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});



// This method is in charge to check if the user is logged validating the token
router.beforeEach(async (to, from, next) => {

  document.title = tabTitle;

  const publicPages = ['/login','/about','/','/dashboard','/patient-agenda','/task-manager'];
  const authRequired = !publicPages.includes(to.path);
  // Genereate a comment explaining this code below 
  
  async function loggedIn() {
      const response = await authService.validateToken();
        if (response == true) {
          return true;
        }
        else{
          return false;
        }
  }

  // trying to access a restricted page + not logged in
  // redirect to login page
  if (authRequired ) {
    const isLogged = await loggedIn();
    if (!isLogged) {
      authService.logout();
      next('/login');
    }else{
      next();
    }
  } else {
    next();
  }
});

export default router;