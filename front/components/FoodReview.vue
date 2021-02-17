<template>
  <v-card class="pa-2">
    <div class="d-flex align-center">
      <NuxtLink :to="{ path: `/users/${review.user_id}` }">
        <user-avatar :size="30" :user="review.user" />
      </NuxtLink>
      <NuxtLink :to="{ path: `/users/${review.user_id}` }">
        <span class="ml-2 body-2 black--text">
          {{ review.user.name }}
        </span>
      </NuxtLink>
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
      <v-btn color="pink white--text font-weight-bold" class="mr-3" small>
        <v-icon small class="mr-1"> mdi-heart-plus </v-icon>
        いいね！
      </v-btn>
      <div>
        <span class="arrow_box">5</span>
      </div>
      <v-btn color="cyan white--text font-weight-bold" class="ml-5 mr-3" small>
        <v-icon small class="mr-1"> mdi-comment-multiple </v-icon>
        コメント
        <span class="ml-1">(5)</span>
      </v-btn>
      <food-review-edit :review="review" />
      <food-review-delete :review="review" />
      <v-spacer />
      <p class="review-content caption">投稿日: {{ createDate }}</p>
    </div>
  </v-card>
</template>

<script>
import userAvatar from "~/components/UserAvatar.vue"
import foodReviewEdit from "~/components/FoodReviewEdit.vue"
import foodReviewDelete from "~/components/FoodReviewDelete.vue"

export default {
  components: {
    userAvatar,
    foodReviewEdit,
    foodReviewDelete,
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
    }
  },
  mounted() {
    this.createDate = this.$dayjs(this.review.created_at).format("YYYY/MM/DD")
  },
}
</script>

<style scoped>
.review-content {
  margin-bottom: 0px;
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
