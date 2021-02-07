<template>
  <v-card>
    <v-card-title>
      <span class="headline">新規登録</span>
    </v-card-title>
    <v-card-text>
      <v-form ref="form" v-model="isValid">
          <v-text-field
            v-model="user.name"
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
            label="プロフィール画像"
            prepend-icon="mdi-account"
            
          />
          <!-- <v-container>
            <v-row>
              <v-col cols="12">
                <v-text-field label="Legal first name*" required></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field label="Legal middle name" hint="example of helper text only on focus"></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field
                  label="Legal last name*"
                  hint="example of persistent helper text"
                  persistent-hint
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12">
                <v-text-field label="Email*" required></v-text-field>
              </v-col>
              <v-col cols="12">
                <v-text-field label="Password*" type="password" required></v-text-field>
              </v-col>
              <v-col cols="12" sm="6">
                <v-select
                  :items="['0-17', '18-29', '30-54', '54+']"
                  label="Age*"
                  required
                ></v-select>
              </v-col>
              <v-col cols="12" sm="6">
                <v-autocomplete
                  :items="['Skiing', 'Ice hockey', 'Soccer', 'Basketball', 'Hockey', 'Reading', 'Writing', 'Coding', 'Basejump']"
                  label="Interests"
                  multiple
                ></v-autocomplete>
              </v-col>
            </v-row>
          </v-container> -->
          <!-- <small>*indicates required field</small> -->
        <v-card-actions>
          <v-btn color="blue darken-1" text @click="close">閉じる</v-btn>
          <v-spacer></v-spacer>
          <!-- <v-btn color="blue darken-1" text @click="dialog = false">新規登録</v-btn> -->
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
      this.$emit('closeModal')
      this.signUp(this.user)
    },
    ...mapActions({
      signUp: 'auth/signUp',
    }),
    close() {
      this.$emit('closeModal')
    }
  },
}
</script>