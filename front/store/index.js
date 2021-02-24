export const actions = {
  nuxtClientInit({ commit }, context) {
    const data = JSON.parse(localStorage.getItem("vuex")) || []
    // ログインしいる場合localstorageからユーザー情報を取得
    if (data.auth.currentUser != null) {
      commit("auth/setCurrentUser", data.auth.currentUser)
    }
  },
}
