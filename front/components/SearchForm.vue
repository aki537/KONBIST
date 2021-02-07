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
    <template class="hidden-md-and-up">
      <v-menu
        transition="slide-y-transition"
        min-width="200px"
        rounded
        offset-y
      >
        <template v-slot:activator="{ on }">
          <v-btn
            depressed
            v-on="on"
            icon
          >
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
    </template>
  </v-main> 
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  data() {
    return {
      search: null,
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'auth/currentUser'
    }),
  },
  methods: {
    ...mapActions({
      logout: 'auth/logout'
    }),
    pagelink(link){
      this.$router.push({ path: link })
    }
  }
}
</script>

<style scoped>
.search-form {
  width: 40px;
}
</style>