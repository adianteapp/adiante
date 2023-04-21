import { createStore } from "vuex";
import { auth } from "./auth.module";
import { storedTasks } from './tasks.module'
const store = createStore({

  modules: {
    auth,storedTasks
  },
});

export default store;
