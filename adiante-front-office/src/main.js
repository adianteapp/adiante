import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

import { FontAwesomeIcon } from './plugins/font-awesome'
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"
import './assets/css/main.css';
import 'material-symbols';

createApp(App)
  .use(router)
  .use(store)
  .component("font-awesome-icon", FontAwesomeIcon)
  .mount("#app");
