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
                  <v-btn outlined color="blue">
                    <v-icon class="mr-2"> mdi-account-plus </v-icon>
                    フォロー
                  </v-btn>
                </div>
                <p class="subtitle-2 my-3">自己紹介文</p>
                <div class="following">
                  <p><span class="font-weight-bold">20</span>フォロー</p>
                  <p class="ml-3">
                    <span class="font-weight-bold">50</span>フォロワー
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
      <v-container class="px-13">
        <v-tabs-items v-model="tab">
          <v-tab-item>
            <user-review-list :reviews="user.reviews" />
          </v-tab-item>
          <v-tab-item>
            <food-list :foods="user.foodlike" />
          </v-tab-item>
          <v-tab-item>
            <user-review-list :reviews="user.reviews" />
          </v-tab-item>
          <v-tab-item>
            <food-list :foods="user.foodlike" />
          </v-tab-item>
        </v-tabs-items>
      </v-container>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import userAvatar from "~/components/UserAvatar.vue"
import foodList from "~/components/FoodList.vue"
import userReviewList from "~/components/UserReviewList.vue"

export default {
  name: "KONBIST",
  components: {
    userAvatar,
    foodList,
    userReviewList,
  },
  data() {
    return {
      // user: {},
      loading: false,
      tab: null,
      items: [
        {
          title: "今日の献立",
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
    ...mapGetters({ user: "user/user" }),
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
    })
  },
  methods: {
    // ...mapActions({
    //   getUser: "user/getUser",
    // }),
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
