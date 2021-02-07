<template>
  <v-app-bar
    :clipped-left="clipped"
    fixed
    app
  >
    <v-app-bar-nav-icon @click.stop="$emit('toggle-drawer')"></v-app-bar-nav-icon>
    <nuxt-link to="/" class="link">
      <v-toolbar-title
        class="header-title"
        v-text="title" 
      />
    </nuxt-link>
    <v-spacer />
    <p>ログイン状態:{{ loggedIn }}</p>
    <v-btn icon>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>
    <template v-if="!loggedIn">
      <v-btn class="ml-5 mr-2" @click="pagelink(links[0].to)">
        新規登録
      </v-btn>
      <v-btn class="ml-4 mr-2" @click="pagelink(links[1].to)">
        ログイン
      </v-btn>
    </template>
    <template v-else>
      <header-avatar></header-avatar>
    </template>
  </v-app-bar>
</template>

<script>
import { mapGetters } from 'vuex'
import headerAvatar from '~/components/HeaderAvatar.vue'

export default {
  components: {
    headerAvatar
  },
  data() {
    return {
      clipped: true,
      drawer: null,
      fixed: false,
      title: 'KONBIST',
      links: [
        { to:"/users/signup"},
        { to:"/users/login"},
      ]
    }
  },
  computed: {
    ...mapGetters({
      loggedIn: 'auth/isLoggedIn',
    }),
  },
  methods: {
    pagelink(link){
      this.$router.push({ path: link })
    }
  }
}
</script>

<style>
.header-title {
  font-family: 'Fraunces', serif;
  font-size: 40px;
  color: #333333;
}
.link {
  text-decoration: none;
}
</style>