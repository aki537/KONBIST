export const state = () => ({
  rankingTab: 0,
  newTab: 0,
})

export const getters = {
  rankingTab: (state) => state.rankingTab,
  newTab: (state) => state.newTab,
}

export const mutations = {
  setRankingTab(state, payload) {
    state.rankingTab = payload
  },
  setNewTab(state, payload) {
    state.newTab = payload
  },
}

export const actions = {
  getRankingTab({ commit }, payload) {
    commit("setRankingTab", payload)
  },
  getNewTab({ commit }, payload) {
    commit("setNewTab", payload)
  },
}
