export const mutations = {
  sortFoods({ commit }, { sort, foods }) {
    const result = []
    if (sort.onigiri) {
      foods.filter((value) => {
        if (value.category.indexOf("おにぎり") !== -1) {
          result.push(value)
        }
      })
    }
    if (sort.bento) {
      foods.filter((value) => {
        if (value.category.indexOf("お弁当") !== -1) {
          result.push(value)
        }
      })
    }
    if (!sort.onigiri && !sort.bento) {
      foods.filter((value) => {
        result.push(value)
      })
    }
  },
}
