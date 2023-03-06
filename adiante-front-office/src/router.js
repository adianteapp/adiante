import { createWebHistory, createRouter } from "vue-router";
import Login from "./views/LoginView.vue";
import Panel from "./views/PanelView.vue";   
import Agenda from "./views/AgendaView.vue";   
import About from "./views/AboutView.vue";
// lazy-loaded
const Panel = () => import("./views/PanelView.vue")
const BoardAdmin = () => import("./components/BoardAdmin.vue")
const BoardModerator = () => import("./components/BoardModerator.vue")
const BoardUser = () => import("./components/BoardUser.vue")

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
    path: "/panel",
    name: "panel",
    component: Panel,
  },
  {
    path: "/agenda",
    name: "agenda",
    component: Agenda,
  },
  {
    path: "/profile",
    name: "profile",
    // lazy-loaded
    component: Panel,
  },
  {
    path: "/admin",
    name: "admin",
    // lazy-loaded
    component: BoardAdmin,
  },
  {
    path: "/mod",
    name: "moderator",
    // lazy-loaded
    component: BoardModerator,
  },
  {
    path: "/user",
    name: "user",
    // lazy-loaded
    component: BoardUser,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  const publicPages = ['/login', '/register', '/home'];
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