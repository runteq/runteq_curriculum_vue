import Vue from 'vue'
import Vuex from 'vuex'
import axios from '../plugins/axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    tasks: []
  },

  getters: {
    tasks: state => state.tasks
  },

  mutations: {
    SET_TASKS: (state, tasks) => {
      state.tasks = tasks
    },
  },

  actions: {
    fetchTasks ({ state, commit }) {
      axios.get("tasks")
        .then(res => {
          commit('SET_TASKS', res.data)
        })
        .catch(err => console.log(err.status));
    },
  },
})
