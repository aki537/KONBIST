export const state = () => ({
  foods: [],
})

export const getters = {
  foods: (state) => state.foods,
}

export const mutations = {
  setFoods(state, foods){
    state.foods = foods.data
  },
}

export const actions = {
  async getFoods({ commit }) {
    const foods = {
        data: '',
    };
    await this.$axios.get('api/v1/foods')
    .then(res => {
        foods.data = res.data;
        commit('setFoods', foods);
    })
    .catch(error => {
        console.log(error);
    });
},
} 
