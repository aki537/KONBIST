<template>
      <v-app-bar
        :clipped-left="clipped"
        fixed
        app
      >
        <v-app-bar-nav-icon @click.stop="$emit('toggle-drawer')"></v-app-bar-nav-icon>
          <!-- <v-toolbar-title >
            <v-img 
              :src="img"
              max-width="200"
              max-height="200">
            </v-img>
          </v-toolbar-title> -->
        <nuxt-link to="/" class="link">
          <v-toolbar-title
            class="header-title"
            v-text="title" 
          />
        </nuxt-link>
        <v-spacer />
        <p>ログイン状態:{{ $store.state.auth.isLoggedIn }}</p>
        <v-btn icon>
          <v-icon>mdi-magnify</v-icon>
        </v-btn>
        <template v-if="!$store.state.auth.isLoggedIn">
          <v-btn class="ml-5 mr-2" @click="pagelink(links[0].to)">
            新規登録
          </v-btn>
          <v-btn class="ml-4 mr-2" @click="pagelink(links[1].to)">
            ログイン
          </v-btn>
        </template>
        <template v-else>
          <v-btn class="ml-5 mr-2" @click="pagelink(links[2].to)">
            編集
          </v-btn>
          <v-btn class="ml-4 mr-2" @click="logout">
            ログアウト
          </v-btn>
        </template>
      </v-app-bar>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data() {
    return {
      clipped: true,
      drawer: null,
      fixed: false,
      title: 'KONBIST',
      links: [
        { to:"/users/signup"},
        { to:"/users/login"},
        { to:"/users/edit"},
      ]
    }
  },
  methods: {
    ...mapActions({
      logout: 'auth/logout'
    }),
    // ページ遷移方法を変更
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