<template>
  <v-container>
    <v-row justify="center">
      <v-col xl="5" lg="7" sm="9" cols="12">
        <v-card class="mx-auto">
          <v-tabs
            v-model="tab"
            fixed-tabs
            centered
            background-color="grey lighten-2"
            slider-color="info"
            icons-and-text
          >
            <v-tab class="ma-0 pa-0">
              プロフィール
              <v-icon>mdi-account</v-icon>
            </v-tab>
            <v-tab class="ma-0 pa-0">
              登録情報
              <v-icon>mdi-account-cog</v-icon>
            </v-tab>
          </v-tabs>
          <v-tabs-items v-model="tab" touchless>
            <v-container>
              <v-tab-item class="px-2">
                <edit-avatar />
                <v-divider />
                <edit-profile />
              </v-tab-item>
              <v-tab-item class="px-2">
                <edit-email />
                <v-divider />
                <edit-password />
                <v-divider />
                <delete-user />
              </v-tab-item>
            </v-container>
          </v-tabs-items>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import editAvatar from "~/components/editUser/EditAvatar"
import editEmail from "~/components/editUser/EditEmail"
import editPassword from "~/components/editUser/EditPassword"
import editProfile from "~/components/editUser/EditProfile"
import deleteUser from "~/components/editUser/DeleteUser"

export default {
  components: {
    editAvatar,
    editEmail,
    editPassword,
    editProfile,
    deleteUser,
  },
  data() {
    return {
      tab: null,
    }
  },
}
</script>
