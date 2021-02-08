<template>
  <v-app-bar
    :clipped-left="clipped"
    app
  >
    <v-app-bar-nav-icon @click.stop="$emit('toggle-drawer')"></v-app-bar-nav-icon>
    <nuxt-link to="/" class="link">
      <v-toolbar-title
        class="header-title"
        v-text="title" 
      />
    </nuxt-link>
        <v-tabs
          v-model="tab"
          align-with-title
        >
          <v-tabs-slider></v-tabs-slider>

          <v-tab
            v-for="item in items"
            :key="item"
            :to="item.to"
          >
            {{ item.title }}
          </v-tab>
        </v-tabs>
    <v-spacer />
    <div class="mt-6 mr-3 search-form">
      <v-text-field
        :value="search"
        label="検索..."
        prepend-inner-icon="mdi-magnify"
        solo
        rounded
      />
    </div>
    <template v-if="!loggedIn">
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
      <v-btn
        @click.stop="signUpDialog = true"
        class="ml-4 mr-2 "
        color="green  white--text font-weight-bold"
      >
        新規登録
      </v-btn>
      <v-dialog v-model="signUpDialog" max-width="600px">
        <sign-up-modal 
          v-on:closeModal="closeSignUp"
          v-on:loginUser="openLogin"
        />
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
import { mapGetters } from 'vuex'
import headerAvatar from '~/components/HeaderAvatar.vue'
import signUpModal from '~/components/SignUpModal.vue'
import loginModal from '~/components/LoginModal.vue'
import searchForm from '~/components/SearchForm.vue'

export default {
  components: {
    headerAvatar,
    signUpModal,
    loginModal,
    searchForm
  },
  data() {
    return {
      clipped: true,
      drawer: null,
      fixed: true,
      title: 'KONBIST',
      signUpDialog: false,
      loginDialog: false,
      links: [
        { to:"/users/signup"},
        { to:"/users/login"},
      ],
      search: null,
      tab: null,
      items: [
        {
          title: 'ホーム',
          to: '/'
        },
        {
          title: 'ランキング',
          to: '/ranking'
        },
        {
          title: 'カテゴリ',
          to: '/category'
        },
        {
          title: '新商品',
          to: '/new_item'
        },
        {
          title: '使い方',
          to: '/gaidorain'
        }
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