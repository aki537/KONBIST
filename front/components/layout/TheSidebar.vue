<template>
  <v-navigation-drawer
    v-model="drawer"
    :clipped="clipped"
    fixed
    stateless
    app
    dark
    width="250"
  >
    <v-list>
      <template v-if="foods">
        <v-list-item v-for="food in foods" :key="food.id" exact class="mt-2">
          <v-list-item-content>
            <v-list-item-title v-text="food.name" />
          </v-list-item-content>
        </v-list-item>
      </template>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  data() {
    return {
      clipped: true,
      fixed: false,
      items: [
        {
          icon: "mdi-stairs-up",
          title: "ランキング",
          to: "/ranking",
        },
        {
          icon: "mdi-folder-multiple-outline",
          title: "カテゴリ",
          to: "/category",
        },
        {
          icon: "mdi-new-box",
          title: "新商品",
          to: "/new_item",
        },
        {
          icon: "mdi-file-outline",
          title: "使い方",
          to: "/gaidorain",
        },
      ],
    }
  },
  computed: {
    ...mapGetters({
      drawer: "choise/drawer",
      foods: "choise/foods",
    }),
  },
}
</script>

<style></style>
