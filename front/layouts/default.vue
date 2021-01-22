<template>
  <v-app>
    <the-header @toggle-drawer="$refs.drawer.drawer = !$refs.drawer.drawer" />
    <the-sidebar ref="drawer" />
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <the-footer />
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
    theFooter
  },
  data () {
  }
}
</script>
