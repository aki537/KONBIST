<template>
  <div>
    <v-row
      no-gutters 
      class="mt-10 ml-10 tab" 
      @click="pagelink(links.to)"
    >
      <h3 class="font-weight-bold headline ml-6 mb-3">
        ランキング TOP 100
      </h3>
      <v-icon right>mdi-chevron-right</v-icon>
    </v-row>
    <v-sheet max-width="100%" class="mx-10">
      <v-slide-group
        class=px-4
        show-arrows
        height="300px"
      >
        <food-slide-group :foods="foods1" :number="a"/>
        <food-slide-group :foods="foods2" :number="b"/>
        <food-slide-group :foods="foods3" :number="c"/>
        <food-slide-group :foods="foods4" :number="d"/>
      </v-slide-group>
    </v-sheet>
  </div>
</template>

<script>
import foodSlideGroup from '~/components/FoodSlideGroup.vue'
import { mapGetters } from 'vuex'

export default {
  layout: 'default',

  components: {
    foodSlideGroup
  },
  data () {
    return {
      foods1: [],
      foods2: [],
      foods3: [],
      foods4: [],
      a: 1,
      b: 11,
      c: 21,
      d: 31,
      links: {
        to: "/users/create"
      }
    }
  },
  mounted () {
    this.foods1 = this.foods.slice(0,10)
    this.foods2 = this.foods.slice(1,11)
    this.foods3 = this.foods.slice(0,10)
    this.foods4 = this.foods.slice(1,11)
  },
  computed: {
    ...mapGetters({ foods: 'food/foods'})
  },
  methods: {
    pagelink(link){
      this.$router.push({ path: link })
    }
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