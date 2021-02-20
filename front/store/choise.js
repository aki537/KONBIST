export const state = () => ({
  drawer: false,
  foods: [],
  calorie: 0,
  carbo: 0,
  protein: 0,
  lipid: 0,
})

export const getters = {
  drawer: (state) => state.drawer,
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
    state.foods.push(food)
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
    console.log("スタート")
    state.calorie = calorie
    state.carbo = carbo.toFixed(1)
    state.protein = protein.toFixed(1)
    state.lipid = lipid.toFixed(1)
  },
  unsetFoods(state, food) {
    state.foods.some(function (v, i) {
      if (v.id == food.id) state.foods.splice(i, 1)
      console.log("削除成功")
    })
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
    console.log("スタート")
    state.calorie = calorie
    state.carbo = carbo.toFixed(1)
    state.protein = protein.toFixed(1)
    state.lipid = lipid.toFixed(1)
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
  deleteFood({ commit }, food) {
    commit("unsetFoods", food)
  },
}
