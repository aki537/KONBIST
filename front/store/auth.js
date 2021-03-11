export const state = () => ({
  currentUser: null,
  loginUser: null,
  isLoggedIn: false,
  isAdmin: false,
})

export const getters = {
  currentUser: (state) => state.currentUser,
  loginUser: (state) => state.loginUser,
  isLoggedIn: (state) => state.isLoggedIn,
  isAdmin: (state) => state.isAdmin,
}

export const mutations = {
  setCurrentUser(state, user) {
    state.currentUser = user
  },
  setLoginUser(state, user) {
    state.loginUser = user
  },
  setIsLoggedIn(state, bool) {
    state.isLoggedIn = bool
  },
  setIsAdmin(state, bool) {
    state.isAdmin = bool
  },
}

export const actions = {
  async signUp({ commit, state }, authData) {
    const form = new FormData()
    form.append("name", authData.name)
    form.append("email", authData.email)
    form.append("password", authData.password)
    form.append("password_confirmation", authData.password_confirmation)
    // if (authData.image !== null) {
    //   form.append("image", authData.image)
    // }
    await this.$axios
      .post("/api/v1/auth/", form, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      })
      // 登録成功時処理
      .then((res) => {
        console.log(res)
        commit("setCurrentUser", res.data.data)
        commit("flashMessage/setMessage", "ユーザーを登録しました。", {
          root: true,
        })
        commit("flashMessage/setType", "success", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        commit("modal/clickSignUpModal", false, { root: true })
        this.$router.push("/")
        this.$axios
          .$get(`/api/v1/users/${state.currentUser.id}`)
          .then((res) => {
            console.log("loginUser")
            commit("setLoginUser", res)
            commit("setIsLoggedIn", true)
            console.log("成功")
          })
        this.$router.push("/")
      })
      // 登録失敗時処理
      .catch((err) => {
        console.log(err)
        commit("flashMessage/setMessage", "ユーザー登録に失敗しました。", {
          root: true,
        })
        commit("flashMessage/setType", "error", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
      })
  },
  async login({ commit, state }, authData) {
    await this.$axios
      .$post("/api/v1/auth/sign_in", {
        email: authData.email,
        password: authData.password,
      })
      .then((res) => {
        console.log(res.data)
        commit("setCurrentUser", res.data)
        commit("flashMessage/setMessage", "ログインしました。", { root: true })
        commit("flashMessage/setType", "success", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        commit("modal/clickLoginModal", false, { root: true })
        this.$router.push("/")
        this.$axios
          .$get(`/api/v1/users/${state.currentUser.id}`)
          .then((res) => {
            console.log("loginUser")
            commit("setLoginUser", res)
            commit("setIsLoggedIn", true)
            console.log("成功")
            if (state.currentUser.admin) {
              commit("setIsAdmin", true)
              this.$router.push("admin")
            } else {
              this.$router.push("/")
            }
          })
        return res
      })
      .catch((err) => {
        commit("flashMessage/setMessage", "ログインに失敗しました。", {
          root: true,
        })
        commit("flashMessage/setType", "error", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        console.log(err)
        return err
      })
  },
  async logout({ commit, dispatch }) {
    await this.$axios
      .$delete("/api/v1/auth/sign_out")
      .then((res) => {
        commit("setCurrentUser", null)
        commit("setLoginUser", null)
        commit("setIsLoggedIn", false)
        commit("setIsAdmin", false)
        commit("flashMessage/setMessage", "ログアウトしました。", {
          root: true,
        })
        commit("flashMessage/setType", "success", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        commit("choise/setDrawer", false, { root: true })
        commit("choise/resetFoods", [], { root: true })
        dispatch("choise/deleteChoise", true, { root: true })
        this.$router.push("/")
        return res
      })
      .catch((err) => {
        console.log(err)
        commit("setCurrentUser", null)
        commit("setLoginUser", null)
        commit("setIsLoggedIn", false)
        commit("setIsAdmin", false)
        commit("flashMessage/setMessage", "ログアウトしました。", {
          root: true,
        })
        commit("flashMessage/setType", "success", { root: true })
        commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          commit("flashMessage/setStatus", false, { root: true })
        }, 1000)
        commit("choise/setDrawer", false, { root: true })
        commit("choise/resetFoods", [], { root: true })
        dispatch("choise/deleteChoise", true, { root: true })
        this.$router.push("/")
        // commit("flashMessage/setMessage", "ログアウトに失敗しました。", {
        //   root: true,
        // })
        // commit("flashMessage/setType", "", { root: true })
        // commit("flashMessage/setStatus", true, { root: true })
        // setTimeout(() => {
        //   commit("flashMessage/setStatus", false, { root: true })
        // }, 1000)
        // return err
      })
  },
}
