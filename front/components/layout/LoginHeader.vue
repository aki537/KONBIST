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
        <p>ログイン状態:{{$store.state.user.isLoggedIn}}</p>
        <!-- <p>{{$store.state.user.current_user}}</p> -->
        <v-btn icon>
          <v-icon>mdi-magnify</v-icon>
        </v-btn>
        <v-btn class="ml-5 mr-2" to="/" @click="logout">
          ログアウト
        </v-btn>
      </v-app-bar>
</template>

<script>
export default {
  data() {
    return {
      clipped: true,
      drawer: null,
      fixed: false,
      title: 'KONBIST',
    }
  },
  methods: {
    async logout(){
      console.log(this.$store)
      await this.$axios.$delete('/api/v1/auth/sign_out')
      .then( res => {
        console.log('ログアウト成功')
        // commit('removeCurrentUser')
        this.$store.commit('user/removeCurrentUser')
        console.log(res)
        return res
      }).catch( err => {
        console.log('ログアウト失敗')
        console.log(err)
        return err
      })
    },
  }
//   computed: {
//    loggedInUser () {
//      return this.$auth.user
//    }
// }
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