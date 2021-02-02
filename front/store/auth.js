export const state = () => ({
  currentUser: {},
  isLoggedIn:  false
})

export const getters = {
  currentUser: state => state.currentUser,
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
    const form = new FormData()
    form.append("name", authData.name)
    form.append("email", authData.email)
    form.append("password", authData.password)
    form.append("password_confirmation", authData.password_confirmation)
    if (authData.image !== null ){
      form.append("image", authData.image)
    }
    await this.$axios.post("/api/v1/auth/", form,{
      headers: {
        "Content-Type": "multipart/form-data"
      }
    })
        // 登録成功時処理
      .then(res => {
        console.log('新規登録成功' + ' /store/auth.js')
        console.log(res)
        commit("setCurrentUser", res.data.data)
        commit("setIsLoggedIn", true)
        console.log('ログイン成功' + ' /store/auth.js')
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
      commit('setCurrentUser', {})
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