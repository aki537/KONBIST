<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="4" lg="6" sm="8" cols="12">
        <v-card class="mx-auto">
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            background-color="grey lighten-1"
            slider-color="info"
            icons-and-text
          >
            <v-tab class="ma-0 pa-0">
              プロフィール
              <v-icon>mdi-account</v-icon>
            </v-tab>
            <v-tab class="ma-0 pa-0">
              登録情報
              <v-icon>mdi-account-cog</v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-tab-item>
              <edit-avatar :image="image" />
              <v-divider />
            </v-tab-item>
            <!-- <v-tab-item>
              <v-container>
                <v-row>
                  <v-col cols="12">
                    <v-form>
                      <ValidationObserver v-slot="{ invalid }">
                        <EditTextField
                          v-model="email"
                          label="メールアドレス"
                          icon="mdi-email-edit"
                          rules="max:255|required|email"
                        />
                        <v-row>
                          <v-col cols="12">
                            <v-btn
                              v-if="guest === false"
                              color="success"
                              block
                              class="white--text"
                              :disabled="invalid"
                              @click="openDialogForEmail"
                            >
                              変更
                            </v-btn>
                            <v-btn
                              v-else
                              color="grey"
                              block
                              class="white--text"
                              :disabled="invalid"
                            >
                              変更(ゲストユーザーのため変更不可)
                            </v-btn>
                          </v-col>
                        </v-row>
                      </ValidationObserver>
                    </v-form>
                  </v-col>
                  <v-col cols="12" class="mt-3 mb-3">
                    <v-divider />
                  </v-col>
                  <v-col cols="12">
                    <ValidationObserver v-slot="{ invalid }">
                      <v-row>
                        <v-col cols="12">
                          <v-icon>mdi-account-key</v-icon>
                          <span>パスワードを変更する</span>
                        </v-col>
                      </v-row>
                      <TextFieldWithValidation
                        v-model="password"
                        label="変更後のパスワード"
                        rules="required|min:6"
                        :type="show1 ? 'text' : 'password'"
                        :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                        vid="password"
                        @click:append="show1 = !show1"
                      />
                      <TextFieldWithValidation
                        v-model="passwordConfirm"
                        label="変更後のパスワード(再入力)"
                        rules="required|min:6|confirmed:変更後のパスワード"
                        :type="show2 ? 'text' : 'password'"
                        :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
                        @click:append="show2 = !show2"
                      />
                      <v-row>
                        <v-col cols="12">
                          <v-btn
                            v-if="guest === false"
                            color="success"
                            block
                            class="white--text"
                            :disabled="invalid"
                            @click="openDialogForPassword"
                          >
                            変更
                          </v-btn>
                          <v-btn
                            v-else
                            color="grey"
                            block
                            class="white--text"
                            :disabled="invalid"
                          >
                            変更(ゲストユーザーのため変更不可)
                          </v-btn>
                        </v-col>
                      </v-row>
                    </ValidationObserver>
                    <p v-if="error" class="errors">{{ error }}</p>
                  </v-col>
                  <v-col cols="12">
                    <v-divider />
                  </v-col>
                  <v-col cols="12">
                    <v-row>
                      <v-col cols="12">
                        <v-icon>mdi-account-remove</v-icon>
                        <span>アカウントを削除する</span>
                      </v-col>
                    </v-row>
                    <v-row>
                      <v-col cols="12" class="mb-3">
                        <v-btn
                          v-if="guest === false"
                          block
                          color="white--text red"
                          @click="openDialogForDeleteAccount"
                        >
                          削除
                        </v-btn>
                        <v-btn v-else block color="white--text grey">
                          変更(ゲストユーザーのため変更不可)
                        </v-btn>
                      </v-col>
                    </v-row>
                  </v-col>
                </v-row>
              </v-container>
            </v-tab-item> -->
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
    <v-card max-width="600px" class="mx-auto mt-5">
      <v-card-title>
        <h1 class="display-1">メールアドレス変更</h1>
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
            accept="image/png, image/jpeg, image/bmp"
            outlined
            label="プロフィール画像"
            @change="setImage"
          />
          <v-card-actions>
            <v-btn
              color="light-green darken-1"
              class="white--text"
              block
              @click="updateUser"
            >
              保存する
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
    <v-card max-width="600px" class="mx-auto mt-5">
      <v-card-title>
        <h1 class="display-1">パスワード変更</h1>
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
              block
              @click="editPassword"
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
</template>

