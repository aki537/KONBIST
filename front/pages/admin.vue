<template>
  <v-container>
    <template v-if="isAdmin && isLoggedIn">
      <v-tabs v-model="tab" background-color="grey lighten-4" height="60">
        <v-tabs-slider></v-tabs-slider>
        <v-tab v-for="item in items" :key="item.title">
          {{ item.title }}
        </v-tab>
      </v-tabs>
      <v-row>
        <v-col cols="12">
          <v-tabs-items v-model="tab">
            <v-tab-item>
              <food-create />
            </v-tab-item>
            <v-tab-item>
              <all-food :foods="foods" />
            </v-tab-item>
            <v-tab-item>
              <all-review :reviews="reviews" />
            </v-tab-item>
            <v-tab-item>
              <all-user :users="users" />
            </v-tab-item>
          </v-tabs-items>
        </v-col>
      </v-row>
    </template>
    <template v-else>
      このページは表示できません
      <nuxt-link to="/">トップページヘ</nuxt-link>
    </template>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex"
import foodCreate from "~/components/admin/FoodCreate.vue"
import allFood from "~/components/admin/AllFood.vue"
import allUser from "~/components/admin/AllUser.vue"
import allReview from "~/components/admin/AllReview.vue"

export default {
  components: {
    foodCreate,
    allFood,
    allUser,
    allReview,
  },
  data() {
    return {
      tab: null,
      items: [
        { title: "フードクリエイト" },
        { title: "フード" },
        { title: "レビュー" },
        { title: "ユーザー" },
      ],
      users: [],
      foods: [],
      reviews: [],
    }
  },
  created() {
    this.$axios.get("api/v1/users").then((res) => {
      console.log(res.data)
      this.users = res.data
    })
    this.$axios.get("api/v1/foods").then((res) => {
      console.log(res.data)
      this.foods = res.data
    })
    this.$axios.get("api/v1/reviews").then((res) => {
      console.log(res.data)
      this.reviews = res.data
    })
  },
  computed: {
    ...mapGetters({
      isAdmin: "auth/isAdmin",
      isLoggedIn: "auth/isLoggedIn",
    }),
  },
  methods: {
    // async updateUser() {
    //   const formData = new FormData()
    //   formData.append("name", this.name)
    //   formData.append("email", this.email)
    //   if (this.image != "") {
    //     formData.append("image", this.image)
    //   }
    //   await this.$axios
    //     .put("api/v1/auth", formData, {
    //       headers: {
    //         "Content-Type": "multipart/form-data",
    //       },
    //     })
    //     .then((res) => {
    //       console.log(res)
    //       this.$store.commit("auth/setCurrentUser", res.data.data)
    //       this.$store.commit(
    //         "flashMessage/setMessage",
    //         "ユーザー情報を変更しました。",
    //         { root: true }
    //       )
    //       this.$store.commit("flashMessage/setType", "success", { root: true })
    //       this.$store.commit("flashMessage/setStatus", true, { root: true })
    //       setTimeout(() => {
    //         this.$store.commit("flashMessage/setStatus", false, { root: true })
    //       }, 4000)
    //       this.$router.push("/")
    //     })
    //     .catch(() => {
    //       this.$store.commit(
    //         "flashMessage/setMessage",
    //         "ユーザー情報の変更に失敗しました。",
    //         { root: true }
    //       )
    //       this.$store.commit("flashMessage/setType", "error", { root: true })
    //       this.$store.commit("flashMessage/setStatus", true, { root: true })
    //       setTimeout(() => {
    //         this.$store.commit("flashMessage/setStatus", false, { root: true })
    //       }, 4000)
    //     })
    // },
    // setImage(e) {
    //   this.image = e
    // },
    // editPassword() {
    //   this.$axios
    //     .put("api/v1/auth/password", this.pas, {
    //       headers: {
    //         "access-token": localStorage.getItem("access-token"),
    //         uid: localStorage.getItem("uid"),
    //         client: localStorage.getItem("client"),
    //       },
    //     })
    //     .then((res) => {
    //       console.log(res)
    //       this.$store.commit(
    //         "flashMessage/setMessage",
    //         "パスワードを変更しました。",
    //         { root: true }
    //       )
    //       this.$store.commit("flashMessage/setType", "success", { root: true })
    //       this.$store.commit("flashMessage/setStatus", true, { root: true })
    //       setTimeout(() => {
    //         this.$store.commit("flashMessage/setStatus", false, { root: true })
    //       }, 4000)
    //       this.$router.push("/")
    //     })
    //     .catch(() => {
    //       this.$store.commit(
    //         "flashMessage/setMessage",
    //         "パスワードの変更に失敗しました。",
    //         { root: true }
    //       )
    //       this.$store.commit("flashMessage/setType", "error", { root: true })
    //       this.$store.commit("flashMessage/setStatus", true, { root: true })
    //       setTimeout(() => {
    //         this.$store.commit("flashMessage/setStatus", false, { root: true })
    //       }, 4000)
    //     })
    // },
    // deleteUser() {
    //   this.$axios
    //     .delete("api/v1/auth", {
    //       headers: {
    //         "access-token": localStorage.getItem("access-token"),
    //         uid: localStorage.getItem("uid"),
    //         client: localStorage.getItem("client"),
    //       },
    //     })
    //     .then((res) => {
    //       this.$store.commit("auth/setCurrentUser", {})
    //       this.$store.commit("auth/setIsLoggedIn", false)
    //       this.$store.commit(
    //         "flashMessage/setMessage",
    //         "登録ユーザーを削除しました。",
    //         { root: true }
    //       )
    //       this.$store.commit("flashMessage/setType", "info", { root: true })
    //       this.$store.commit("flashMessage/setStatus", true, { root: true })
    //       setTimeout(() => {
    //         this.$store.commit("flashMessage/setStatus", false, { root: true })
    //       }, 4000)
    //       this.$router.push("/")
    //       console.log(res)
    //       return res
    //     })
    //     .catch((err) => {
    //       console.log(err)
    //       return err
    //     })
    // },
  },
}
</script>
