<template>
  <v-card class="pa-2">
    <div class="d-flex align-center">
      <user-avatar :size="30" :user="review.user" />
      <span class="ml-2 body-2">
        {{ review.user.name }}
      </span>
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
    <p class="review-content body-1">
      {{ review.content }}
    </p>
    <v-img v-if="review.image.url" :src="review.image.url" />
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
      <v-tooltip top>
        <template #activator="{ on, attrs }">
          <v-btn
            v-if="review.user_id === $store.state.auth.loginUser.id"
            v-bind="attrs"
            icon
            v-on="on"
          >
            <v-icon> mdi-comment-edit </v-icon>
          </v-btn>
        </template>
        <span>口コミ編集</span>
      </v-tooltip>
      <v-spacer />
      <p class="review-content caption">投稿日: {{ createDate }}</p>
    </div>
  </v-card>
</template>

<script>
import userAvatar from "~/components/UserAvatar.vue"

export default {
  components: {
    userAvatar,
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
