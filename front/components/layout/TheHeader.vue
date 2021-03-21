<template>
  <v-app-bar :clipped-left="clipped" app dark>
    <nuxt-link to="/" class="link">
      <v-toolbar-title class="header-title">KONBIST</v-toolbar-title>
    </nuxt-link>
    <v-tabs v-model="tab" align-with-title hide-slider>
      <v-tabs-slider />

      <v-tab
        v-for="item in items"
        :key="item.title"
        :to="item.to"
        @click="pagelink(item.to)"
      >
        <span class="font-weight-bold">{{ item.title }}</span>
      </v-tab>
    </v-tabs>
    <v-spacer />
    <!-- <div class="mt-6 mr-2 search-form">
      <v-text-field
        :value="search"
        label="検索..."
        prepend-inner-icon="mdi-magnify"
        solo
        rounded
      />
    </div> -->
    <v-btn class="ml-3" icon @click="link('search')">
      <v-icon> mdi-magnify </v-icon>
    </v-btn>
    <template v-if="!loggedIn">
      <v-btn
        text
        class="ml-4 mr-2 font-weight-bold"
        @click.stop="loginDialog(true)"
      >
        ログイン
      </v-btn>
      <v-dialog v-model="loginModal" max-width="600px" persistent>
        <login-modal />
      </v-dialog>
      <v-btn
        class="ml-4 mr-2"
        color="green  white--text font-weight-bold"
        @click.stop="signUpDialog(true)"
      >
        新規登録
      </v-btn>
      <v-dialog v-model="signUpModal" max-width="600px" persistent>
        <sign-up-modal />
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
import { mapGetters, mapActions } from "vuex"
import headerAvatar from "~/components/HeaderAvatar.vue"
import signUpModal from "~/components/SignUpModal.vue"
import loginModal from "~/components/LoginModal.vue"
// import searchForm from "~/components/SearchForm.vue"

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
      links: [{ to: "/users/signup" }, { to: "/users/login" }],
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
          title: "新発売",
          to: "/food/new",
        },
        // {
        //   title: "カテゴリ",
        //   to: "/category",
        // },
        {
          title: "使い方",
          to: "/about",
        },
      ],
    }
  },
  computed: {
    ...mapGetters({
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
      if (link == "/ranking") {
        this.$store.dispatch("tab/getRankingTab", 0)
      } else if (link == "/food/new") {
        this.$store.dispatch("tab/getNewTab", 0)
      }
    },
    link(link) {
      this.$router.push({ path: `/${link}` })
    },
  },
}
</script>

<style scoped>
.header-title {
  color: white;
  font-size: 35px;
  font-family: "Fraunces", serif;
}
.link {
  text-decoration: none;
}
.search-form {
  width: 500px;
}
</style>