<script>
import { mapGetters } from "vuex"
import editAvatar from "~/components/editUser/EditAvatar"
// import editEmail from "~/components/editUser/EditEmail"
// import editPassword from "~/components/editUser/EditPassword"
// import editProfile from "~/components/editUser/EditProfile"
// import deleteUser from "~/components/editUser/DeleteUser"

export default {
  components: {
    editAvatar,
    // editEmail,
    // editPassword,
    // editProfile,
    // deleteUser,
  },
  data() {
    return {
      tab: null,
      name: "",
      image: {},
      email: "",
      pas: {
        password: "",
        password_confirmation: "",
      },
    }
  },
  computed: {
    ...mapGetters({
      user: "auth/currentUser",
    }),
  },
  mounted() {
    const currentUser = this.$store.getters["auth/currentUser"]
    this.name = currentUser.name
    this.email = currentUser.email
    this.image = currentUser.image
  },
  methods: {
    async updateUser() {
      const formData = new FormData()
      formData.append("name", this.name)
      formData.append("email", this.email)
      if (this.image != "") {
        formData.append("image", this.image)
      }
      await this.$axios
        .put("api/v1/auth", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then((res) => {
          console.log(res)
          this.$store.commit("auth/setCurrentUser", res.data.data)
          this.$store.commit(
            "flashMessage/setMessage",
            "ユーザー情報を変更しました。",
            { root: true }
          )
          this.$store.commit("flashMessage/setType", "success", { root: true })
          this.$store.commit("flashMessage/setStatus", true, { root: true })
          setTimeout(() => {
            this.$store.commit("flashMessage/setStatus", false, { root: true })
          }, 4000)
          this.$router.push("/")
        })
        .catch(() => {
          this.$store.commit(
            "flashMessage/setMessage",
            "ユーザー情報の変更に失敗しました。",
            { root: true }
          )
          this.$store.commit("flashMessage/setType", "error", { root: true })
          this.$store.commit("flashMessage/setStatus", true, { root: true })
          setTimeout(() => {
            this.$store.commit("flashMessage/setStatus", false, { root: true })
          }, 4000)
        })
    },
    setImage(e) {
      this.image = e
    },
    editPassword() {
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
          this.$store.commit(
            "flashMessage/setMessage",
            "パスワードを変更しました。",
            { root: true }
          )
          this.$store.commit("flashMessage/setType", "success", { root: true })
          this.$store.commit("flashMessage/setStatus", true, { root: true })
          setTimeout(() => {
            this.$store.commit("flashMessage/setStatus", false, { root: true })
          }, 4000)
          this.$router.push("/")
        })
        .catch(() => {
          this.$store.commit(
            "flashMessage/setMessage",
            "パスワードの変更に失敗しました。",
            { root: true }
          )
          this.$store.commit("flashMessage/setType", "error", { root: true })
          this.$store.commit("flashMessage/setStatus", true, { root: true })
          setTimeout(() => {
            this.$store.commit("flashMessage/setStatus", false, { root: true })
          }, 4000)
        })
    },
    deleteUser() {
      this.$axios
        .delete("api/v1/auth", {
          headers: {
            "access-token": localStorage.getItem("access-token"),
            uid: localStorage.getItem("uid"),
            client: localStorage.getItem("client"),
          },
        })
        .then((res) => {
          this.$store.commit("auth/setCurrentUser", {})
          this.$store.commit("auth/setIsLoggedIn", false)
          this.$store.commit(
            "flashMessage/setMessage",
            "登録ユーザーを削除しました。",
            { root: true }
          )
          this.$store.commit("flashMessage/setType", "info", { root: true })
          this.$store.commit("flashMessage/setStatus", true, { root: true })
          setTimeout(() => {
            this.$store.commit("flashMessage/setStatus", false, { root: true })
          }, 4000)
          this.$router.push("/")
          console.log(res)
          return res
        })
        .catch((err) => {
          console.log(err)
          return err
        })
    },
  },
}
</script>
