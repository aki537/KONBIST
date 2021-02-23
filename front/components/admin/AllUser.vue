<template>
  <div>
    <v-card v-for="user in users" :key="user.id" class="mx-2 my-3 d-flex">
      <v-avatar size="40" class="ml-1" tile>
        <v-img :src="user.image.url" contain></v-img>
      </v-avatar>
      <nuxt-link :to="{ path: `/user/${user.id}` }">
        <span class="mr-5">{{ user.name }}</span>
        <span>{{ user.email }}</span>
      </nuxt-link>
      <v-spacer />
      <v-btn small color="red darken-3 white--text" class="mr-16"> 削除 </v-btn>
    </v-card>
  </div>
</template>

<script>
export default {
  props: {
    users: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {}
  },
}
</script>
