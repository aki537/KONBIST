<template>
  <v-container>
    <v-card width="400px" class="mx-auto mt-5">
      <v-card-title>
        <h1 class="display-1">
          ログイン
        </h1>
      </v-card-title>
      <v-card-text>
        <v-form ref="form" lazy-validation>
          <v-text-field
            v-model="email"
            prepend-icon="mdi-email"
            label="メールアドレス"
          />
          <v-text-field
            v-model="password"
            prepend-icon="mdi-lock"
            append-icon="mdi-eye-off"
            label="パスワード"
          />
          <v-card-actions>
            <v-btn
              color="light-green darken-1"
              class="white--text"
              @click="loginWithAuthModule"
            >
              ログイン
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      password: '',
      email: '',
    }
  },
  methods: {
    // loginメソッドの呼び出し
    async loginWithAuthModule() {
      await this.$auth
        .loginWith('local', {
         // emailとpasswordの情報を送信
          data: {
            email: this.email,
            password: this.password,
          },
        })
        .then(
          (response) => {
　　　　　　　// レスポンスで返ってきた、認証に必要な情報をlocalStorageに保存
            localStorage.setItem('access-token', response.headers['access-token'])
            localStorage.setItem('client', response.headers.client)
            localStorage.setItem('uid', response.headers.uid)
            localStorage.setItem('token-type', response.headers['token-type'])
            return response
          },
          (error) => {
            return error
          }
        )
    },
  },
  layout: 'default'
}
</script>