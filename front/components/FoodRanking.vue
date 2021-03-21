<template>
  <div class="mx-6">
    <v-row no-gutters class="mt-10 ml-10 mb-2 tab" @click="pagelink(links.to)">
      <h3 class="font-weight-bold headline ml-6">全体ランキング</h3>
      <v-icon right> mdi-chevron-right </v-icon>
    </v-row>
    <v-sheet max-width="100%" class="mx-10" style="background-color: #fbfbfb">
      <swiper :options="swiperOption" class="mx-6">
        <swiper-slide>
          <food-slide-group :foods="foods1" :number="a" />
        </swiper-slide>
        <swiper-slide>
          <food-slide-group :foods="foods2" :number="b" />
        </swiper-slide>
        <swiper-slide>
          <food-slide-group :foods="foods3" :number="c" />
        </swiper-slide>
        <swiper-slide>
          <food-slide-group :foods="foods4" :number="d" />
        </swiper-slide>
        <swiper-slide class="mb-13">
          <food-slide-group :foods="foods5" :number="e" />
        </swiper-slide>
        <div slot="pagination" class="swiper-pagination"></div>
        <div slot="button-prev" class="swiper-button-prev"></div>
        <div slot="button-next" class="swiper-button-next"></div>
      </swiper>
    </v-sheet>
  </div>
</template>

<script>
import foodSlideGroup from "~/components/FoodSlideGroup.vue"

export default {
  components: {
    foodSlideGroup,
  },
  layout: "default",
  props: {
    foods: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      foods1: [],
      foods2: [],
      foods3: [],
      foods4: [],
      foods5: [],
      a: 1,
      b: 11,
      c: 21,
      d: 31,
      e: 41,
      links: {
        to: "/ranking",
      },
      swiperOption: {
        slidesPerView: 2,
        slidesPerGroup: 2,
        pagination: {
          el: ".swiper-pagination",
          clickable: true,
        },
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
      },
    }
  },
  created() {
    this.foods1 = this.foods.slice(0, 10)
    this.foods2 = this.foods.slice(10, 20)
    this.foods3 = this.foods.slice(20, 30)
    this.foods4 = this.foods.slice(30, 40)
    this.foods5 = this.foods.slice(40, 50)
  },
  methods: {
    pagelink(link) {
      this.$store.dispatch("tab/getRankingTab", 0)
      this.$router.push({ path: link })
    },
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
