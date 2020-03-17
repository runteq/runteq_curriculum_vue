import axios from '../../plugins/axios'

const state = {
  user: {}
}

const getters =  {
  user: state => state.user,
  isAuthenticated: state => Object.keys(state.user).length > 0
}

const mutations = {
  setUser: (state, user) => {
    state.user = user
  },
}

const actions = {
  async loginUser({ commit }, user) {
    // ログイン
    const sessionsResponse = await axios.post('sessions', user)
    localStorage.auth_token = sessionsResponse.data.token
    axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`

    // ログインユーザー情報の取得
    const userResponse = await axios.get('users/me')
    commit('setUser', userResponse.data)
  },
  logoutUser({ commit }) {
    // ログアウト
    localStorage.removeItem('auth_token')
    axios.defaults.headers.common['Authorization'] = ''
    commit('setUser', {})
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
