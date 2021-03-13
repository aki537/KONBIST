export const state = () => ({
  tab: 0,
})

export const getters = {
  tab: (state) => state.tab,
}

export const mutations = {
  setTab(state, payload) {
    state.tab = payload
  },
}

export const actions = {
  getTab({ commit }, payload) {
    commit("setTab", payload)
  },
}
