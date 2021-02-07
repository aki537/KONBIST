<template>
  <div>
    <header-carousel />
    <template v-if="loading">
      <food-carousel :foods="foods"/>
      <food-ranking />
    </template>
    <v-container>
      <nuxtLink to="/food/create">
        food投稿ページへ
      </nuxtLink>
    </v-container>
    </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import headerCarousel from '~/components/HeaderCarousel.vue'
import foodCarousel from '~/components/FoodCarousel.vue'
import foodRanking from '~/components/FoodRanking.vue'

export default {
  layout: 'default',

  components: {
    foodCarousel,
    headerCarousel,
    foodRanking
  },
  data () {
    return {
      loading: false,
    }
  },
  created () {
    this.getFoods()
    .then(() => {
      this.foods1 = this.foods.slice(0,5)
      this.loading = true
    });
  },
  computed: {
    ...mapGetters({ foods: 'food/foods'})
  },
  methods: {
    ...mapActions({ getFoods: 'food/getFoods'})
  }
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