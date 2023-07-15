import taskService from "../services/task.service";
const stats = JSON.parse(localStorage.getItem('stats'));
const initialState = stats
  ? { status: { statsLoaded: true }, stats }
  : { status: { statsLoaded: false }, stats: null };

const retrieveStatsFromBackend = async () => {
        const today = new Date();
        const requestDate = today.toISOString().slice(0, 10);
        const response = await taskService.getPatientStats(requestDate);
        
        if(response.isAxiosError){
          console.log("Error retrieving patient stats");
          return null;
        }else{
          const totalTasksCount = response.tasksList.length;
          const completedTaskCount = response.tasksList.filter(task => task.executionDateTimeLocal != null).length;
          const patientStats = {total:totalTasksCount,completed:completedTaskCount,statsDate:today.toISOString()};
          return patientStats;
        }
};


const areStatsExpired = async (stats) => {
  let resultValidation = true;
  if(stats){
    const today = new Date();
    const statsDate = stats.date ? new Date(stats.date) : null;

    if(statsDate && statsDate < today){
        resultValidation = false;
    }
  }
  return resultValidation;
};



export const patientStats = {
  namespaced: true,
  state: initialState,
  actions: {
    
    async getPatientStats({ commit }) {

      const stats = JSON.parse(localStorage.getItem('stats'));
      if(areStatsExpired (stats)){
        const retrievedStats = await retrieveStatsFromBackend();
        if(retrievedStats){
          localStorage.setItem('stats', JSON.stringify(retrievedStats));
          commit('reset', retrievedStats);
        } 
      } 
    }
  },
  mutations: {
    increment(state) {
      state.pending ++;
    },
    reset(state, patientStats) {
      state.status.loggedIn = false;
      state.pending = null;
      state.stats = patientStats.total;
    },
    clear(state) {
      state.status.statsLoaded = false;
      state.stats = null;
    }
  },
};
