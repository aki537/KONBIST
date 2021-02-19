export const state = () => ({
  drawer: false,
  foods: [],
  status: false,
})

export const getters = {
  drawer: (state) => state.drawer,
  foods: (state) => state.foods,
  status: (state) => state.status,
}

export const mutations = {
  setDrawer(state, drawer) {
    state.drawer = drawer
  },
  setFoods(state, food) {
    state.Foods.push(food)
  },
  setStatus(state, bool) {
    state.status = bool
  },
}

export const actions = {
  showDrawer({ commit }, payload) {
    commit("setDrawer", payload)
  },
  addFood({ commit }, food) {
    commit("setFoods", food)
  },
}
