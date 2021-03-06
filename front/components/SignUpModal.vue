<template>
  <v-card>
    <v-system-bar lights-out>
      <v-spacer></v-spacer>
      <v-btn icon class="mt-6" large @click="signUpDialog(false)">
        <v-icon>mdi-close</v-icon>
      </v-btn>
    </v-system-bar>
    <v-card-title>
      <span class="headline">新規登録</span>
    </v-card-title>
    <v-card-text>
      <v-form ref="form" v-model="isValid">
        <v-container>
          <v-text-field
            v-model="user.name"
            :rules="nameRules"
            :placeholder="nameForm.placeholder"
            label="ニックネーム"
            prepend-icon="mdi-lead-pencil"
          />
          <v-text-field
            v-model="user.email"
            :rules="emailRules"
            :placeholder="emailForm.placeholder"
            prepend-icon="mdi-email"
            label="メールアドレス"
          />
          <v-text-field
            v-model="user.password"
            :rules="passwordRules.rules"
            :counter="!noValidation"
            :hint="passwordRules.hint"
            :placeholder="passwordRules.placeholder"
            :hide-details="noValidation"
            prepend-icon="mdi-lock"
            :append-icon="toggle.icon"
            :type="toggle.type"
            autocomplete="on"
            label="パスワード"
            @click:append="show1 = !show1"
          />
          <v-text-field
            v-model="user.password_confirmation"
            :rules="passwordRules.rules"
            :counter="!noValidation"
            :hint="passwordRules.hint"
            :placeholder="passwordRules.placeholder"
            :hide-details="noValidation"
            prepend-icon="mdi-lock"
            :append-icon="toggle.icon"
            :type="toggle.type"
            autocomplete="on"
            label="パスワード確認"
            @click:append="show2 = !show2"
          />
        </v-container>
        <!-- <small class="ml-4">*必須項目</small> -->
        <v-card-actions>
          <v-btn
            :disabled="!isValid"
            color="light-green darken-1"
            class="white--text pa-5"
            block
            @click="registerUser"
          >
            新規登録
          </v-btn>
        </v-card-actions>
      </v-form>
    </v-card-text>
    <v-card-text class="text-center caption pb-5">
      <span class="login-link" @click="guestLogin">
        ゲストユーザーでログイン
      </span>
    </v-card-text>
    <v-card-text class="text-center caption pb-5">
      アカウントをお持ちですか？
      <span class="login-link" @click="loginLink"> ログイン </span>
    </v-card-text>
  </v-card>
</template>

<script>
import { mapActions } from "vuex"
export default {
  data() {
    const max = 30
    return {
      isValid: false,
      show1: false,
      show2: false,
      noValidation: false,
      user: {
        email: "",
        password: "",
        password_confirmation: "",
        name: "",
        image: "",
      },
      guest: {
        email: "guestuser4501@gmail.com",
        password: "guestuser",
      },
      max,
      nameRules: [
        (v) => !!v || "",
        (v) => (!!v && max >= v.length) || `${max}文字以内で入力してください`,
      ],
      emailRules: [(v) => !!v || "", (v) => /.+@.+\..+/.test(v) || ""],
    }
  },
  computed: {
    nameForm() {
      const placeholder = this.noValidation ? undefined : "username"
      return { placeholder }
    },
    emailForm() {
      const placeholder = this.noValidation ? undefined : "your@email.com"
      return { placeholder }
    },
    passwordRules() {
      const min = "6文字以上"
      const msg = `${min}。半角英数字•ﾊｲﾌﾝ•ｱﾝﾀﾞｰﾊﾞｰが使えます`
      const required = (v) => !!v || ""
      const format = (v) => /^[\w-]{6,72}$/.test(v) || msg

      const rules = this.noValidation ? [required] : [format]
      const hint = this.noValidation ? undefined : msg
      const placeholder = this.noValidation ? undefined : min
      return { rules, hint, placeholder }
    },
    toggle() {
      const icon = this.show ? "mdi-eye" : "mdi-eye-off"
      const type = this.show ? "text" : "password"
      return { icon, type }
    },
  },
  methods: {
    ...mapActions({
      signUp: "auth/signUp",
      login: "auth/login",
      loginDialog: "modal/loginUser",
      signUpDialog: "modal/signUpUser",
    }),
    setImage(e) {
      this.user.image = e
    },
    registerUser() {
      this.signUp(this.user)
      this.signUpDialog(false)
    },
    guestLogin() {
      this.login(this.guest)
      this.signUpDialog(false)
    },
    loginLink() {
      this.signUpDialog(false)
      this.loginDialog(true)
    },
  },
}
</script>

<style scoped>
.login-link {
  color: #2196f3;
  cursor: pointer;
}
.login-link:hover {
  opacity: 0.8;
  text-decoration: underline;
}
</style>
