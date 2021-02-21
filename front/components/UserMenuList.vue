<template>
  <v-card flat class="pa-1">
    <v-list>
      <v-card v-for="menu in sortMenus" :key="menu.id" flat class="mb-2">
        <user-menu :menu="menu" />
      </v-card>
    </v-list>
  </v-card>
</template>

<script>
import userMenu from "~/components/UserMenu.vue"

export default {
  components: {
    userMenu,
  },
  props: {
    menus: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      setMenu: this.menus,
    }
  },
  computed: {
    sortMenus() {
      return this.setMenu.slice().sort((a, b) => {
        if (a.date < b.date || a.timezone_number < b.timezone_number) return 1
        if (a.date > b.date || a.timezone_number > b.timezone_number) return -1
        return 0
      })
    },
  },
}
</script>

<style scoped></style>
