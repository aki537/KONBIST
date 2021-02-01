<template>
  <div style="height: 4000px">
    <nuxtLink to="/food/create">
      food投稿ページへ
    </nuxtLink>
    <div v-if="loading">
      <p>{{ food }}</p>
      <!-- <v-img :src="image" rel="preload"></v-img> -->
      <v-img :src="food.image.url"></v-img>
    </div>
  </div>
</template>

<script>
export default {
  auth: false,
  layout: 'default',
  data () {
    return {
      food: {},
      loading: false,
      image: {}
    }
  },
  created() {
    this.$axios.get(`api/v1/foods/${this.$route.params.id}`)
    .then((res) => {
      this.food = res.data
      console.log(res);
      console.log(res.data);
      // this.image = res.data.image.url
      this.loading = true
    })
  },
  methods: {
    
  }
}
</script>

<style>

</style>