<template>
  <v-form ref="form" class="pt-4 pb-2">
    <ValidationObserver v-slot="{ invalid }">
      <v-row class="pt-4 pl-3">
        <v-icon> mdi-account-edit </v-icon>
        <span>ユーザー名</span>
      </v-row>
      <v-sheet class="pt-6">
        <ValidationProvider
          v-slot="{ errors, valid }"
          name="ニックネーム"
          rules="max:30|required"
        >
          <v-text-field
            v-model="name"
            label="新しいニックネーム"
            class="px-3"
            :error-messages="errors"
            :success="valid"
          />
        </ValidationProvider>
      </v-sheet>
      <v-row class="pt-7 pl-3">
        <v-icon> mdi-account-details </v-icon>
        <span>プロフィール</span>
      </v-row>
      <v-sheet class="pt-6 pb-3">
        <ValidationProvider
          v-slot="{ errors, valid }"
          name="ニックネーム"
          rules="max:255"
        >
          <v-textarea
            v-model="profile"
            label="プロフィール"
            class="px-3"
            :error-messages="errors"
            :success="valid"
          />
        </ValidationProvider>
      </v-sheet>
      <v-btn
        block
        color="success"
        class="white--text"
        :disabled="invalid"
        @click="changeUserProfile"
      >
        変更
      </v-btn>
    </ValidationObserver>
  </v-form>
</template>

<script>
export default {
  data() {
    return {
      name: this.$store.getters["auth/currentUser"].name,
      profile: this.$store.getters["auth/currentUser"].profile,
    }
  },
  methods: {
    async changeUserProfile() {
      const formData = new FormData()
      formData.append("name", this.name)
      formData.append("profile", this.profile)
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
              message: "ユーザープロフィールを更新しました。",
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
              message: "プロフィールの更新に失敗しました。",
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
