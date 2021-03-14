export const state = () => ({
  rankingTab: 0,
})

export const getters = {
  rankingTab: (state) => state.rankingTab,
}

export const mutations = {
  setRankingTab(state, payload) {
    state.rankingTab = payload
  },
}

export const actions = {
  getRankingTab({ commit }, payload) {
    commit("setRankingTab", payload)
  },
}
