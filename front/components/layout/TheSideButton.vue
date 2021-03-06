<template>
  <v-btn
    v-if="$store.state.auth.isLoggedIn"
    class="btn mt-1"
    fixed
    tile
    large
    icon
    rounded
    elevation="20"
    color="white"
    @click="openDrawer(!drawer)"
  >
    <v-icon v-if="drawer"> mdi-close </v-icon>
    <v-icon v-else x-large> mdi-chevron-right </v-icon>
  </v-btn>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  computed: {
    ...mapGetters({
      drawer: "choise/drawer",
    }),
  },
  methods: {
    ...mapActions({
      open: "choise/showDrawer",
    }),
    openDrawer(bol) {
      this.open(bol)
    },
  },
}
</script>

<style scoped>
.btn {
  z-index: 60;
  background-color: #212121;
}
</style>
