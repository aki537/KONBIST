<template>
  <v-card class="pa-2">
    <div class="d-flex align-center">
      <nuxt-link :to="{ path: `/food/${review.food_id}` }">
        <v-avatar size="50" class="mr-3 my-4 small-image">
          <v-img
            v-if="review.food.image.url"
            :src="review.food.image.url"
            alt="avatar"
            contain
          />
          <v-img v-else :src="defaultImage" contain />
        </v-avatar>
      </nuxt-link>
      <nuxt-link :to="{ path: `/food/${review.food_id}` }">
        <span class="ml-2 body-2 black--text">
          {{ review.food.name }}
        </span>
      </nuxt-link>
    </div>
    <div class="d-flex align-center">
      <nuxt-link :to="{ path: `/users/${review.user_id}` }">
        <user-avatar :size="30" :user="review.user" />
      </nuxt-link>
      <nuxt-link :to="{ path: `/users/${review.user_id}` }">
        <span class="ml-2 body-2 black--text">
          {{ review.user.name }}
        </span>
      </nuxt-link>
    </div>
    <div class="d-flex align-center">
      <v-rating
        v-model="rating"
        background-color="orange lighten-1"
        color="orange darken-2"
        readonly
        half-increments
        dense
        small
      />
      <span class="ml-2 subtitle-1 font-weight-bold">
        {{ review.title }}
      </span>
    </div>
    <p class="review-content body-1 my-1">
      {{ review.content }}
    </p>
    <template v-if="review.image.url">
      <v-btn
        text
        small
        color="blue"
        class="font-weight-bold"
        @click="expand = !expand"
      >
        画像を表示
      </v-btn>
      <v-expand-transition>
        <v-img
          v-show="expand"
          :src="review.image.url"
          contain
          max-width="200px"
          max-height="200px"
        />
      </v-expand-transition>
    </template>
    <div class="d-flex align-center my-2">
      <template v-if="login">
        <v-btn
          v-if="like"
          color="red lighten-3 white--text font-weight-bold"
          class="mr-3"
          small
          @click="nice"
        >
          <v-icon small class="mr-1"> mdi-heart-plus </v-icon>
          いいねから外す
        </v-btn>
        <v-btn
          v-else
          color="pink white--text font-weight-bold"
          class="mr-3"
          small
          @click="nice"
        >
          <v-icon small class="mr-1"> mdi-heart-plus </v-icon>
          いいね！
        </v-btn>
        <div>
          <user-dialog-like
            :users="review.review_likes"
            :title="'口コミにいいねしたユーザー'"
          />
        </div>
        <!-- <v-btn
          color="cyan white--text font-weight-bold"
          class="ml-5 mr-3"
          small
        >
          <v-icon small class="mr-1"> mdi-comment-multiple </v-icon>
          コメント
          <span class="ml-1">(5)</span>
        </v-btn> -->
        <food-review-edit :review="review" />
        <food-review-delete :review="review" />
      </template>
      <v-spacer />
      <p class="review-content caption">投稿日: {{ createDate }}</p>
    </div>
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import foodReviewEdit from "~/components/FoodReviewEdit.vue"
import foodReviewDelete from "~/components/FoodReviewDelete.vue"
import userAvatar from "~/components/UserAvatar.vue"
import userDialogLike from "~/components/UserDialogLike.vue"

export default {
  components: {
    foodReviewEdit,
    foodReviewDelete,
    userAvatar,
    userDialogLike,
  },
  props: {
    review: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      createDate: "",
      rating: this.review.rate,
      expand: false,
      defaultImage: require("@/assets/images/default.png"),
      like: false,
    }
  },
  computed: {
    ...mapGetters({
      loginUser: "auth/loginUser",
      login: "auth/isLoggedIn",
    }),
    loginUserReview() {
      return this.$store.state.user.user
    },
  },
  watch: {
    loginUserReview() {
      // レビューにlike済みか確認
      if (this.login) {
        this.like = false
        this.review.review_likes.forEach((f) => {
          if (f.user_id === this.loginUser.id) {
            this.like = true
          }
        })
      }
    },
  },
  mounted() {
    this.createDate = this.$dayjs(this.review.created_at).format("YYYY/MM/DD")
    if (this.login) {
      this.like = false
      this.review.review_likes.forEach((f) => {
        if (f.user_id === this.loginUser.id) {
          this.like = true
        }
      })
    }
  },
  methods: {
    ...mapActions({
      likeReview: "review/likeReview",
      unLikeReview: "review/unLikeReview",
    }),
    nice() {
      const foodData = {
        user: this.$store.state.auth.loginUser.id,
        review: this.review.id,
      }
      if (this.like) {
        this.unLikeReview(foodData).then(() => {
          this.$axios
            .$get(`/api/v1/users/${this.$route.params.id}`)
            .then((res) => {
              this.$store.commit("user/setUser", res, { root: true })
              this.like = false
            })
        })
      } else {
        this.likeReview(foodData).then(() => {
          this.$axios
            .$get(`/api/v1/users/${this.$route.params.id}`)
            .then((res) => {
              this.$store.commit("user/setUser", res, { root: true })
              this.like = true
            })
        })
      }
    },
  },
}
</script>

<style scoped>
.review-content {
  margin-bottom: 0px;
}
.small-image {
  border: 1px solid;
  border-radius: 9px;
  border-color: #bdbdbd;
}
.small-image:hover {
  opacity: 0.7;
}
.arrow_box {
  position: relative;
  border: 1px solid black;
  padding: 5px 7px;
  color: #39c !important;
  text-decoration: underline !important;
  border-radius: 3px;
}
.arrow_box:after,
.arrow_box:before {
  right: 100%;
  top: 50%;
  border: solid transparent;
  content: "";
  height: 0;
  width: 0;
  position: absolute;
  pointer-events: none;
}

.arrow_box:after {
  border-color: rgba(136, 183, 213, 0);
  border-right-color: white;
  border-width: 6px;
  margin-top: -6px;
}
.arrow_box:before {
  border-color: rgba(194, 225, 245, 0);
  border-right-color: black;
  border-width: 7px;
  margin-top: -7px;
}
</style>
