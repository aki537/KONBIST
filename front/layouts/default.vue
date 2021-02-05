<template>
  <v-app >
    <the-header @toggle-drawer="$refs.drawer.drawer = !$refs.drawer.drawer" />
    <the-sidebar ref="drawer" />
    <v-main>
      <nuxt />
    </v-main>
    <!-- <the-footer /> -->
  </v-app>
</template>

<script>
import theSidebar from '~/components/layout/TheSidebar.vue'
import theHeader from '~/components/layout/TheHeader.vue'
import theFooter from '~/components/layout/TheFooter.vue'

export default {
  components: {
    theSidebar,
    theHeader,
    theFooter,
  }
}
</script>

<style>
/* v-main {
  background-color: #e4f9f5;
} */
</style>
