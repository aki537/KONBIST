import createPersistedState from "vuex-persistedstate"

export default ({ store }) => {
  window.onNuxtReady(() => {
    createPersistedState({
      path: ["auth"],
    })(store)
  })
}
