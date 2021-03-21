<template>
  <v-card style="background-color: #fbfbfb">
    <v-list two-line style="background-color: #fbfbfb">
      <!-- <v-list-item-group> -->
      <v-row>
        <v-list-item
          v-for="user in users"
          :key="user.id"
          :ripple="false"
          class="list"
        >
          <nuxt-link :to="{ path: `/users/${user.id}` }">
            <user-avatar :size="45" :user="user" class="list-avatar mx-3" />
          </nuxt-link>
          <v-list-item-content>
            <v-list-item-title
              class="list-item title"
              @click="pagelink(user.id)"
            >
              {{ user.name }}
            </v-list-item-title>
            <!-- <v-list-item-subtitle>
              {{ user.email }}
            </v-list-item-subtitle> -->
          </v-list-item-content>
          <user-follow :user="user" class="mr-3" />
        </v-list-item>
        <v-divider />
      </v-row>
    </v-list>
  </v-card>
</template>

<script>
import { mapGetters } from "vuex"
import userAvatar from "~/components/UserAvatar.vue"
import userFollow from "~/components/UserFollow.vue"

export default {
  components: {
    userAvatar,
    userFollow,
  },
  props: {
    users: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      icon: require("@/assets/images/default-user.png"),
      follow: false,
    }
  },
  computed: {
    ...mapGetters({
      loginUser: "auth/loginUser",
      user: "user/user",
      login: "auth/isLoggedIn",
    }),
  },
  methods: {
    pagelink(link) {
      this.$router.push({ path: String(link) })
    },
  },
}
</script>

<style scoped>
.list-item {
  cursor: pointer;
}
.list-avatar {
  cursor: pointer;
}
.list-item:hover {
  opacity: 0.7;
}
.list-avatar:hover {
  opacity: 0.7;
}
.list:hover {
  transition: 0.3s;
  background-color: #f5f5f5;
}
.list {
  cursor: default;
}
</style>
