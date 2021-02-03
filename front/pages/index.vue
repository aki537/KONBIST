<template>
  <div>
    <div class="grey lighten-4 pt-6 px-4">
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
    
    <!-- <h1>HELLO.VUE</h1> -->
    <v-container>
    <template v-if="$store.state.auth.isLoggedIn">
      <p>{{$store.state.auth.currentUser}}</p>
      <!-- <p>{{$store.state.auth.currentUser.image}}</p> -->
      <v-img :src="$store.state.auth.currentUser.image.url"></v-img>
    </template>
      <nuxtLink to="/food/create">
        food投稿ページへ
      </nuxtLink>
      <ul v-for="food in foods" :key="food.id" >
        <li>
          {{ food }}
          <nuxtLink :to="{ path: `/food/${food.id}`}">
            詳細
          </nuxtLink>
          <v-img :src="food.image.url"></v-img>
        </li>
      </ul>
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
      ]
    }
  },
  mounted () {
    this.$axios.get('api/v1/foods')
    .then((res) => {
      console.log(res);
      console.log(res.data);
      this.foods = res.data
      // this.loading = true
    })
  },
  methods: {
    
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
</style>