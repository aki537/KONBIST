<template>
  <v-menu transition="slide-y-transition" min-width="200px" rounded offset-y>
    <template #activator="{ on }">
      <v-btn depressed x-large tile v-on="on">
        <user-avatar :size="44" :user="currentUser" />
        <v-icon dense class="ml-1"> mdi-chevron-down </v-icon>
      </v-btn>
    </template>
    <v-card>
      <v-list-item-content class="justify-center">
        <div class="mx-auto text-center">
<<<<<<< Updated upstream
          <template v-if="currentUser.image.url !== defaultImage">
            <v-avatar size="44">
              <v-img :src="currentUser.image.url"></v-img>
            </v-avatar>
          </template>
          <template v-else>
            <v-avatar size="44" color="grey lighten-1">
              <v-icon>mdi-account</v-icon>
            </v-avatar>
          </template>
=======
<<<<<<< Updated upstream
          <template 
            v-if="currentUser.image.url !== defaultImage"
          >
          <v-avatar
            size="44"
          >
            <v-img :src="currentUser.image.url"></v-img>
          </v-avatar>
        </template>
        <template v-else>
          <v-avatar
            size="44"
            color="grey lighten-1"
          >
          <v-icon>mdi-account</v-icon>
          </v-avatar>
        </template>
=======
          <user-avatar :size="44" :user="currentUser" />
>>>>>>> Stashed changes
>>>>>>> Stashed changes
          <h3>{{ currentUser.name }}</h3>
          <p class="caption mt-1">
            {{ currentUser.email }}
          </p>
          <v-divider class="my-3"></v-divider>
          <v-btn
            depressed
            rounded
            text
            :to="{ path: `/users/${currentUser.id}` }"
          >
            マイページ
          </v-btn>
          <v-divider class="my-3"></v-divider>
          <v-btn depressed rounded text to="/users/edit"> 登録情報変更 </v-btn>
          <v-divider class="my-3"></v-divider>
          <v-btn depressed rounded text @click="logout"> ログアウト </v-btn>
        </div>
      </v-list-item-content>
    </v-card>
  </v-menu>
</template>

<script>
import { mapActions, mapGetters } from "vuex"
import userAvatar from "~/components/UserAvatar.vue"

export default {
  components: {
    userAvatar,
  },
  data() {
    return {
      defaultImage: "http://localhost:3000/fallback/default.png",
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
