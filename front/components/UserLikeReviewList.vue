<template>
  <v-card min-height="500" flat class="px-2" style="background-color: #fbfbfb">
    <v-list style="background-color: #fbfbfb">
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
