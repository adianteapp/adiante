import { createWebHistory, createRouter } from "vue-router";
import Login from "./views/LoginView.vue";
import About from "./views/AboutView.vue"; 
import authService from "./services/auth.service";

//import Dashboard from "./views/DashboardView.vue";
// lazy-loaded
const Dashboard = () => import("./views/DashboardView.vue")
const Agenda = () => import ("./views/AgendaView.vue");   
const routes = [
  {
    path: "/",
    name: "home",
    component: Login,
  },
  {
    path: "/home",
    component: Login,
  },
  {
    path: "/login",
    component: Login,
  },
  {
    path: "/about",
    component: About,
  },
  {
    path: "/dashboard",
    name: "dashboard",
    component: Dashboard,
    meta: {checkAuth: true}
  },
  {
    path: "/agenda",
    name: "agenda",
    component: Agenda,
    meta: {checkAuth: true}
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});



// This method is in charge to check if the user is logged validating the token
router.beforeEach(async (to, from, next) => {
  const publicPages = ['/login','/about','/'];
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