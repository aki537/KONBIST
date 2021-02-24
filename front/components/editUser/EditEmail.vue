<template>
  <v-form ref="form" lazy-validation class="mb-6">
    <v-row class="pt-4 pl-3">
      <v-icon> mdi-email-edit </v-icon>
      <span>メールアドレス</span>
    </v-row>
    <v-row justify="center" class="pt-6">
      <v-text-field v-model="email" label="新しいメールアドレス" class="px-3" />
    </v-row>
    <v-btn block color="success" class="white--text" @click="changeUserEmail">
      変更
    </v-btn>
  </v-form>
</template>

<script>
export default {
  data() {
    return {
      email: this.$store.getters["auth/currentUser"].email,
    }
  },
  methods: {
    async changeUserEmail() {
      const formData = new FormData()
      formData.append("email", this.email)
      await this.$axios
        .put("api/v1/auth", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then((res) => {
          console.log(res)
          this.$store.commit("auth/setCurrentUser", res.data.data)
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "メールアドレスを更新しました。",
              type: "success",
              status: true,
            },
            { root: true }
          )
        })
        .catch(() => {
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "メールアドレスの更新に失敗しました。",
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
