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
        <v-btn icon>
          <v-icon>mdi-magnify</v-icon>
        </v-btn>
        <v-btn class="ml-5 mr-4" to="/users/login" >
          ログイン
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