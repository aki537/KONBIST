<template>
  <v-card flat>
    <v-list style="background-color: #fbfbfb">
      <v-card v-for="review in reviews" :key="review.id" flat class="mb-2">
        <food-review :review="review" />
      </v-card>
    </v-list>
  </v-card>
</template>

<script>
import foodReview from "~/components/FoodReview.vue"

export default {
  components: {
    foodReview,
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
