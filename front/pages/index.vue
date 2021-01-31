<template>
  <div style="height: 4000px">
    <h1>HELLO.VUE</h1>
    <p>{{$store.state.auth.currentUser}}</p>
    <p v-if="$store.state.auth.isLoggedIn">
      <nuxtLink to="/food/create">
        food投稿ページへ
      </nuxtLink>
      <ul>
        <li v-for="food in foods" :key="food.name">
          {{ food }}
        </li>
      </ul>
    </p>
  </div>
</template>

<script>
export default {
  auth: false,
  layout: 'default',
  data () {
    return {
      foods: {}
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