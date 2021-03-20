<template>
  <v-dialog v-model="dialog" max-width="600">
    <template #activator="{ on, attrs }">
      <span v-bind="attrs" class="arrow_box" v-on="on">
        {{ users.length }}
      </span>
    </template>

    <v-card class="ma-0">
      <v-card-title style="background-color: #fbfbfb">
        {{ title }}
        <span> （{{ users.length }}） </span>
      </v-card-title>
      <v-list two-line style="background-color: #fbfbfb">
        <!-- <v-list-item-group> -->
        <v-row>
          <v-list-item
            v-for="f in users"
            :key="f.id"
            :ripple="false"
            class="list"
          >
            <nuxt-link :to="{ path: `/users/${f.user.id}` }">
              <user-avatar :size="45" :user="f.user" class="list-avatar mx-3" />
            </nuxt-link>
            <v-list-item-content>
              <v-list-item-title class="list-item" @click="pagelink(f.user.id)">
                {{ f.user.name }}
              </v-list-item-title>
            </v-list-item-content>
            <user-follow :user="f.user" />
          </v-list-item>
          <v-divider />
        </v-row>
      </v-list>
    </v-card>
  </v-dialog>
</template>

<script>
import userAvatar from "~/components/UserAvatar.vue"
import userFollow from "~/components/UserFollow.vue"
// import { mapActions } from "vuex"

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
    title: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      dialog: false,
    }
  },
  methods: {
    pagelink(link) {
      this.$router.push({ path: `/users/${link}` })
    },
  },
}
</script>

<style scoped>
.signup-link {
  color: #2196f3;
  cursor: pointer;
}
.signup-link:hover {
  opacity: 0.8;
  text-decoration: underline;
}
.list-item {
  cursor: pointer;
}
.list-avatar {
  cursor: pointer;
}
.list:hover {
  transition: 0.3s;
  background-color: #f5f5f5;
}
.list {
  cursor: default;
}
.arrow_box {
  position: relative;
  border: 1px solid black;
  padding: 5px 7px;
  color: #2196f3 !important;
  border-radius: 3px;
}
.arrow_box:after,
.arrow_box:before {
  right: 100%;
  top: 50%;
  border: solid transparent;
  content: "";
  height: 0;
  width: 0;
  position: absolute;
  pointer-events: none;
}

.arrow_box:after {
  border-color: rgba(136, 183, 213, 0);
  border-right-color: white;
  border-width: 6px;
  margin-top: -6px;
  text-decoration: underline !important;
}
.arrow_box:before {
  border-color: rgba(194, 225, 245, 0);
  border-right-color: black;
  border-width: 7px;
  margin-top: -7px;
}
</style>
