<template>
  <div>
    <v-card v-for="user in users" :key="user.id" class="mx-2 my-3 d-flex">
      <v-avatar size="40" class="ml-1" tile>
        <v-img :src="user.image.url" contain></v-img>
      </v-avatar>
      <nuxt-link :to="{ path: `/user/${user.id}` }">
        <span class="mr-5 ml-2">{{ user.name }}</span>
        <span>{{ user.email }}</span>
      </nuxt-link>
      <v-spacer />
      <v-btn
        small
        color="red darken-3 white--text"
        class="mr-16"
        @click="deleteUser(user.id)"
      >
        削除
      </v-btn>
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
  methods: {
    deleteUser(id) {
      this.$axios
        .delete(`api/v1/users/${id}`)
        .then((res) => {
          console.log(res.data)
          console.log("ユーザー削除")
        })
        .catch((err) => {
          console.log(err)
        })
    },
  },
}
</script>
