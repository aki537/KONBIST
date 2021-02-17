<template>
  <div>
    <template v-if="user.image.url">
      <v-avatar :size="size" class="user-image">
        <v-img :src="user.image.url" alt="avatar" />
      </v-avatar>
    </template>
    <template v-else>
      <v-avatar :size="size">
        <v-img :src="icon" alt="avatar" />
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
      required: true,
    },
  },
  data() {
    return {
      icon: require("@/assets/images/default-user.png"),
    }
  },
  computed: {
    ...mapGetters({
      currentUser: "auth/currentUser",
    }),
  },
}
</script>

<style scoped></style>
