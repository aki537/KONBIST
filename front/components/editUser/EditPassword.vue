<template>
  <v-form ref="form" class="mt-4 mb-2">
    <ValidationObserver v-slot="{ invalid }">
      <v-row class="pt-4 pl-3">
        <v-icon> mdi-email-edit </v-icon>
        <span>パスワード変更</span>
      </v-row>
      <v-sheet class="pt-6">
        <ValidationProvider
          v-slot="{ errors, valid }"
          name="password"
          rules="required|min:6"
        >
          <v-text-field
            v-model="pas.password"
            label="パスワード"
            class="px-3"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            :type="show1 ? 'text' : 'password'"
            :error-messages="errors"
            :success="valid"
            @click:append="show1 = !show1"
          />
        </ValidationProvider>
      </v-sheet>
      <v-sheet class="pt-6">
        <ValidationProvider
          v-slot="{ errors, valid }"
          name="パスワード(確認)"
          rules="required|min:6"
        >
          <v-text-field
            v-model="pas.password_confirmation"
            label="変更後パスワード(確認)"
            class="px-3"
            :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
            :type="show2 ? 'text' : 'password'"
            :error-messages="errors"
            :success="valid"
            @click:append="show2 = !show2"
          />
        </ValidationProvider>
      </v-sheet>
      <v-btn
        v-if="email != guest"
        block
        color="success"
        class="white--text"
        :disabled="invalid"
        @click="changeUserPassword"
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
      show1: false,
      show2: false,
      pas: {
        password: "",
        password_confirmation: "",
      },
      email: this.$store.getters["auth/currentUser"].uid,
      guest: "guestuser4501@gmail.com",
    }
  },
  methods: {
    changeUserPassword() {
      this.$axios
        .put("api/v1/auth/password", this.pas, {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then((res) => {
          console.log(res)
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "パスワードを更新しました。",
              type: "success",
              status: true,
            },
            { root: true }
          )
          this.$router.push("/")
        })
        .catch(() => {
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "パスワードの更新に失敗しました。",
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
