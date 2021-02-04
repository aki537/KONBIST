<template>
  <div>
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
          >
            <v-row no-gutters>
              <v-col cols=7>
                <v-img :src='item.image' height="330"></v-img>
              </v-col>
              <v-col cols=5>
                <v-card
                  height="100%"
                  tile
                  flat
                  class="blue-grey--text text--darken-4 pt-16"
                  :color='color'
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
    <div v-if="loading">
      <v-row
        no-gutters 
        class="mt-10 ml-10 tab" 
        @click="pagelink(links.to)"
      >
        <h3 class="font-weight-bold headline">
          おすすめ
        </h3>
        <v-icon right>mdi-chevron-right</v-icon>
      </v-row>
      <v-slide-group
        class="pa-4"
        show-arrows
      >
        <v-slide-item
          v-for="food in foods" 
          :key="food.id"
        >
        <v-hover v-slot="{ hover }">
          <v-card
            class="ma-2" 
            height="200px"
            width="200px"
            :to="{ path: `/food/${food.id}`}"
            :elevation="hover ? 12 : 2"
            :class="{ 'on-hover': hover }"
          >
            <div class="grey lighten-2">
            <v-card-title class="food-title overline text-center justify-center">
              {{ food.name }}
            </v-card-title>
            </div>
            <v-layout class="justify-center mt-2">
              <v-img
                height="130px"
                width="130px"
                contain
                :src="food.image.url"
              />
            </v-layout>
          </v-card>
          </v-hover>
        </v-slide-item>
      </v-slide-group>
      <v-row
        no-gutters 
        class="mt-10 ml-10 tab" 
        @click="pagelink(links.to)"
      >
        <h3 class="font-weight-bold headline">
          ランキング
        </h3>
        <v-icon right>mdi-chevron-right</v-icon>
      </v-row>
      <v-slide-group
        class="pa-4"
        show-arrows
      >
        <v-slide-item
          v-for="food in foods" 
          :key="food.id"
        >
        <v-hover v-slot="{ hover }">
          <v-card
            class="ma-2" 
            height="200px"
            width="200px"
            :to="{ path: `/food/${food.id}`}"
            :elevation="hover ? 12 : 2"
            :class="{ 'on-hover': hover }"
          >
            <div class="grey lighten-2">
            <v-card-title class="food-title overline text-center justify-center">
              {{ food.name }}
            </v-card-title>
            </div>
            <v-layout class="justify-center mt-2">
              <v-img
                height="130px"
                width="130px"
                contain
                :src="food.image.url"
              />
            </v-layout>
          </v-card>
          </v-hover>
        </v-slide-item>
      </v-slide-group>
    </div>
    <v-container>
    <!-- <template v-if="$store.state.auth.isLoggedIn">
      <p>{{$store.state.auth.currentUser}}</p>
      <p>{{$store.state.auth.currentUser.image}}</p>
      <v-img :src="$store.state.auth.currentUser.image.url"></v-img>
    </template> -->
      <nuxtLink to="/food/create">
        food投稿ページへ
      </nuxtLink>
    </v-container>
    </div>
</template>

<script>
import Carousel from 'vue-carousel/src/Carousel.vue'
import Slide from 'vue-carousel/src/Slide.vue'

export default {
  components: { 
    Carousel,
    Slide
  },
  auth: false,
  layout: 'default',
  data () {
    return {
      foods: [],
      loading: false,
      color: 'white',
      headerItems: [
        { 
          image: require('@/assets/images/winter-image.jpg'),
          title: '冬のおすすめ',
          text: '冬の寒い時期におすすめの体温まる商品',
          to: '/topic/winter'
        },
        { 
          image: require('@/assets/images/manual-image.jpg'),
          title: '初めて使う方へ',
          text: 'KONBISTの使い方',
          to: '/manual'
        },
      ],
      links: {
        to: "/users/create"
      }
    }
  },
  mounted () {
    this.$axios.get('api/v1/foods')
    .then((res) => {
      console.log(res);
      console.log(res.data);
      this.foods = res.data
      this.loading = true
    })
  },
  methods: {
    pagelink(link){
      this.$router.push({ path: link })
    }
  }
}
</script>

<style>
.card-title {
  font-family: 'Noto Sans JP', sans-serif;
  font-size: 40px;
  font-weight: bold;
}
.card-text {
  font-family: 'Noto Sans JP', sans-serif;
  font-size: 18px;
}
.food-title {
  font-size: 17px;
  height: 60px;
  padding: 0px 5px 0px;
}
.tab {
  cursor: pointer;
}
</style>