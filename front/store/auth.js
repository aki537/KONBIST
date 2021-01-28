export const state = () => ({
  currentUser: {},
  isLoggedIn:  false
})

export const getters = {
  current_user: state => state.currentUser,
  isLoggedIn: state => state.isLoggedIn,
}

export const mutations = {
  setCurrentUser(state, user){
    state.currentUser = user
  },
  setIsLoggedIn(state, bool){
    state.isLoggedIn = bool
  }
}

export const actions = {
  async signUp({ commit }, authData) {
    await this.$axios.post("/api/v1/auth/", {
          email: authData.email,
          password: authData.password,
          password_confirmation: authData.password_confirmation,
          // name: authData.name
        }
        // 登録成功時処理
      ).then(res => {
        console.log('新規登録成功' + ' /store/auth.js')
        console.log('ログイン成功' + ' /store/auth.js')
        console.log(res)
        commit("setCurrentUser", res.data)
        commit("setIsLoggedIn", true)
        this.$router.push("/")
      })
      // 登録失敗時処理
      .catch(err => {
        console.log('ログイン失敗' + ' /stores/auth.js')
        console.log(err)
      })
  },
  async login({ commit }, authData) {
    await this.$axios.$post('/api/v1/auth/sign_in', {
      email: authData.email,
      password: authData.password,
    }).then( res => {
      console.log('ログイン成功' + ' /store/auth.js')
      console.log(res)
      console.log(res.data)
      commit("setCurrentUser", res.data)
      commit("setIsLoggedIn", true)
      this.$router.push("/")
      return res
    },
    (err) => {
      console.log('ログイン失敗' + ' /store/auth.js')
      console.log(err)
      return err
    }
    )
  },
  async logout({ commit }){
    await this.$axios.$delete('/api/v1/auth/sign_out')
    .then( res => {
      console.log('ログアウト成功')
      commit('setCurrentUser', null)
      commit('setIsLoggedIn', false)
      this.$router.push("/")
      console.log(res)
      return res
    }).catch( err => {
      console.log('ログアウト失敗')
      console.log(err)
      return err
    })
  },
} 