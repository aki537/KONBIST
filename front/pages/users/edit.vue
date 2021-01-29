<template>
  <v-app>
    <v-container>
      <v-card width="400px" class="mx-auto mt-5">
        <v-card-title>
          <h1 class="display-1">
            メールアドレス変更
          </h1>
        </v-card-title>
        <v-card-text>
          <v-form ref="form" lazy-validation>
            <p>現在のメールアドレス: {{ $store.state.auth.currentUser.email}}</p>
            <v-text-field
              v-model="user.email"
              prepend-icon="mdi-email"
              label="新しいメールアドレス"
            />
            <v-text-field
              v-model="user.password"
              prepend-icon="mdi-lock"
              append-icon="mdi-eye-off"
              label="パスワード"
            />
            <v-card-actions>
              <v-btn
                color="light-green darken-1"
                class="white--text"
                @click="editEmail"
              >
                保存する
              </v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
      <v-card width="400px" class="mx-auto mt-5">
        <v-card-title>
          <h1 class="display-1">
            パスワード変更
          </h1>
        </v-card-title>
        <v-card-text>
          <v-form ref="form" lazy-validation>
            <v-text-field
              v-model="pas.password"
              prepend-icon="mdi-email"
              label="新しいパスワード"
            />
            <v-text-field
              v-model="pas.password_confirmation"
              prepend-icon="mdi-lock"
              append-icon="mdi-eye-off"
              label="新しいパスワード確認"
            />
            <v-card-actions>
              <v-btn
                color="light-green darken-1"
                class="white--text"
                @click="editPassword"
              >
                保存する
              </v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </v-container>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      user: {
        password: '',
        email: '',
      },
      pas: {
        password: '',
        password_confirmation: ''
      }
    }
  },
  methods: {
    editEmail() {
      this.$axios
      .put('api/v1/auth', this.user, {
        headers: {
          'access-token': localStorage.getItem('access-token'),
          uid: localStorage.getItem('uid'),
          client: localStorage.getItem('client'),
        },
      })
      .then((res) => {
        console.log(res);
        this.$store.commit('auth/setCurrentUser', res.data )
        this.$router.push("/")
      })
    },
    editPassword() {
      this.$axios
      .put('api/v1/auth/password', this.pas, {
        headers: {
          'access-token': localStorage.getItem('access-token'),
          uid: localStorage.getItem('uid'),
          client: localStorage.getItem('client'),
        },
      })
      .then((res) => {
        console.log(res);
        this.$store.commit('auth/setCurrentUser', res.data )
        this.$router.push("/")
      })
    },
  },
}
</script>