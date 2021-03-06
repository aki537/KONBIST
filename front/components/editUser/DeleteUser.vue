<template>
  <v-form ref="form" lazy-validation class="pt-3">
    <v-row class="pt-4 pl-3">
      <v-icon> mdi-account-remove </v-icon>
      <span>アカウント削除</span>
    </v-row>
    <v-row justify="center" class="mb-2">
      <v-btn
        color="error white--text"
        class="justify-center px-10 mt-5"
        @click="deleteUser"
      >
        削除
      </v-btn>
    </v-row>
  </v-form>
</template>

<script>
export default {
  methods: {
    deleteUser() {
      this.$axios
        .delete("api/v1/auth", {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then((res) => {
          console.log(res)
          this.$store.commit("auth/setCurrentUser", {})
          this.$store.commit("auth/setLoginUser", {})
          this.$store.commit("auth/setIsLoggedIn", false)
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "ユーザーを削除しました",
              type: "info",
              status: true,
            },
            { root: true }
          )
          this.$store.commit("choise/setDrawer", false)
          this.$store.commit("choise/resetFoods", [])
          this.$router.push("/")
        })
        .catch(() => {
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "ユーザーの削除に失敗しました。",
              type: "error",
              status: true,
            },
            { root: true }
          )
        })
    },
  },
}
</script>
