<template>
  <v-app>
    <the-header />
    <the-sidebar />
    <v-main style="background-color: #fbfbfb">
      <the-side-button />
      <food-message />
      <flash-message />
      <nuxt />
      <div style="background-color: #fbfbfb" class="pb-15" />
      <the-footer />
    </v-main>
  </v-app>
</template>

<script>
import theSidebar from "~/components/layout/TheSidebar.vue"
import theHeader from "~/components/layout/TheHeader.vue"
import theSideButton from "~/components/layout/TheSideButton.vue"
import theFooter from "~/components/layout/TheFooter.vue"
import flashMessage from "~/components/layout/FlashMessage.vue"
import foodMessage from "~/components/layout/FoodMessage.vue"

export default {
  components: {
    theSidebar,
    theHeader,
    theSideButton,
    theFooter,
    flashMessage,
    foodMessage,
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
