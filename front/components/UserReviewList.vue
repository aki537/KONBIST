<template>
  <v-card flat class="px-2" style="background-color: #fbfbfb">
    <v-list style="background-color: #fbfbfb">
      <v-card v-for="review in reviews" :key="review.id" flat class="pb-2">
        <user-review :review="review" />
      </v-card>
    </v-list>
  </v-card>
</template>

<script>
import userReview from "~/components/UserReview.vue"

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
