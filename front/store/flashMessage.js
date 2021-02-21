export const state = () => ({
  message: "",
  type: "",
  status: false,
})

export const getters = {
  message: (state) => state.message,
  type: (state) => state.type,
  status: (state) => state.status,
}

export const mutations = {
  setMessage(state, message) {
    state.message = message
  },
  setType(state, type) {
    state.type = type
  },
  setStatus(state, bool) {
    state.status = bool
  },
}

export const actions = {
  showMessage({ commit }, { message, type, status }) {
    commit("setMessage", message)
    commit("setType", type)
    commit("setStatus", status)
    setTimeout(() => {
      commit("setStatus", !status)
    }, 700)
  },
}
