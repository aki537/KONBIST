<template>
  <v-form ref="form" class="mb-6">
    <ValidationObserver v-slot="{ invalid }">
      <v-row class="pt-4 pl-3">
        <v-icon> mdi-email-edit </v-icon>
        <span>メールアドレス</span>
      </v-row>
      <v-sheet class="pt-6">
        <ValidationProvider
          v-slot="{ errors, valid }"
          name="新しいメールアドレス"
          rules="required|email"
        >
          <v-text-field
            v-model="email"
            label="新しいメールアドレス"
            class="px-3"
            :error-messages="errors"
            :success="valid"
          />
        </ValidationProvider>
      </v-sheet>
      <v-btn
        v-if="originEmail != guest"
        block
        color="success"
        class="white--text"
        :disabled="invalid"
        @click="changeUserEmail"
      >
        変更
      </v-btn>
      <v-btn v-else block color="grey" class="white--text">
        ゲストユーザーの為変更できません
      </v-btn>
    </ValidationObserver>
  </v-form>
</template>

<script>
export default {
  data() {
    return {
      email: this.$store.getters["auth/currentUser"].email,
      originEmail: this.$store.getters["auth/currentUser"].uid,
      guest: "guestuser4501@gmail.com",
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
