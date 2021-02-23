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
  computed: {
    ...mapGetters({
      isAdmin: "auth/isAdmin",
      isLoggedIn: "auth/isLoggedIn",
    }),
  },
  created() {
    this.$axios.get("api/v1/users").then((res) => {
      console.log(res.data)
      this.users = res.data
    })
    this.$axios.get("api/v1/allfood").then((res) => {
      console.log(res.data)
      this.foods = res.data
    })
    this.$axios.get("api/v1/reviews").then((res) => {
      console.log(res.data)
      this.reviews = res.data
    })
  },
  methods: {},
}
</script>
