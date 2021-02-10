<template>
  <div>
    <template 
      v-if="user.image.url !== defaultImage"
    >
      <v-avatar
        :size="size"
        class="user-image"
      >
        <v-img 
          :src="user.image.url" 
          alt="avatar" 
        />
      </v-avatar>
    </template>
    <template v-else>
      <v-avatar
        :size="size"
        color="grey lighten-1"
      >
        <v-icon>mdi-account</v-icon>
      </v-avatar>
    </template>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data() {
    return {
      defaultImage: 'http://localhost:3000/fallback/default.png',
    }
  },
  props: {
    size: {
      type: Number,
      required: true
    },
    user: {
      type: Object,
      required: true
    }
  },
    computed: {
    ...mapGetters({
      currentUser: 'auth/currentUser'
    }),
  }
}
</script>

<style scoped>
.user-image{
  border: 1px solid;
  border-radius: 50%;
  border-color: #BDBDBD;
}
</style>