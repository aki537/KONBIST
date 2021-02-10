<template>
  <v-main>
    <v-text-field
      :value="search"
      label="検索..."
      prepend-inner-icon="mdi-magnify"
      class="mt-6 ml-10 mr-3 search-form hidden-md-and-down"
      solo
      rounded
    />
    <div class="hidden-md-and-up">
      <v-menu
        transition="slide-y-transition"
        min-width="200px"
        rounded
        offset-y
      >
        <template #activator="{ on }">
          <v-btn depressed icon v-on="on">
            <v-icon>mdi-magnify</v-icon>
          </v-btn>
        </template>
        <v-text-field
          :value="search"
          label="検索..."
          prepend-inner-icon="mdi-magnify"
          class="mt-6 ml-10 mr-3 search-form"
          solo
          rounded
          fixed
        />
      </v-menu>
    </div>
  </v-main>
</template>

<script>
import { mapActions, mapGetters } from "vuex"
export default {
  data() {
    return {
      search: null,
    }
  },
  computed: {
    ...mapGetters({
      currentUser: "auth/currentUser",
    }),
  },
  methods: {
    ...mapActions({
      logout: "auth/logout",
    }),
    pagelink(link) {
      this.$router.push({ path: link })
    },
  },
}
</script>

<style scoped>
.search-form {
  width: 40px;
}
</style>
