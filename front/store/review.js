export const actions = {
  async likeReview({ commit, rootState }, authData) {
    await this.$axios
      .$post("/api/v1/review_likes", {
        user_id: authData.user,
        review_id: authData.review,
      })
      .then(() => {
        commit("flashMessage/setMessage", "コメントにいいね！しました", {
          root: true,
        })
        commit("flashMessage/setType", "success", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        console.log(rootState.auth.currentUser.id)
        this.$axios
          .$get(`/api/v1/users/${rootState.auth.currentUser.id}`)
          .then((res) => {
            console.log(res)
            commit("auth/setLoginUser", res, { root: true })
            console.log("成功")
          })
      })
      .catch((err) => {
        commit(
          "flashMessage/setMessage",
          "コメントのいいね！に失敗しました。",
          {
            root: true,
          }
        )
        commit("flashMessage/setType", "error", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
      })
  },
  async unLikeReview({ rootState, commit }, authData) {
    await this.$axios
      .$delete("/api/v1/review_likes", {
        params: {
          user_id: authData.user,
          review_id: authData.review,
        },
      })
      .then(() => {
        console.log("unlike 成功")
        commit("flashMessage/setMessage", "いいね！から外しました。", {
          root: true,
        })
        commit("flashMessage/setType", "info", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        this.$axios
          .$get(`/api/v1/users/${rootState.auth.currentUser.id}`)
          .then((res) => {
            console.log(res)
            commit("auth/setLoginUser", res, { root: true })
            console.log("成功")
          })
      })
      .catch((err) => {
        commit("flashMessage/setMessage", "いいね！から外せませんでした。", {
          root: true,
        })
        commit("flashMessage/setType", "error", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
      })
  },
}
