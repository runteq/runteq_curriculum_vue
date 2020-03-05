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
    ADD_TASK: (state, task) => {
      state.tasks.push(task)
    }
  },

  actions: {
    fetchTasks({ commit }) {
      axios.get('tasks')
        .then(res => {
          commit('SET_TASKS', res.data)
        })
        .catch(err => console.log(err.response));
    },
    createTask({ commit }, task) {
      return axios.post('tasks', task)
        .then(res => {
          commit('ADD_TASK', res.data)
        })
    }
  },
})
