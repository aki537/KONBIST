<template>
  <v-app>
    <the-header />
    <the-sidebar />
    <v-main>
      <the-side-button />
      <flash-message />
      <nuxt />
    </v-main>
    <!-- <the-footer /> -->
  </v-app>
</template>

<script>
import theSidebar from "~/components/layout/TheSidebar.vue"
import theHeader from "~/components/layout/TheHeader.vue"
import theSideButton from "~/components/layout/TheSideButton.vue"
// import theFooter from "~/components/layout/TheFooter.vue"
import flashMessage from "~/components/layout/FlashMessage.vue"

export default {
  components: {
    theSidebar,
    theHeader,
    theSideButton,
    // theFooter,
    flashMessage,
  },
}
</script>

<style>
/* v-main {
  background-color: #fbfbfb;
} */
.btn {
  position: fixed;
  z-index: 50;
}
</style>
