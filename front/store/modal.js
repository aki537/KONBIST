export const state = () => ({
  loginModal: false,
  signUpModal: false,
})

export const getters = {
  loginModal: (state) => state.loginModal,
  signUpModal: (state) => state.signUpModal,
}

export const mutations = {
  clickLoginModal(state, bool) {
    state.loginModal = bool
  },
  clickSignUpModal(state, bool) {
    state.signUpModal = bool
  },
}

export const actions = {
  async loginUser({ commit }, bool) {
    commit("clickLoginModal", bool)
  },
  async signUpUser({ commit }, bool) {
    commit("clickSignUpModal", bool)
  },
}
