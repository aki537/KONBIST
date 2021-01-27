<template>
  <v-app>
    <v-container>
      <v-row>
        <v-spacer></v-spacer>
        <v-col cols="12" lg="4">
          <v-row>
            <v-col
              cols="12"
              lg="7"
              class="grey--text text--darken-3 font-weight-bold pa-2 text-h6"
            >
              <p>
                アカウント設定
              </p>
            </v-col>
          </v-row>
          <v-row class="my-5">
            <v-col cols="12" lg="7" class="pa-2">
              <a
                href="/"
                class="grey--text text--darken-3 mb-1"
                @click="$auth.logout()"
              >
                ログアウト
              </a>
            </v-col>
            <v-col cols="12" lg="5" class="pa-2 text-right">
              <font-awesome-icon icon="angle-right" />
            </v-col>
          </v-row>
          <v-divider></v-divider>
          <v-row class="my-5">
            <v-col cols="12" lg="7" class="pa-2">
              <a
                href="#"
                class="red--text text--darken-3 mb-1"
                @click="deleteUser"
              >
                退会
              </a>
            </v-col>
            <v-col cols="12" lg="5" class="pa-2 text-right">
              <font-awesome-icon icon="angle-right" />
            </v-col>
          </v-row>
        </v-col>
        <v-spacer></v-spacer>
      </v-row>
    </v-container>
  </v-app>
</template>

<script>
export default {
  name: 'App',
  data: () => ({}),
  methods: {
    deleteUser() {
      this.$axios
        .delete('api/v1/auth', {
          headers: {
            'access-token': localStorage.getItem('access-token'),
            uid: localStorage.getItem('uid'),
            client: localStorage.getItem('client'),
          },
        })
        .then((response) => {
          this.$auth.logout()
          window.location.href = '/'
        })
    },
  },
}
</script>