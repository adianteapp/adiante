import { createWebHistory, createRouter } from "vue-router";
import Login from "./views/LoginView.vue";
import Contact from "./views/ContactView.vue"; 
import authService from "./services/auth.service";

//import Dashboard from "./views/DashboardView.vue";
// lazy-loaded
const Dashboard = () => import("./views/DashboardView.vue")
const Agenda = () => import ("./views/AgendaView.vue"); 
const Activities = () => import ("./views/ActivitiesView.vue");  
const IntroActivity = () => import ("./views/IntroActivityView.vue");  
const tabTitle = 'Adiante App';
const routes = [
  {
    path: "/",
    name: "home",
    component: Login,
    meta: {checkAuth: true}
  },
  {
    path: "/home",
    component: Login,
  },
  {
    path: "/login",
    component: Login
  },
  {
    path: "/contact",
    component: Contact,
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
  },
  {
    path: "/activities",
    name: "activities",
    component: Activities,
    meta: {checkAuth: true}
  },
  {
    path: "/activity-intro",
    name: "activity-intro",
    component: IntroActivity,
    meta: {checkAuth: true,
          }
  }  
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});



// This method is in charge to check if the user is logged validating the token
router.beforeEach(async (to, from, next) => {

  document.title = tabTitle;

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