<template>
  <v-dialog v-model="editDialog" max-width="600">
    <template #activator="{ on: dialog, attrs }">
      <v-tooltip top>
        <template
          v-if="$store.state.auth.isLoggedIn"
          #activator="{ on: tooltip }"
        >
          <v-btn
            v-if="review.user_id === $store.state.auth.loginUser.id"
            v-bind="attrs"
            icon
            v-on="{ ...dialog, ...tooltip }"
          >
            <v-icon> mdi-comment-edit </v-icon>
          </v-btn>
        </template>
        <span>口コミ編集</span>
      </v-tooltip>
    </template>

    <v-card>
      <v-system-bar lights-out>
        <v-spacer></v-spacer>
        <v-btn icon class="mt-5" @click="editDialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-system-bar>
      <v-card-title class="headline justify-center">
        {{ review.food.name }}
      </v-card-title>
      <v-card-text>
        <v-form ref="form">
          <ValidationObserver v-slot="{ invalid }">
            <v-container>
              <div class="d-flex align-center my-2">
                <span class="font-weight-bold"> 評価 </span>
                <v-rating
                  v-model="reviewEdit.rate"
                  :error-messages="errors"
                  :success="valid"
                  background-color="orange lighten-1"
                  color="orange darken-2"
                  half-increments
                  class="ml-5"
                  dense
                  large
                  hover
                />
                <span class="ml-5 font-weight-bold">
                  {{ reviewEdit.rate }}
                </span>
              </div>
              <ValidationProvider
                v-slot="{ errors, valid }"
                name="タイトル"
                rules="max:30|required"
              >
                <v-text-field
                  v-model="reviewEdit.title"
                  :error-messages="errors"
                  :success="valid"
                  label="タイトルを入れてください"
                />
              </ValidationProvider>
              <ValidationProvider
                v-slot="{ errors, valid }"
                name="口コミ"
                rules="max:255|required"
              >
                <v-textarea
                  v-model="reviewEdit.content"
                  :error-messages="errors"
                  :success="valid"
                  label="口コミ本文をいれてください"
                />
              </ValidationProvider>
              <v-file-input
                v-model="reviewEdit.image"
                accept="image/png, image/jpeg, image/bmp"
                label="画像"
                show-size
                @change="setImage"
              />
              <template v-if="review.image.url">
                <v-img
                  v-if="input_image !== null"
                  :src="input_image"
                  contain
                  max-width="600"
                  max-height="300"
                />
                <v-img
                  v-else
                  :src="review.image.url"
                  contain
                  max-width="600"
                  max-height="300"
                />
              </template>
              <template v-else>
                <v-img
                  v-if="input_image"
                  :src="input_image"
                  contain
                  max-width="600"
                  max-height="300"
                />
              </template>
            </v-container>
            <v-card-actions>
              <v-btn
                color="light-green darken-1"
                class="white--text font-weight-bold pa-5 mt-3"
                :disabled="invalid"
                block
                @click="foodReviewEdit"
              >
                口コミ編集
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
    review: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      editDialog: false,
      reviewEdit: {
        title: this.review.title,
        content: this.review.content,
        rate: this.review.rate,
        image: this.review.image,
        user_id: this.review.user_id,
        food_id: this.review.food_id,
        reviewId: this.review.id,
      },
      input_image: null,
    }
  },
  computed: {},
  methods: {
    ...mapActions({ editReview: "food/editReview" }),
    foodReviewEdit() {
      this.editReview(this.reviewEdit)
      this.editDialog = false
    },
    setImage(file) {
      this.reviewEdit.image = file
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
