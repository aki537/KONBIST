<template>
  <div class="mx-6">
    <v-row no-gutters class="mt-4 ml-16 tab" @click="pagelink(title.link)">
      <h3 class="font-weight-bold headline">{{ title.text }}</h3>
      <v-icon right> mdi-chevron-right </v-icon>
    </v-row>
    <v-row class="mx-14">
      <swiper :options="swiperOption" class="pt-2">
        <swiper-slide v-for="f in foods" :key="f.id">
          <v-hover v-slot="{ hover }">
            <v-card
              class="ma-4 pb-2"
              width="188px"
              :to="{ path: `/food/${f.food.id}` }"
              :elevation="hover ? 12 : 2"
              :class="{ 'on-hover': hover }"
            >
              <div style="background-color: #eeeeee">
                <v-card-title
                  class="food-title caption text-center justify-center font-weight-bold"
                >
                  {{ f.food.name }}
                </v-card-title>
              </div>
              <v-layout class="justify-center mt-2">
                <v-img
                  v-if="f.food.image.url"
                  height="130px"
                  width="130px"
                  contain
                  :src="f.food.image.url"
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
    title: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
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
      this.$store.dispatch("topic/getTab", 0)
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
