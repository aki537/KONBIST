<template>
  <div>
    <header-carousel />
    <food-carousel :foods="foods1" :title="title[0]" class="mb-10 mt-7" />
    <food-ranking v-if="loading" :foods="totalRank" />
    <food-carousel :foods="newFoods" :title="title[1]" class="pb-6" />
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
      goodFood: [],
      title: [
        {
          text: "おすすめ",
          link: "/topic",
        },
        {
          text: "新発売",
          link: "/food/new",
        },
      ],
      newFoods: [],
    }
  },
  computed: {
    ...mapGetters({ foods: "food/foods" }),
    totalRank() {
      return this.foods
        .slice()
        .sort((a, b) => {
          if (a.avg_rate < b.avg_rate) return 1
          if (a.avg_rate > b.avg_rate) return -1
          if (a.like_users.length < b.like_users.length) return 1
          if (a.like_users.length > b.like_users.length) return -1
          return 0
        })
        .slice(0, 50)
    },
  },
  created() {
    this.getFoods().then(() => {
      this.foods1 = this.foods.slice(0, 20)
      this.loading = true
    })
    this.$axios.get("api/v1/new_food").then((res) => {
      console.log(res.data)
      this.newFoods = res.data.slice(0, 20)
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
