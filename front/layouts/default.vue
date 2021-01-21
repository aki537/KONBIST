<template>
  <v-app>
    <v-navigation-drawer
      v-model="drawer"
      :clipped="clipped"
      fixed
      app
      dark
      width=190
    >
      <v-list>
        <v-list-item
          v-for="(item, i) in items"
          :key="i"
          :to="item.to"
          router
          exact
          class="mt-2"
        >
          <v-list-item-action>
            <v-icon>{{ item.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title v-text="item.title" />
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
     <v-app-bar
      :clipped-left="clipped"
      fixed
      app
    >
    <v-toolbar-title >
      <v-img 
        :src="img"
        max-width="200"
        max-height="200">
      </v-img>
    </v-toolbar-title>
      <!-- <v-toolbar-title
        class="header-title"
        v-text="title"  
      /> -->
      <v-spacer />
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>
      <v-btn class="ml-5 mr-4">
        ログイン
      </v-btn>
    </v-app-bar>
    <v-content>
      <v-container>
        <nuxt />
      </v-container>
    </v-content>
    <v-footer
      class="footer"
    >
      <div>&copy; {{ new Date().getFullYear() }}</div>
    </v-footer>
  </v-app>
</template>

<script>
export default {
  data () {
    return {
      img: require("~/assets/images/KONBIST-logo.png"),
      clipped: true,
      drawer: true,
      fixed: false,
      items: [
        {
          icon: 'mdi-stairs-up',
          title: 'ランキング',
          to: '/ranking'
        },
        {
          icon: 'mdi-folder-multiple-outline',
          title: 'カテゴリ',
          to: '/category'
        },
        {
          icon: 'mdi-new-box',
          title: '新商品',
          to: '/new_item'
        },
        {
          icon: 'mdi-file-outline',
          title: '使い方',
          to: '/gaidorain'
        }
      ],
    }
  }
}
</script>

<style>
.footer {
  margin-left: 195px;
}
</style>