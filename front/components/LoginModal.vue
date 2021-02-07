<template>
  <v-card>
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
            color="blue darken-1"
            text
            @click="close"
          >
            閉じる
          </v-btn>
          <v-spacer></v-spacer>
          <v-btn
            :disabled="!isValid"
            color="light-green darken-1"
            class="white--text pa-5"
            @click="loginUser"
          >
            ログイン
          </v-btn>
        </v-card-actions>
      </v-form>
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
    }
  },
}
</script>