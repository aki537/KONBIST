<template>
  <v-app>
    <v-container>
      <v-card max-width="600px" class="mx-auto mt-5">
        <v-card-title>
          <h1 class="display-1">
            メールアドレス変更
          </h1>
        </v-card-title>
        <v-card-text>
          <v-form ref="form" lazy-validation>
            <v-text-field
              v-model="name"
              prepend-icon="mdi-lead-pencil"
              label="新しいニックネーム"
            />
            <v-text-field
              v-model="email"
              prepend-icon="mdi-email"
              label="新しいメールアドレス"
            />
            <v-file-input
              @change="setImage"
              accept="image/png, image/jpeg, image/bmp"
              outlined
              label="プロフィール画像"
            />
            <v-card-actions>
              <v-btn
                color="light-green darken-1"
                class="white--text"
                @click="updateUser"
                block
              >
                保存する
              </v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
      <v-card max-width="600px" class="mx-auto mt-5">
        <v-card-title>
          <h1 class="display-1">
            パスワード変更
          </h1>
        </v-card-title>
        <v-card-text>
          <v-form ref="form" lazy-validation>
            <v-text-field
              v-model="pas.password"
              prepend-icon="mdi-lock"
              append-icon="mdi-eye-off"
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
                block
              >
                保存する
              </v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
      <v-row justify="center">
        <v-btn
          color="red darken-1"
          class="white--text my-10 px-10 py-5"
          @click="deleteUser"
        >
          退会
        </v-btn>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      name: this.$store.state.auth.currentUser.name,
      image: this.$store.state.auth.currentUser.image.url,
      email: this.$store.state.auth.currentUser.email,
      pas: {
        password: '',
        password_confirmation: ''
      }
    }
  },
  methods: {
    async updateUser() {
      const formData = new FormData()
      formData.append("name", this.name)
      formData.append("email", this.email)
      if (this.image != ""){
        formData.append("image", this.image)
      }
      await this.$axios.put('api/v1/auth', formData, {
        headers: {
          "Content-Type": "multipart/form-data"
        }
      }).then((res) => {
        console.log(res);
        this.$store.commit('auth/setCurrentUser', res.data.data )
        this.$store.commit("flashMessage/setMessage", 'ユーザー情報を変更しました。', { root: true })
        this.$store.commit("flashMessage/setType", 'success', { root: true })
        this.$store.commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          this.$store.commit("flashMessage/setStatus", false, { root: true })
        }, 4000);
        this.$router.push("/")
      }).catch(() => {
        this.$store.commit("flashMessage/setMessage", 'ユーザー情報の変更に失敗しました。', { root: true })
        this.$store.commit("flashMessage/setType", 'error', { root: true })
        this.$store.commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          this.$store.commit("flashMessage/setStatus", false, { root: true })
        }, 4000);
      })
    },
    setImage(e){
      this.image = e;
    },
    editPassword() {
      this.$axios.put('api/v1/auth/password', this.pas, {
        headers: {
          'access-token': localStorage.getItem('access-token'),
          uid: localStorage.getItem('uid'),
          client: localStorage.getItem('client'),
        },
      })
      .then((res) => {
        console.log(res);
        this.$store.commit("flashMessage/setMessage", 'パスワードを変更しました。', { root: true })
        this.$store.commit("flashMessage/setType", 'success', { root: true })
        this.$store.commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          this.$store.commit("flashMessage/setStatus", false, { root: true })
        }, 4000);
        this.$router.push("/")
      }).catch(() => {
        this.$store.commit("flashMessage/setMessage", 'パスワードの変更に失敗しました。', { root: true })
        this.$store.commit("flashMessage/setType", 'error', { root: true })
        this.$store.commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          this.$store.commit("flashMessage/setStatus", false, { root: true })
        }, 4000);
      })
    },
    deleteUser() {
      this.$axios.delete('api/v1/auth', {
        headers: {
          'access-token': localStorage.getItem('access-token'),
          uid: localStorage.getItem('uid'),
          client: localStorage.getItem('client'),
        },
      })
      .then((res) => {
        this.$store.commit('auth/setCurrentUser', {})
        this.$store.commit('auth/setIsLoggedIn', false)
        this.$store.commit("flashMessage/setMessage", '登録ユーザーを削除しました。', { root: true })
        this.$store.commit("flashMessage/setType", 'info', { root: true })
        this.$store.commit("flashMessage/setStatus", true, { root: true })
        setTimeout(() => {
          this.$store.commit("flashMessage/setStatus", false, { root: true })
        }, 4000);
        this.$router.push("/")
        console.log(res)
        return res
      }).catch( err => {
        console.log(err)
        return err
      })
    },
  },

}
</script>
