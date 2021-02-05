<template>
  <div>
    <header-carousel />
    <template v-if="loading">
      <food-carousel :foods="foods"/>
      <food-ranking />
    </template>
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
      foods1: [],
      foods2: [],
      foods3: [],
      foods4: [],
      loading: false,
      color: 'white',
      links: {
        to: "/users/create"
      }
    }
  },
  created () {
    this.getFoods()
    .then(() => {
      this.foods1 = this.foods.slice(0,5)
      this.loading = true
    });
    //   console.log(res);
    //   console.log(res.data);
    //   this.foods = res.data.slice(0,10)
    //   this.foods2 = res.data.slice(1,11)
    //   console.log(res.data);
    //   this.foods3 = res.data.slice(0,10)
    //   this.foods4 = res.data.slice(1,11)
    //   this.loading = true
    // })
  // mounted () {
  //   this.$axios.get('api/v1/foods')
  //   .then((res) => {
  //     console.log(res);
  //     console.log(res.data);
  //     this.foods = res.data.slice(0,10)
  //     this.foods2 = res.data.slice(1,11)
  //     console.log(res.data);
  //     this.foods3 = res.data.slice(0,10)
  //     this.foods4 = res.data.slice(1,11)
  //     this.loading = true
  //   })
  },
  computed: {
    ...mapGetters({ foods: 'food/foods'})
  },
  methods: {
    pagelink(link){
      this.$router.push({ path: link })
    },
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