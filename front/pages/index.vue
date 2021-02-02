<template>
  <div style="height: 4000px">
    <h1>HELLO.VUE</h1>
    <template v-if="$store.state.auth.isLoggedIn">
      <p>{{$store.state.auth.currentUser}}</p>
      <!-- <p>{{$store.state.auth.currentUser.image}}</p> -->
      <v-img :src="$store.state.auth.currentUser.image.url"></v-img>
      <nuxtLink to="/food/create">
        food投稿ページへ
      </nuxtLink>
      <!-- <p>{{ imaging }}</p> -->
      <ul v-for="food in foods" :key="food.id">
        <li>
          {{ food }}
          <nuxtLink :to="{ path: `/food/${food.id}`}">
            詳細
          </nuxtLink>
          <v-img :src="food.image.url"></v-img>
        </li>
      </ul>
    </template>
  </div>
</template>

<script>
export default {
  auth: false,
  layout: 'default',
  data () {
    return {
      foods: [],
      // loading: false
    }
  },
  // methods: {
  //   getMsg () {
  //     this.$axios.$get('/api/v1/hello')
  //       .then(res => this.msgs.push(res))
  //   }
  // }
  created() {
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
h1 {
  font-family: 'Fraunces', serif;
}
</style>