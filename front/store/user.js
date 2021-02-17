export const state = () => ({
  user: {},
})

export const getters = {
  user: (state) => state.user,
}

export const mutations = {
  setUser(state, user) {
    state.user = user
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
}
