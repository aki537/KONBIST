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
        @click.stop="signUpDialog = true"
        class="ml-5 mr-2"
      >
        新規登録
      </v-btn>
      <v-dialog v-model="signUpDialog" max-width="600px">
        <sign-up-modal 
          v-on:closeModal="closeSignUp"
          v-on:loginUser="openLogin"
        />
      </v-dialog>
      <v-btn
        @click.stop="loginDialog = true"
        class="ml-4 mr-2"
      >
        ログイン
      </v-btn>
      <v-dialog v-model="loginDialog" max-width="600px">
        <login-modal
          v-on:closeModal="closeLogin"
          v-on:newUser="openSignUp"
        />
      </v-dialog>
    </template>
    <template v-else>
      <header-avatar />
    </template>
  </v-app-bar>
</template>

<script>
import { mapGetters } from 'vuex'
import headerAvatar from '~/components/HeaderAvatar.vue'
import signUpModal from '~/components/SignUpModal.vue'
import loginModal from '~/components/LoginModal.vue'

export default {
  components: {
    headerAvatar,
    signUpModal,
    loginModal
  },
  data() {
    return {
      clipped: true,
      drawer: null,
      fixed: false,
      title: 'KONBIST',
      signUpDialog: false,
      loginDialog: false,
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
    openSignUp() {
      this.signUpDialog = true
    },
    closeSignUp() {
      this.signUpDialog = false
    },
    openLogin() {
      this.loginDialog = true
    },
    closeLogin() {
      this.loginDialog = false
    },
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