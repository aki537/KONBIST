<template>
  <div>
    <header-carousel />
    <template v-if="loading">
      <food-carousel :foods="foods1" :title="title[0]" class="mb-10 mt-7" />
      <food-ranking />
      <food-carousel :foods="foods1" :title="title[1]" class="mb-6" />
    </template>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex"
import headerCarousel from "~/components/HeaderCarousel.vue"
import foodCarousel from "~/components/FoodCarousel.vue"
import foodRanking from "~/components/FoodRanking.vue"

export default {
  name: "KONBIST",
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
      title: [
        {
          text: "おすすめ",
          link: "/ranking",
        },
        {
          text: "新発売",
          link: "/food/new",
        },
      ],
    }
  },
  computed: {
    ...mapGetters({ foods: "food/foods" }),
  },
  created() {
    this.getFoods().then(() => {
      this.foods1 = this.foods
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
.swiper {
  height: 300px;
}
</style>
