export const state = () => ({
  rankingTab: 0,
  newTab: 0,
  search: "フード",
})

export const getters = {
  rankingTab: (state) => state.rankingTab,
  newTab: (state) => state.newTab,
  search: (state) => state.search,
}

export const mutations = {
  setRankingTab(state, payload) {
    state.rankingTab = payload
  },
  setNewTab(state, payload) {
    state.newTab = payload
  },
  setSearch(state, payload) {
    state.search = payload
  },
}

export const actions = {
  getRankingTab({ commit }, payload) {
    commit("setRankingTab", payload)
  },
  getNewTab({ commit }, payload) {
    commit("setNewTab", payload)
  },
  getSearch({ commit }, payload) {
    commit("setSearch", payload)
  },
}
