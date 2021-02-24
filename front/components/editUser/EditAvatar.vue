<template>
  <v-form ref="form" lazy-validation>
    <v-row justify="center">
      <v-avatar size="62">
        <template v-if="image.url !== null">
          <v-img v-if="input_image !== null" :src="input_image" contain />
          <v-img v-else :src="image.url" contain />
        </template>
        <template v-else>
          <v-img v-if="input_image" :src="input_image" contain />
        </template>
      </v-avatar>
    </v-row>
    <v-file-input
      v-model="editImage"
      accept="image/png, image/jpeg, image/bmp"
      outlined
      show-size
      label="プロフィール画像"
      @change="setImage"
    />
    <v-btn block color="success" class="white--text" @click="changeUserAvatar">
      変更
    </v-btn>
  </v-form>
</template>

<script>
export default {
  props: {
    image: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      editImage: "",
      input_image: null,
    }
  },
  methods: {
    setImage(file) {
      this.editImage = file
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf(".") <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener("load", () => {
          this.input_image = fr.result
        })
      } else {
        this.input_image = null
      }
    },
    async changeUserAvatar() {
      const formData = new FormData()
      if (this.editImage != "") {
        formData.append("image", this.editImage)
      }
      await this.$axios
        .put("api/v1/auth", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then((res) => {
          console.log(res)
          this.$store.commit("auth/setCurrentUser", res.data.data)
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "アバター画像を更新しました。",
              type: "success",
              status: true,
            },
            { root: true }
          )
        })
        .catch(() => {
          this.$store.dispatch(
            "flashMessage/showMessage",
            {
              message: "アバター画像の更新に失敗しました。",
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
