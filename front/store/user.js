export const state = () => ({
  user: {},
  loginUser: {},
})

export const getters = {
  user: (state) => state.user,
  loginUser: (state) => state.loginUser,
}

export const mutations = {
  setUser(state, user) {
    state.user = user
  },
  setLoginUser(state, payload) {
    state.loginUser = payload
  },
}

export const actions = {
  async getUser({ commit }, paramsId) {
    await this.$axios
      .$get(`/api/v1/users/${paramsId}`)
      .then((res) => {
        console.log(res.data)
        commit("setUser", res.data)
      })
      .catch((err) => {
        console.log(err)
        return err
      })
  },
  async getLoginUser({ commit }, paramsId) {
    await this.$axios
      .$get(`/api/v1/users/${paramsId}`)
      .then((res) => {
        console.log(res.data)
        commit("setLoginUser", res.data.data)
      })
      .catch((err) => {
        console.log(err)
        return err
      })
  },
}
