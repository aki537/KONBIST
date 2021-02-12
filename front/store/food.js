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
}
