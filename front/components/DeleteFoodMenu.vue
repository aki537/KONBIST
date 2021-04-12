<template>
  <v-dialog v-model="dialog" max-width="600">
    <template v-if="$store.state.auth.isLoggedIn" #activator="{ on, attrs }">
      <v-btn
        v-if="menu.user_id === $store.state.auth.loginUser.id"
        color="red"
        class="font-weight-bold justify-center mr-2"
        text
        v-bind="attrs"
        v-on="on"
      >
        削除
      </v-btn>
    </template>

    <v-card>
      <v-system-bar lights-out>
        <v-spacer></v-spacer>
        <v-btn icon class="mt-5" @click="dialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-system-bar>
      <v-card-title class="headline justify-center">
        メニューを削除しますか？
      </v-card-title>
      <v-card-text class="mt-3 justify-center">
        この操作は取り消せません。メニューが削除されます。
      </v-card-text>
      <div class="text-center">
        <v-btn
          color="red"
          class="font-weight-bold justify-center mb-2"
          text
          @click="deleteMenu(menu.id)"
        >
          削除
        </v-btn>
      </div>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    menu: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      dialog: false,
    }
  },
  methods: {
    // ...mapActions({ deleteReview: "food/deleteReview" }),
    deleteMenu(id) {
      this.$axios
        .delete(`api/v1/menus/${id}`)
        .then(() => {
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "メニューを削除しました。",
              type: "info",
              status: true,
            },
            { root: true }
          )
          this.$axios
            .$get(`/api/v1/users/${this.$route.params.id}`)
            .then((res) => {
              this.$store.commit("user/setUser", res, { root: true })
              this.dialog = false
            })
        })
        .catch((err) => {
          console.log(err)
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "メニューの削除に失敗しました。",
              type: "error",
              status: true,
            },
            { root: true }
          )
        })
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
</style>
