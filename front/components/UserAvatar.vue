<template>
  <div>
    <template v-if="user.image.url !== defaultImage">
      <v-avatar :size="size" class="user-image">
        <v-img :src="user.image.url" alt="avatar" />
      </v-avatar>
    </template>
    <template v-else>
<<<<<<< Updated upstream
      <v-avatar :size="size" color="grey lighten-1">
=======
<<<<<<< Updated upstream
      <v-avatar
        :size="size"
        color="grey lighten-1"
      >
>>>>>>> Stashed changes
        <v-icon>mdi-account</v-icon>
=======
      <v-avatar :size="size">
        <v-img :src="icon" alt="avatar" />
>>>>>>> Stashed changes
      </v-avatar>
    </template>
  </div>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  props: {
    size: {
      type: Number,
      required: true,
    },
    user: {
      type: Object,
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
      required: true
=======
>>>>>>> Stashed changes
      required: true,
    },
  },
  data() {
    return {
      defaultImage: "http://localhost:3000/fallback/default.png",
<<<<<<< Updated upstream
=======
      icon: require("@/assets/images/default-user.png"),
>>>>>>> Stashed changes
>>>>>>> Stashed changes
    }
  },
  computed: {
    ...mapGetters({
      currentUser: "auth/currentUser",
    }),
  },
}
</script>

<style scoped>
.user-image {
  border: 1px solid;
  border-radius: 50%;
  border-color: #bdbdbd;
}
</style>
