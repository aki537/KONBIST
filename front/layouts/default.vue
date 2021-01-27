<template>
  <v-app>
    <template v-if="$auth.loggedIn">
      <login-header @toggle-drawer="$refs.drawer.drawer = !$refs.drawer.drawer" />
    </template>
    <template v-else>
      <the-header @toggle-drawer="$refs.drawer.drawer = !$refs.drawer.drawer" />
    </template>
    <the-sidebar ref="drawer" />
    <v-main>
      <nuxt />
    </v-main>
    <the-footer />
  </v-app>
</template>

<script>
import theSidebar from '~/components/layout/TheSidebar.vue'
import theHeader from '~/components/layout/TheHeader.vue'
import theFooter from '~/components/layout/TheFooter.vue'
import loginHeader from '~/components/layout/LoginHeader.vue'

export default {
  components: {
    theSidebar,
    theHeader,
    theFooter,
    loginHeader
  }
}
</script>
