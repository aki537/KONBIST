<template>
  <v-snackbar
    transition="slide-x-reverse-transition"
    right
    top
    v-model="status"
    :color="type"
  >
    <div class="ml-5">
      {{ message }}
    </div>
  </v-snackbar>
</template>


<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters ({
      message: 'flashMessage/message',
      type: 'flashMessage/type',
      status: 'flashMessage/status',
    }),
  }
};
</script>

<style scoped>
.message {
  color: transparent;
}
</style>