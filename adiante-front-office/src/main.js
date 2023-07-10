import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import store from "./store";

import { FontAwesomeIcon } from './plugins/font-awesome'

import './assets/css/main.css';
import 'material-symbols';
import i18n from './locales/i18n'


createApp(App)
  .use(i18n)
  .use(router)
  .use(store)
  .component("font-awesome-icon", FontAwesomeIcon)
  .mount("#app");

