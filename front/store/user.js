export const state = () => ({
  current_user: {},
  isLoggedIn:  false
})

export const getters = {
  current_user: (state) => state.current_user,
  isLoggedIn: (state) => state.isLoggedIn,
}

export const mutations = {
  setCurrentUser(state, user){
    console.log('vuex store にcurrent user をセット')
    state.current_user = user
    state.isLoggedIn = true
    console.log(state)
  },
  // removeCurrentUser(state, user){
  //   state.current_user = {}
  //   state.isLoggedIn = false
  // },
}