<template>
  <div>
    <v-card v-for="food in foods" :key="food.id" class="mx-2 my-3 d-flex">
      <v-avatar size="40" class="ml-1" tile>
        <v-img :src="food.image.url" contain></v-img>
      </v-avatar>
      <nuxt-link :to="{ path: `/food/${food.id}` }">
        {{ food.name }}
      </nuxt-link>
      <v-spacer />
      <v-btn small> トピック </v-btn>
      <v-btn small> 編集 </v-btn>
      <v-btn small color="red darken-3 white--text"> 削除 </v-btn>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    foods: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {}
  },
}
</script>
