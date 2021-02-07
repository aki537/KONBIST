<template>
  <v-card>
    <v-system-bar
     lights-out
    >
      <v-spacer></v-spacer>
      <v-btn 
        icon
        @click="close"
        class="mt-5"
      >
        <v-icon>mdi-close</v-icon>
      </v-btn>
    </v-system-bar>
    <v-card-title>
      <span class="headline">ログイン</span>
    </v-card-title>
    <v-card-text>
      <v-form ref="form" v-model="isValid">
        <v-container>
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
            @click:append="show = !show"
            label="パスワード"
          />
        </v-container>
        <v-card-actions>
          <v-btn
            :disabled="!isValid"
            color="light-green darken-1"
            class="white--text pa-5 mt-3"
            @click="loginUser"
            block
          >
            ログイン
          </v-btn>
        </v-card-actions>
      </v-form>
    </v-card-text>
    <v-card-text
      class="text-center caption pb-5"
    >
      アカウントをお持ちでないですか？
      <span 
        @click="signUpLink"
        class="signup-link"
      >
        新規登録
      </span>
    </v-card-text>
  </v-card>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data() {
    return {
      isValid: false,
      show: false,
      noValidation: true,
      user: {
        email: '',
        password: ''
      },
      emailRules: [
      v => !!v || '',
      v => /.+@.+\..+/.test(v) || ''
    ],
    }
  },
  computed: {
    emailForm() {
      const placeholder = this.noValidation ? undefined : 'your@email.com'
      return { placeholder }
    },
    passwordRules () {
      const min = '6文字以上'
      const msg = `${min}。半角英数字•ﾊｲﾌﾝ•ｱﾝﾀﾞｰﾊﾞｰが使えます`
      const required = v => !!v || ''
      const format = v => /^[\w-]{6,72}$/.test(v) || msg

      const rules = this.noValidation ? [required] : [format]
      const hint = this.noValidation ? undefined : msg
      const placeholder = this.noValidation ? undefined : min
      return { rules, hint, placeholder }
    },
    toggle () {
      const icon = this.show ? 'mdi-eye' : 'mdi-eye-off'
      const type = this.show ? 'text' : 'password'
      return { icon, type }
    }
  },
  methods: {
    loginUser() {
      this.$emit('closeModal')
      this.login(this.user)
    },
    ...mapActions({
      login: 'auth/login',
    }),
    close() {
      this.$emit('closeModal')
    },
    signUpLink(){
      this.$emit('closeModal')
      this.$emit('newUser')
    }
  },
}
</script>

<style scoped>
.signup-link{
  color:#2196F3;
  cursor: pointer;
}
.signup-link:hover{
  opacity: 0.8;
  text-decoration: underline;
}
</style>