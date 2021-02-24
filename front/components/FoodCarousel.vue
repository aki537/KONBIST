<template>
  <div>
    <v-row no-gutters class="mt-4 ml-16 tab" @click="pagelink(links.to)">
      <h3 class="font-weight-bold headline">おすすめ</h3>
      <v-icon right> mdi-chevron-right </v-icon>
    </v-row>
    <v-row class="mx-14">
      <swiper :options="swiperOption" class="pt-2">
        <swiper-slide v-for="food in foods" :key="food.id">
          <v-hover v-slot="{ hover }">
            <v-card
              class="ma-4"
              width="188px"
              :to="{ path: `/food/${food.id}` }"
              :elevation="hover ? 12 : 2"
              :class="{ 'on-hover': hover }"
            >
              <div class="grey lighten-2">
                <v-card-title
                  class="food-title overline text-center justify-center"
                >
                  {{ food.name }}
                </v-card-title>
              </div>
              <v-layout class="justify-center mt-2">
                <v-img
                  v-if="food.image.url"
                  height="130px"
                  width="130px"
                  contain
                  :src="food.image.url"
                />
                <v-img
                  v-else
                  height="130px"
                  width="130px"
                  contain
                  :src="defaultImage"
                />
              </v-layout>
            </v-card>
          </v-hover>
        </swiper-slide>
        <div slot="button-prev" class="swiper-button-prev"></div>
        <div slot="button-next" class="swiper-button-next"></div>
      </swiper>
    </v-row>
  </div>
</template>

<script>
export default {
  props: {
    foods: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      links: {
        to: "/users/create",
      },
      defaultImage: require("@/assets/images/default.png"),
      swiperOption: {
        slidesPerView: 5,
        slidesPerGroup: 5,
        freeMode: true,
        navigation: {
          nextEl: ".swiper-button-next",
          prevEl: ".swiper-button-prev",
        },
      },
    }
  },
  methods: {
    pagelink(link) {
      this.$router.push({ path: link })
    },
  },
}
</script>

<style scoped>
.food-title {
  font-size: 17px;
  height: 60px;
  padding: 0px 5px 0px;
}
.tab {
  cursor: pointer;
}
</style>
