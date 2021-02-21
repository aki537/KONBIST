<template>
  <v-card flat class="px-2">
    <v-list>
      <v-card v-for="review in reviews" :key="review.id" flat class="mb-2">
        <user-review :review="review" />
      </v-card>
    </v-list>
  </v-card>
</template>

<script>
import userReview from "~/components/userReview.vue"

export default {
  components: {
    userReview,
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
