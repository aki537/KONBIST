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
      <v-btn
        @click.stop="dialog = true"
        class="ml-5 mr-2"
      >
        新規登録
      </v-btn>
      <v-dialog v-model="dialog" max-width="600px">
        <sign-up-modal v-on:closeModal="closeEvent"></sign-up-modal>
      </v-dialog>
      <!-- <v-btn class="ml-5 mr-2" @click="pagelink(links[0].to)">
        新規登録
      </v-btn> -->
      <!-- <v-btn
        @click.stop="dialog = true"
        class="ml-4 mr-2"
      >
        ログイン
      </v-btn> -->
      <!-- <v-dialog v-model="signUpdialog" max-width="600px"> -->
        <!-- <signup-modal v-on:closeModal="closeEvent"></signup-modal> -->
      <!-- </v-dialog> -->
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
import signUpModal from '~/components/SignUpModal.vue'

export default {
  components: {
    headerAvatar,
    signUpModal
  },
  data() {
    return {
      clipped: true,
      drawer: null,
      fixed: false,
      title: 'KONBIST',
      dialog: false,
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
    },
    closeEvent() {
      this.dialog = false
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