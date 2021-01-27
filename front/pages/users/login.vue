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
              @click="login"
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
    async login() {
      await this.$axios.$post('/api/v1/auth/sign_in', {
        email: this.email,
        password: this.password,
      }).then( res => {
        console.log('ログイン成功' + ' /pages/login.vue')
        console.log(res)
        console.log(res.data)
        this.$store.commit('user/setCurrentUser', res.data)
        return res
      },
      (error) => {
        console.log('ログイン失敗' + ' /pages/login.vue')
        console.log(error)
        return error
      }
      )
    },
  },
  layout: 'default'
}
</script>