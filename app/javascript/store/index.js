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
    setTasks: (state, tasks) => {
      state.tasks = tasks
    },
    addTask: (state, task) => {
      state.tasks.push(task)
    },
    deleteTask: (state, deleteTask) => {
      state.tasks = state.tasks.filter(task => {
        return task.id != deleteTask.id
      })
    }
  },

  actions: {
    fetchTasks({ commit }) {
      axios.get('tasks')
        .then(res => {
          commit('setTasks', res.data)
        })
        .catch(err => console.log(err.response));
    },
    createTask({ commit }, task) {
      return axios.post('tasks', task)
        .then(res => {
          commit('addTask', res.data)
        })
    },
    deleteTask({commit}, task) {
      return axios.delete(`tasks/${task.id}`)
        .then(res => {
          commit('deleteTask', res.data)
        })
    }
  },
})
