<template>
  <div>
    <header-carousel />
    <template v-if="loading">
      <food-carousel :foods="foods1" />
      <food-ranking />
    </template>
    <v-container>
      <nuxtLink to="/food/create"> food投稿ページへ </nuxtLink>
    </v-container>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex"
import headerCarousel from "~/components/HeaderCarousel.vue"
import foodCarousel from "~/components/FoodCarousel.vue"
import foodRanking from "~/components/FoodRanking.vue"

export default {
  components: {
    foodCarousel,
    headerCarousel,
    foodRanking,
  },
  layout: "default",
  data() {
    return {
      loading: false,
      foods1: [],
    }
  },
  computed: {
    ...mapGetters({ foods: "food/foods" }),
  },
  created() {
    this.getFoods().then(() => {
      this.foods1 = this.foods.slice(0, 8)
      this.loading = true
    })
  },
  methods: {
    ...mapActions({ getFoods: "food/getFoods" }),
  },
}
</script>

<style>
.tab {
  cursor: pointer;
}
.list-item {
  width: 100px;
}
</style>
