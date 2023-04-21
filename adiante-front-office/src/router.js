import { createWebHistory, createRouter } from "vue-router";
import Login from "./views/LoginView.vue";
import Agenda from "./views/AgendaView.vue";   
import About from "./views/AboutView.vue"; 

//import Dashboard from "./views/DashboardView.vue";
// lazy-loaded
const Dashboard = () => import("./views/DashboardView.vue")


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
  },
  {
    path: "/ddashboard",
    name: "ddashboard",
    component: dDashboard,
  },
  {
    path: "/agenda",
    name: "agenda",
    component: Agenda,
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  const publicPages = ['/login', '/register', '/home','/ddashboard'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('user');

  // trying to access a restricted page + not logged in
  // redirect to login page
  if (authRequired && !loggedIn) {
    next('/login');
  } else {
    next();
  }
});

export default router;