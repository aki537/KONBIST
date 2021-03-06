export const state = () => ({
  foods: [],
  food: {},
})

export const getters = {
  foods: (state) => state.foods,
  food: (state) => state.food,
}

export const mutations = {
  setFoods(state, foods) {
    state.foods = foods.data
  },
  setFood(state, food) {
    state.food = food
  },
}

export const actions = {
  // setFood({ commit, rootState }, payload) {
  // },
  async getFoods({ commit }) {
    const foods = {
      data: "",
    }
    await this.$axios
      .get("api/v1/foods")
      .then((res) => {
        foods.data = res.data
        commit("setFoods", foods)
      })
      .catch((error) => {
        console.log(error)
      })
  },
  async likeFood({ commit, rootState }, authData) {
    await this.$axios
      .$post("/api/v1/food_likes", {
        user_id: authData.user,
        food_id: authData.food,
      })
      .then(() => {
        commit("flashMessage/setMessage", "食べたいに追加しました。", {
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
        commit("flashMessage/setMessage", "追加に失敗しました。", {
          root: true,
        })
        commit("flashMessage/setType", "error", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
      })
  },
  async unLikeFood({ rootState, commit }, authData) {
    await this.$axios
      .$delete("/api/v1/food_likes", {
        params: {
          user_id: authData.user,
          food_id: authData.food,
        },
      })
      .then(() => {
        console.log("unfollow 成功")
        commit("flashMessage/setMessage", "食べたいから外しました。", {
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
        commit("flashMessage/setMessage", "食べたいから外せませんでした。", {
          root: true,
        })
        commit("flashMessage/setType", "error", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
      })
  },
  async review({ commit }, authData) {
    const form = new FormData()
    form.append("title", authData.title)
    form.append("content", authData.content)
    form.append("rate", authData.rate)
    form.append("user_id", authData.user_id)
    form.append("food_id", authData.food_id)
    if (authData.image !== null) {
      form.append("image", authData.image)
    }
    console.log(authData.image)
    await this.$axios
      .$post("/api/v1/reviews", form, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      })
      .then(() => {
        commit("flashMessage/setMessage", "口コミを投稿しました", {
          root: true,
        })
        commit("flashMessage/setType", "success", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        this.$axios.$get(`/api/v1/foods/${authData.food_id}`).then((res) => {
          commit("setFood", res)
          console.log("成功")
        })
      })
      .catch((err) => {
        commit("flashMessage/setMessage", "口コミの投稿に失敗しました。", {
          root: true,
        })
        commit("flashMessage/setType", "error", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
      })
  },
  async editReview({ commit }, authData) {
    const form = new FormData()
    form.append("title", authData.title)
    form.append("content", authData.content)
    form.append("rate", authData.rate)
    form.append("user_id", authData.user_id)
    form.append("food_id", authData.food_id)
    if (authData.image !== null) {
      form.append("image", authData.image)
    }
    console.log(authData.image)
    await this.$axios
      .$put(`/api/v1/reviews/${authData.reviewId}`, form, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
        params: {
          review_id: authData.reviewId,
        },
      })
      .then(() => {
        commit("flashMessage/setMessage", "口コミを更新しました", {
          root: true,
        })
        commit("flashMessage/setType", "info", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        this.$axios.$get(`/api/v1/foods/${authData.food_id}`).then((res) => {
          commit("setFood", res)
          console.log("成功")
        })
      })
      .catch((err) => {
        commit("flashMessage/setMessage", "口コミの投稿に失敗しました。", {
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
