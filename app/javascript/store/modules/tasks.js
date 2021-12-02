import axios from '../../plugins/axios'

const state = {
  tasks: []
}

const getters =  {
  tasks: state => state.tasks
}

const mutations = {
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
  },
  updateTask: (state, updateTask) => {
    const index = state.tasks.findIndex(task => {
      return task.id == updateTask.id
    })
    state.tasks.splice(index, 1, updateTask)
  },
}

const actions = {
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
  },
  updateTask({commit}, task) {
    return axios.patch(`tasks/${task.id}`, task)
      .then(res => {
        commit('updateTask', res.data)
      })
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
