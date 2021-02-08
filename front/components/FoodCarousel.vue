<template>
  <div>
    <v-row
      no-gutters 
      class="mt-4 ml-16 tab" 
      @click="pagelink(links.to)"
    >
      <h3 class="font-weight-bold headline">
        おすすめ
      </h3>
      <v-icon right>mdi-chevron-right</v-icon>
    </v-row>
    <v-slide-group
      class="px-4 mx-8 pt-2"
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
          width="188px"
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
</template>

<script>
export default {
  data () {
    return {
      links: {
        to: "/users/create"
      }
    }
  },
  props: ['foods'],
  methods: {
    pagelink(link){
      this.$router.push({ path: link })
    }
  }
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