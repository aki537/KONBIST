<template>
  <div>
    <template v-if="loading">
      <v-card class="grey lighten-4 pt-6">
        <v-container class="grey lighten-4 px-13 top-card">
          <v-row class="mx-1" no-gutters>
            <v-col cols="2" class="text-center">
              <user-avatar :size="105" :user="user" />
            </v-col>
            <v-col cols="10">
              <v-sheet class="grey lighten-4 ml-2b mb-13">
                <div class="user-name mt-3">
                  <h2 class="display-1">
                    {{ user.name }}
                  </h2>
                  <template v-if="loginUser && loginUser.id !== user.id">
                    <v-btn
                      v-if="follow"
                      rounded
                      min-width="125px"
                      :color="color"
                      class="font-weight-bold"
                      @click="unfollowUser"
                      @mouseover="mouseover"
                      @mouseleave="mouseleave"
                    >
                      {{ message }}
                    </v-btn>
                    <v-btn
                      v-else
                      rounded
                      min-width="125px"
                      outlined
                      color="blue"
                      @click="followUser"
                    >
                      <v-icon class="mr-2"> mdi-account-plus </v-icon>
                      フォロー
                    </v-btn>
                  </template>
                </div>
                <p class="subtitle-2 my-3">自己紹介文</p>
                <div class="following">
                  <p>
                    <span class="font-weight-bold">
                      {{ user.followings.length }}
                    </span>
                    フォロー
                  </p>
                  <p class="ml-3">
                    <span class="font-weight-bold">
                      {{ user.followers.length }}
                    </span>
                    フォロワー
                  </p>
                </div>
              </v-sheet>
            </v-col>
          </v-row>
          <v-divider />
          <v-tabs v-model="tab" background-color="grey lighten-4" height="60">
            <v-tabs-slider></v-tabs-slider>

            <v-tab v-for="item in items" :key="item.title">
              {{ item.title }}
            </v-tab>
          </v-tabs>
        </v-container>
      </v-card>
    </template>
    <v-container class="px-13">
      <v-row>
        <v-col cols="12">
          <v-tabs-items v-model="tab">
            <v-tab-item>
              <user-menu-list :menus="user.menus" />
            </v-tab-item>
            <v-tab-item>
              <food-list :foods="user.foodlike" />
            </v-tab-item>
            <v-tab-item>
              <user-review-list :reviews="user.reviews" />
            </v-tab-item>
            <v-tab-item>
              <user-like-review-list :reviews="user.like_reviews" />
            </v-tab-item>
            <v-tab-item>
              <user-list :users="user.followings" />
            </v-tab-item>
            <v-tab-item>
              <user-list :users="user.followers" />
            </v-tab-item>
          </v-tabs-items>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import userAvatar from "~/components/UserAvatar.vue"
import foodList from "~/components/FoodList.vue"
import userList from "~/components/UserList.vue"
import userReviewList from "~/components/UserReviewList.vue"
import userLikeReviewList from "~/components/UserLikeReviewList.vue"
import userMenuList from "~/components/UserMenuList.vue"

export default {
  name: "KONBIST",
  components: {
    userAvatar,
    foodList,
    userList,
    userReviewList,
    userLikeReviewList,
    userMenuList,
  },
  data() {
    return {
      // user: {},
      loading: false,
      tab: null,
      follow: false,
      message: "フォロー中",
      color: "blue white--text",
      items: [
        {
          title: "献立",
        },
        {
          title: "食べたい！",
        },
        {
          title: "投稿した口コミ",
        },
        {
          title: "いいねした口コミ",
        },
        {
          title: "フォロー",
        },
        {
          title: "フォロワー",
        },
      ],
    }
  },
  computed: {
    ...mapGetters({
      user: "user/user",
      loginUser: "auth/loginUser",
    }),
    userUpdate() {
      return this.$store.state.food.food
    },
  },
  watch: {
    userUpdate() {
      // フード再取得時にユーザーを更新
      this.$axios.get(`api/v1/users/${this.$route.params.id}`).then((res) => {
        this.$store.commit("user/setUser", res.data, { root: true })
        console.log(res.data)
      })
    },
  },
  created() {
    this.$axios.get(`api/v1/users/${this.$route.params.id}`).then((res) => {
      this.$store.commit("user/setUser", res.data, { root: true })
      console.log(res.data)
      this.loading = true
      if (this.loginUser) {
        this.follow = false
        this.user.followers.forEach((f) => {
          if (f.id === this.loginUser.id) {
            this.follow = true
          }
        })
      }
    })
  },
  methods: {
    mouseover() {
      this.color = "red white--text"
      this.message = "フォロー解除"
    },
    mouseleave() {
      this.color = "blue white--text"
      this.message = "フォロー中"
    },
    followUser() {
      this.$axios
        .post("/api/v1/relationships", {
          user_id: this.loginUser.id,
          follow_id: this.user.id,
        })
        .then(() => {
          this.$store.commit("flashMessage/setMessage", " フォローしました。", {
            root: true,
          })
          this.$store.commit("flashMessage/setType", "success", { root: true })
          this.$store.commit("flashMessage/setStatus", true, { root: true })
          setTimeout(() => {
            this.$store.commit("flashMessage/setStatus", false, { root: true })
          }, 1000)
          this.$axios.get(`api/v1/users/${this.user.id}`).then((res) => {
            console.log(res.data)
            this.$store.commit("user/setUser", res.data, { root: true })
            this.follow = true
            this.$axios.get(`api/v1/users/${this.loginUser.id}`).then((res) => {
              console.log(res.data)
              this.$store.commit("auth/setLoginUser", res.data, { root: true })
            })
          })
        })
        .catch((err) => {
          console.log(err)
        })
    },
    unfollowUser() {
      this.$axios
        .delete("/api/v1/relationships", {
          params: {
            user_id: this.loginUser.id,
            follow_id: this.user.id,
          },
        })
        .then(() => {
          this.$store.commit(
            "flashMessage/setMessage",
            " フォロー解除しました。",
            { root: true }
          )
          this.$store.commit("flashMessage/setType", "info", { root: true })
          this.$store.commit("flashMessage/setStatus", true, { root: true })
          setTimeout(() => {
            this.$store.commit("flashMessage/setStatus", false, { root: true })
          }, 1000)
          this.$axios.get(`api/v1/users/${this.user.id}`).then((res) => {
            console.log(res.data)
            this.$store.commit("user/setUser", res.data, { root: true })
            this.follow = false
            this.$axios.get(`api/v1/users/${this.loginUser.id}`).then((res) => {
              console.log(res.data)
              this.$store.commit("auth/setLoginUser", res.data, { root: true })
            })
          })
        })
        .catch((err) => {
          console.log(err)
        })
    },
  },
}
</script>

<style scoped>
.user-image {
  border: 1px solid;
  border-radius: 9px;
  border-color: #bdbdbd;
}
.user-name {
  display: flex;
  justify-content: space-between;
}
.following {
  display: flex;
}
.v-application p {
  margin-bottom: 0px;
}
.container {
  padding-bottom: 0px;
}
</style>
