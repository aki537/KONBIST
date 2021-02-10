<template>
  <v-app>
    <the-header @toggle-drawer="$refs.drawer.drawer = !$refs.drawer.drawer" />
    <the-sidebar ref="drawer" />
    <v-main>
      <flash-message />
      <nuxt />
    </v-main>
    <!-- <the-footer /> -->
  </v-app>
</template>

<script>
import theSidebar from "~/components/layout/TheSidebar.vue"
import theHeader from "~/components/layout/TheHeader.vue"
// import theFooter from "~/components/layout/TheFooter.vue"
import flashMessage from "~/components/layout/FlashMessage.vue"

export default {
  components: {
    theSidebar,
    theHeader,
    // theFooter,
    flashMessage,
  },
}
</script>

<style>
/* v-main {
  background-color: #e4f9f5;
} */
</style>
