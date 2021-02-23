<template>
  <div>
    <v-card v-for="review in reviews" :key="review.id" class="mx-2 my-3">
      <div class="d-flex">
        <v-avatar size="30" class="ml-1" tile>
          <v-img :src="review.food.image.url" contain></v-img>
        </v-avatar>
        <nuxt-link :to="{ path: `/review/${review.food.id}` }">
          {{ review.food.name }}
        </nuxt-link>
      </div>
      <div classf="d-flex">
        <v-avatar size="30" class="ml-1">
          <v-img :src="review.user.image.url" conitain></v-img>
        </v-avatar>
        <nuxt-link :to="{ path: `/review/${review.user.id}` }">
          {{ review.user.name }}
        </nuxt-link>
      </div>
      <div classf="d-flex">
        {{ review.content }}
        <v-btn
          small
          color="red darken-3 white--text"
          @click="deleteReview(review.id)"
        >
          削除
        </v-btn>
      </div>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    reviews: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {}
  },
  methods: {
    deleteReview(id) {
      this.$axios
        .delete(`api/v1/reviews/${id}`)
        .then((res) => {
          console.log(res.data)
          console.log("投稿削除")
        })
        .catch((err) => {
          console.log(err)
        })
    },
  },
}
</script>
