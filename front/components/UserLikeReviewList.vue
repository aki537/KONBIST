<template>
  <v-card flat>
    <v-list>
      <v-card v-for="review in reviews" :key="review.id" flat class="mb-2">
        <user-like-review :review="review" />
      </v-card>
    </v-list>
  </v-card>
</template>

<script>
import userLikeReview from "~/components/userLikeReview.vue"

export default {
  components: {
    userLikeReview,
  },
  props: {
    reviews: {
      type: Array,
      required: true,
    },
  },
}
</script>

<style scoped></style>
