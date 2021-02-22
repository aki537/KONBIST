<template>
  <div>
    <v-snackbar
      v-if="drawer"
      v-model="status"
      transition="slide-x-transition"
      left
      top
    >
      <span class="font-weight-bold ml-2">{{ message }}</span>
    </v-snackbar>
    <v-snackbar
      v-else
      v-model="status"
      transition="slide-x-transition"
      left
      top
    >
      <div class="pl-2 mb-3 white--text subtitle-1">
        {{ message }}
      </div>
      <v-divider />
      <div class="ml-1">
        <template v-if="status">
          <v-avatar size="40" class="small-image" max-width="40" color="white">
            <v-img
              v-if="food.image.url"
              :src="food.image.url"
              alt="avatar"
              contain
            />
            <v-img v-else :src="defaultImage" contain />
          </v-avatar>
          <span class="font-weight-bold ml-1">{{ food.name }}</span>
        </template>
      </div>
    </v-snackbar>
  </div>
</template>

<script>
import { mapGetters } from "vuex"
export default {
  data() {
    return {
      defaultImage: require("@/assets/images/default.png"),
    }
  },
  computed: {
    ...mapGetters({
      food: "choise/food",
      status: "choise/status",
      drawer: "choise/drawer",
      message: "choise/message",
    }),
  },
}
</script>

<style scoped>
.message {
  color: transparent;
}
.small-image {
  border: 1px solid;
  border-radius: 9px;
  border-color: #bdbdbd;
}
</style>
