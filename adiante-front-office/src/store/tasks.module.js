const tasks = JSON.parse(localStorage.getItem('tasks'));
const initialState = tasks
  ? { status: { loadedMasterTasks: true }, tasks }
  : { status: { loadedMasterTasks: false }, tasks: null };

export const storedTasks = {
  namespaced: true,
  state: initialState,
  actions: {
      },
  mutations: {
    addMasterTasks(state, tasks) {
      state.status.loadedMasterTasks = true;
      state.tasks = tasks;
    },
    cleanMasterTasks(state) {
      state.status.loadedMasterTasks = false;
      state.user = null;
    }
  },
};
