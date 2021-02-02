<template>
  <v-container>
    <v-card width="400px" class="mx-auto mt-5">
      <v-card-title>
        <h1 class="display-1">
          新規登録
        </h1>
      </v-card-title>
      <v-card-text>
        <v-form ref="form" v-model="isValid">
          <v-text-field
            v-model="user.name"
            label="ニックネーム"
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
            @click:append="show = !show"
            label="パスワード"
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
            @click:append="show = !show"
            label="パスワード確認"
          />
          <v-file-input
            @change="setImage"
            accept="image/png, image/jpeg, image/bmp"
            outlined
            label="プロフィール画像"
          />
          <v-card-actions>
            <v-btn
              :disabled="!isValid"
              color="light-green darken-1"
              class="white--text"
              @click="registerUser"
            >
              新規登録
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data() {
    // const max = 30
    return {
      isValid: false,
      show: false,
      noValidation: false,
      user: {
        email: '',
        password: '',
        password_confirmation: '',
        name: '',
        image: ''
      },
      // max,
      // rules: [
      //   v => !!v || '',
      //   v => (!!v && max >= v.length) || `${max}文字以内で入力してください`
      // ]
      // emailRules: [
      //   v => !!v || '',
      //   v => /.+@.+\..+/.test(v) || ''
      // ],
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
    setImage(e){
      this.user.image = e;
    },
    registerUser() {
      this.signUp(this.user)
    },
    ...mapActions({
      signUp: 'auth/signUp',
    }),
  },
}
</script>