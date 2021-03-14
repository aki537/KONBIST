<template>
  <div v-if="login">
    <template v-if="loginUser.id !== user.id">
      <v-btn
        v-if="follow"
        min-width="125px"
        rounded
        :color="color"
        class="font-weight-bold follow"
        @click="unfollowUser"
        @mouseover="mouseover"
        @mouseleave="mouseleave"
      >
        {{ message }}
      </v-btn>
      <v-btn
        v-else
        min-width="125px"
        rounded
        outlined
        color="blue"
        @click="followUser"
      >
        <v-icon class="mr-2"> mdi-account-plus </v-icon>
        フォロー
      </v-btn>
    </template>
  </div>
</template>

<script>
import { mapGetters } from "vuex"
// import userAvatar from "~/components/UserAvatar.vue"

export default {
  components: {
    // userAvatar,
  },
  props: {
    user: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      icon: require("@/assets/images/default-user.png"),
      follow: false,
      message: "フォロー中",
      color: "blue white--text",
    }
  },
  computed: {
    ...mapGetters({
      loginUser: "auth/loginUser",
      login: "auth/isLoggedIn",
      watchUser: "user/user",
    }),
    loginUserFollow() {
      return this.$store.state.auth.loginUser
    },
  },
  watch: {
    loginUserFollow() {
      if (this.login) {
        this.follow = false
        this.loginUser.followings.forEach((f) => {
          if (this.user.id === f.id) {
            this.follow = true
          }
        })
      }
    },
  },
  mounted() {
    if (this.login) {
      this.follow = false
      this.loginUser.followings.forEach((f) => {
        if (this.user.id === f.id) {
          this.follow = true
        }
      })
    }
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
          this.$axios.get(`api/v1/users/${this.watchUser.id}`).then((res) => {
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
          this.$axios.get(`api/v1/users/${this.watchUser.id}`).then((res) => {
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

<style scoped></style>
