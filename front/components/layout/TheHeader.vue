<template>
  <v-app-bar :clipped-left="clipped" app>
    <v-app-bar-nav-icon
      @click.stop="$emit('toggle-drawer')"
    ></v-app-bar-nav-icon>
    <nuxt-link to="/" class="link">
      <v-toolbar-title class="header-title" v-text="title" />
    </nuxt-link>
    <v-tabs v-model="tab" align-with-title>
      <v-tabs-slider></v-tabs-slider>

      <v-tab v-for="item in items" :key="item.title" :to="item.to">
        {{ item.title }}
      </v-tab>
    </v-tabs>
    <v-spacer />
    <div class="mt-6 mr-2 search-form">
      <v-text-field
        :value="search"
        label="検索..."
        prepend-inner-icon="mdi-magnify"
        solo
        rounded
      />
    </div>
    <template v-if="!loggedIn">
<<<<<<< Updated upstream
      <v-btn class="ml-4 mr-2" @click.stop="loginDialog = true">
=======
<<<<<<< Updated upstream
      <v-btn
        @click.stop="loginDialog = true"
        class="ml-4 mr-2"
      >
>>>>>>> Stashed changes
        ログイン
      </v-btn>
      <v-dialog v-model="loginDialog" max-width="600px">
        <login-modal @closeModal="closeLogin" @newUser="openSignUp" />
      </v-dialog>
      <v-btn
        class="ml-4 mr-2"
        color="green  white--text font-weight-bold"
        @click.stop="signUpDialog = true"
      >
        新規登録
      </v-btn>
      <v-dialog v-model="signUpDialog" max-width="600px">
<<<<<<< Updated upstream
        <sign-up-modal @closeModal="closeSignUp" @loginUser="openLogin" />
=======
        <sign-up-modal 
          v-on:closeModal="closeSignUp"
          v-on:loginUser="openLogin"
        />
=======
      <v-btn class="ml-4 mr-2" @click.stop="loginDialog(true)">ログイン</v-btn>
      <v-dialog v-model="loginModal" max-width="600px">
        <login-modal />
      </v-dialog>
      <v-btn
        class="ml-4 mr-2"
        color="green  white--text font-weight-bold"
        @click.stop="signUpDialog(true)"
      >
        新規登録
      </v-btn>
      <v-dialog v-model="signUpModal" max-width="600px">
        <sign-up-modal />
>>>>>>> Stashed changes
>>>>>>> Stashed changes
      </v-dialog>
    </template>
    <template v-else>
      <!-- <v-btn
        icon
        class="ml-4"
      >
        <v-badge
          dot
          content="1"
          bordered
          overlap
        >
          <v-icon>mdi-bell-outline</v-icon>
        </v-badge>
      </v-btn> -->
      <header-avatar />
    </template>
  </v-app-bar>
</template>

<script>
<<<<<<< Updated upstream
import { mapGetters } from "vuex"
=======
<<<<<<< Updated upstream
import { mapGetters } from 'vuex'
import headerAvatar from '~/components/HeaderAvatar.vue'
import signUpModal from '~/components/SignUpModal.vue'
import loginModal from '~/components/LoginModal.vue'
import searchForm from '~/components/SearchForm.vue'
=======
import { mapGetters, mapActions } from "vuex"
>>>>>>> Stashed changes
import headerAvatar from "~/components/HeaderAvatar.vue"
import signUpModal from "~/components/SignUpModal.vue"
import loginModal from "~/components/LoginModal.vue"
// import searchForm from "~/components/SearchForm.vue"
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
>>>>>>> Stashed changes

export default {
  components: {
    headerAvatar,
    signUpModal,
    loginModal,
    // searchForm,
  },
  data() {
    return {
      clipped: true,
      drawer: null,
      fixed: true,
<<<<<<< Updated upstream
      title: "KONBIST",
      signUpDialog: false,
      loginDialog: false,
      links: [{ to: "/users/signup" }, { to: "/users/login" }],
=======
<<<<<<< Updated upstream
      title: 'KONBIST',
      signUpDialog: false,
      loginDialog: false,
      links: [
        { to:"/users/signup"},
        { to:"/users/login"},
      ],
=======
      title: "KONBIST",
      links: [{ to: "/users/signup" }, { to: "/users/login" }],
>>>>>>> Stashed changes
>>>>>>> Stashed changes
      search: null,
      tab: null,
      items: [
        {
          title: "ホーム",
          to: "/",
        },
        {
          title: "ランキング",
          to: "/ranking",
        },
        {
          title: "カテゴリ",
          to: "/category",
        },
        {
          title: "新商品",
          to: "/new_item",
        },
        {
          title: "使い方",
          to: "/gaidorain",
        },
      ],
    }
  },
  computed: {
    ...mapGetters({
<<<<<<< Updated upstream
      loggedIn: "auth/isLoggedIn",
=======
<<<<<<< Updated upstream
      loggedIn: 'auth/isLoggedIn',
>>>>>>> Stashed changes
    }),
  },
  methods: {
    pagelink(link) {
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
<<<<<<< Updated upstream
  },
=======
  }
=======
      loggedIn: "auth/isLoggedIn",
      loginModal: "modal/loginModal",
      signUpModal: "modal/signUpModal",
    }),
  },
  methods: {
    ...mapActions({
      loginDialog: "modal/loginUser",
      signUpDialog: "modal/signUpUser",
    }),
    pagelink(link) {
      this.$router.push({ path: link })
    },
  },
>>>>>>> Stashed changes
>>>>>>> Stashed changes
}
</script>

<style>
.header-title {
  font-family: "Fraunces", serif;
  font-size: 35px;
  color: #333333;
}
.link {
  text-decoration: none;
}
.search-form {
  width: 500px;
}
</style>
