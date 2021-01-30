<template>
  <div style="height: 4000px">
    <h1>HELLO.VUE</h1>
    <p>{{$store.state.auth.currentUser}}</p>
    <p v-if="$store.state.auth.isLoggedIn">
      <nuxtLink to="/food/create">
        food投稿ページへ
      </nuxtLink>
    </p>
  </div>
</template>

<script>
export default {
  auth: false,
  layout: 'default',
  // data () {

  // },
  // methods: {
  //   getMsg () {
  //     this.$axios.$get('/api/v1/hello')
  //       .then(res => this.msgs.push(res))
  //   }
  // }
}
</script>

<style>
h1 {
  font-family: 'Fraunces', serif;
}
</style>