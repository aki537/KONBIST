<template>
      <v-navigation-drawer
        v-model="drawer"
        :clipped="clipped"
        fixed
        app
        dark
        width=200
        
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
</template>

<script>
export default {
  data() {
    return {
      clipped: true,
      drawer: false,
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
</style>