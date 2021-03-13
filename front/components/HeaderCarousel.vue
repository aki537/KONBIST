<template>
  <div class="grey lighten-3 pt-6 px-4">
    <v-container>
      <v-carousel
        height="380"
        width="500"
        show-arrows-on-hover
        hide-delimiter-background
        cycle
        light
      >
        <v-carousel-item
          v-for="(item, index) in headerItems"
          :key="index"
          :to="item.to"
          :ripple="false"
          @click="pagelink(item.to)"
          class="carousel"
        >
          <v-row no-gutters>
            <v-col cols="7">
              <v-img :src="item.image" height="330"></v-img>
            </v-col>
            <v-col cols="5">
              <v-card
                height="100%"
                tile
                flat
                class="blue-grey--text text--darken-4 pt-16"
                :color="color"
                align="center"
                :ripple="{ center: true }"
              >
                <v-card-title class="justify-center pt-13 card-title">
                  {{ item.title }}
                </v-card-title>
                <v-card-text class="blue-grey--text text--darken-4 card-text">
                  {{ item.text }}
                </v-card-text>
              </v-card>
            </v-col>
          </v-row>
        </v-carousel-item>
      </v-carousel>
    </v-container>
  </div>
</template>

<script>
import { mapActions } from "vuex"

export default {
  auth: false,
  layout: "default",
  data() {
    return {
      color: "white",
      headerItems: [
        {
          image:
            "https://konbist-image.s3-ap-northeast-1.amazonaws.com/images/winter-image.jpg",
          title: "冬のおすすめ",
          text: "冬の寒い時期におすすめの体温まる商品",
          to: "/topic",
        },
        {
          image:
            "https://konbist-image.s3-ap-northeast-1.amazonaws.com/images/manual-image.jpg",
          title: "初めて使う方へ",
          text: "KONBISTの使い方",
          to: "/about",
        },
      ],
    }
  },
  methods: {
    ...mapActions({ setTab: "topic/getTab" }),
    pagelink(link) {
      if (link == "/topic") {
        this.setTab(1)
      }
    },
  },
}
</script>

<style scoped>
.card-title {
  font-family: "Noto Sans JP", sans-serif;
  font-size: 40px;
  font-weight: bold;
}
.card-text {
  font-family: "Noto Sans JP", sans-serif;
  font-size: 18px;
}
.carousel {
  cursor: pointer;
}
</style>
