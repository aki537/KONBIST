<template>
  <v-dialog v-model="dialog" max-width="600">
    <template #activator="{ on, attrs }">
      <v-btn
        color="orange white--text font-weight-bold"
        v-bind="attrs"
        v-on="on"
      >
        評価・口コミをする
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
        {{ food.name }}
      </v-card-title>
      <v-card-text>
        <v-form ref="form">
          <ValidationObserver v-slot="{ invalid }">
            <v-container>
              <div class="d-flex align-center my-2">
                <span class="font-weight-bold"> 総合評価 </span>
                <v-rating
                  v-model="review.rate"
                  background-color="orange lighten-1"
                  color="orange darken-2"
                  half-increments
                  class="ml-5"
                  dense
                  large
                  hover
                />
                <span class="ml-5 font-weight-bold">
                  {{ review.rate }}
                </span>
              </div>
              <ValidationProvider
                name="タイトル"
                v-slot="{ errors, valid }"
                rules="max:30|required"
              >
                <v-text-field
                  v-model="review.title"
                  :error-messages="errors"
                  :success="valid"
                  label="タイトルを入れてください"
                />
              </ValidationProvider>
              <ValidationProvider
                name="口コミ"
                v-slot="{ errors, valid }"
                rules="max:255|required"
              >
                <v-textarea
                  v-model="review.content"
                  :error-messages="errors"
                  :success="valid"
                  label="口コミ本文をいれてください"
                />
              </ValidationProvider>
              <v-file-input
                accept="image/png, image/jpeg, image/bmp"
                label="画像"
                show-size
                @change="setImage"
              />
              <v-img
                v-if="review.image"
                :src="input_image"
                contain
                max-width="600"
                max-height="300"
              />
            </v-container>
            <v-card-actions>
              <v-btn
                color="light-green darken-1"
                class="white--text font-weight-bold pa-5 mt-3"
                :disabled="invalid"
                block
                @click="postReview"
              >
                新規投稿
              </v-btn>
            </v-card-actions>
          </ValidationObserver>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
import { mapActions } from "vuex"

export default {
  props: {
    food: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      dialog: false,
      review: {
        title: "",
        content: "",
        rate: 0,
        image: "",
        user_id: this.$store.state.auth.loginUser.id,
        food_id: this.food.id,
      },
      input_image: "",
    }
  },
  computed: {},
  methods: {
    ...mapActions({ reviewFood: "food/review" }),
    postReview() {
      this.reviewFood(this.review)
      this.dialog = false
    },
    setImage(file) {
      this.review.image = file
      console.log(this.review.image)
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
        this.input_image = ""
      }
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
