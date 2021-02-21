export const state = () => ({
  drawer: false,
  status: false,
  message: "",
  food: {},
  foods: [],
  calorie: 0,
  carbo: 0,
  protein: 0,
  lipid: 0,
})

export const getters = {
  drawer: (state) => state.drawer,
  status: (state) => state.status,
  message: (state) => state.message,
  food: (state) => state.food,
  foods: (state) => state.foods,
  calorie: (state) => state.calorie,
  carbo: (state) => state.carbo,
  protein: (state) => state.protein,
  lipid: (state) => state.lipid,
}

export const mutations = {
  setDrawer(state, drawer) {
    state.drawer = drawer
  },
  setFoods(state, food) {
    state.food = food
    state.foods.push(food)
  },
  resetFoods(state, payload) {
    state.foods = payload
  },
  unsetFoods(state, food) {
    state.food = food
    state.foods.some(function (v, i) {
      if (v.id == food.id) state.foods.splice(i, 1)
      console.log("削除成功")
    })
  },
  setCalorie(state, payload) {
    state.calorie = payload
  },
  setCarbo(state, payload) {
    state.carbo = payload.toFixed(1)
  },
  setProtein(state, payload) {
    state.protein = payload.toFixed(1)
  },
  setLipid(state, payload) {
    state.lipid = payload.toFixed(1)
  },
  setStatus(state, bool) {
    state.status = bool
  },
  setMessage(state, message) {
    state.message = message
  },
}

export const actions = {
  showDrawer({ commit }, payload) {
    commit("setDrawer", payload)
  },
  addFood({ state, commit, dispatch }, food) {
    commit("setFoods", food)
    let calorie = 0.0
    let carbo = 0.0
    let protein = 0.0
    let lipid = 0.0
    state.foods.forEach((f) => {
      calorie += f.calorie
      carbo += f.carbonhydrate
      protein += f.protein
      lipid += f.lipid
      console.log("終了")
    })
    console.log("代入")
    commit("setCalorie", calorie)
    commit("setCarbo", carbo)
    commit("setProtein", protein)
    commit("setLipid", lipid)
    dispatch("showFoodMessage", {
      status: true,
      message: "献立に追加しました。",
    })
    console.log("表示できたよ")
  },
  deleteFood({ state, commit, dispatch }, food) {
    commit("unsetFoods", food)
    let calorie = 0.0
    let carbo = 0.0
    let protein = 0.0
    let lipid = 0.0
    state.foods.forEach((f) => {
      calorie += f.calorie
      carbo += f.carbonhydrate
      protein += f.protein
      lipid += f.lipid
      console.log("終了")
    })
    console.log("代入")
    commit("setCalorie", calorie)
    commit("setCarbo", carbo)
    commit("setProtein", protein)
    commit("setLipid", lipid)
    dispatch("showFoodMessage", {
      status: true,
      message: "献立から削除しました。",
    })
    console.log("表示できたよ")
  },
  showFoodMessage({ commit }, { message, status }) {
    commit("setStatus", status)
    commit("setMessage", message)
    setTimeout(() => {
      commit("setStatus", !status)
    }, 700)
  },
  async registerFoods(
    { commit, dispatch, rootState, state },
    { day, zone, number }
  ) {
    try {
      const res = await this.$axios.$post("/api/v1/menus", {
        user_id: rootState.auth.currentUser.id,
        date: day,
        timezone: zone,
        timezone_number: number,
      })
      console.log(res)
      await Promise.all(
        state.foods.map((food) => {
          this.$axios.post("api/v1/choise_foods", {
            food_id: food.id,
            menu_id: res.id,
          })
        })
      )
      await this.$axios
        .$get(`/api/v1/users/${rootState.auth.currentUser.id}`)
        .then((res) => {
          console.log(res)
          commit("auth/setLoginUser", res, { root: true })
          console.log("成功")
        })
      dispatch(
        "flashMessage/showMessage",
        {
          message: "献立を保存しました。",
          type: "success",
          status: true,
        },
        { root: true }
      )
      commit("resetFoods", [])
      commit("setCalorie", 0)
      commit("setCarbo", 0.0)
      commit("setProtein", 0.0)
      commit("setLipid", 0.0)
    } catch (err) {
      console.log(err)
      dispatch(
        "flashMessage/showMessage",
        {
          message: "献立の保存に失敗しました。",
          type: "error",
          status: true,
        },
        { root: true }
      )
    }
  },
}
