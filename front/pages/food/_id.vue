<template>
  <div style="background-color: #fbfbfb">
    <v-container class="pt-7 px-10">
      <template v-if="loading">
        <v-card flat style="background-color: #fbfbfb">
          <v-row class="mx-1" no-gutters>
            <v-chip
              class="mb-1 font-weight-bold"
              color="blue-grey darken-2"
              label
              text-color="white"
            >
              {{ food.category }}
            </v-chip>
            <v-spacer />
            <p class="caption">更新日時 : {{ createDate }}</p>
          </v-row>
          <div class="subtitle-1 mt-2 text-decoration-underline">
            {{ food.maker }}
          </div>
          <div class="display-1 mt-2 mb-4 font-weight-bold">
            {{ food.name }}
          </div>
          <v-divider />
          <v-sheet style="background-color: #fbfbfb">
            <v-row no-gutters>
              <v-col cols="12" sm="4">
                <v-img v-if="food.image.url" :src="food.image.url" contain />
                <v-img v-else :src="defaultImage" contain />
                <div class="text-center font-weight-bold mb-3 mt-1">
                  {{ food.name }}
                </div>
                <v-divider />
                <v-avatar size="50" class="mr-3 my-4 small-image">
                  <v-img
                    v-if="food.image.url"
                    :src="food.image.url"
                    alt="avatar"
                  />
                  <v-img v-else :src="defaultImage" contain />
                </v-avatar>
                <v-divider />
              </v-col>
              <v-col cols="12" sm="8">
                <v-sheet class="ml-8" style="background-color: #fbfbfb">
                  <div class="my-5 show-rate">
                    <span class="font-weight-bold"> 総合評価 </span>
                    <v-rating
                      v-model="food.avg_rate"
                      background-color="orange lighten-1"
                      color="orange darken-2"
                      readonly
                      half-increments
                      class="ml-5"
                      dense
                      large
                    />
                    <span class="ml-5 font-weight-bold">
                      {{ food.avg_rate }}
                    </span>
                    <small class="ml-10">
                      口コミ数 :
                      <user-dialog-review
                        :users="food.reviews"
                        :title="'口コミユーザー'"
                      />
                      <br />
                      食べたい :
                      <user-dialog
                        :users="food.like_users"
                        :title="'食べたいユーザー'"
                      />
                    </small>
                  </div>
                  <v-divider />
                  <div v-if="login" class="font-weight-bold my-5">
                    <v-btn
                      v-if="add"
                      color="red accent-3 white--text font-weight-bold"
                      @click="deleteMenu"
                    >
                      メニューから外す
                    </v-btn>
                    <v-btn
                      v-else
                      color="indigo accent-3 white--text font-weight-bold"
                      @click="addMenu"
                    >
                      メニューに追加
                    </v-btn>
                    <v-btn
                      v-if="like"
                      class="mx-5"
                      color="red white--text font-weight-bold"
                      @click="nice"
                    >
                      食べたい解除
                    </v-btn>
                    <v-btn
                      v-else
                      class="mx-5"
                      color="green white--text font-weight-bold"
                      @click="nice"
                    >
                      食べたい!
                    </v-btn>
                    <food-review-modal v-if="review" :food="food" />
                  </div>
                  <v-divider />
                  <div class="my-4">
                    <h2 class="show-info pl-3">商品詳細情報</h2>
                    <div class="mt-5">
                      <dl class="product-spec-list">
                        <dt class="product-spec-term">販売価格</dt>
                        <dd class="product-spec-description">
                          <span>{{ food.price }}円（税込）</span>
                        </dd>
                      </dl>
                      <dl class="product-spec-list">
                        <dt class="product-spec-term">カテゴリ</dt>
                        <dd class="product-spec-description">
                          <a class="product-spec-link">{{ food.category }}</a>
                        </dd>
                      </dl>
                      <dl class="product-spec-list">
                        <dt class="product-spec-term">メーカー名</dt>
                        <dd class="product-spec-description">
                          <a class="product-spec-link">{{ food.maker }}</a>
                        </dd>
                      </dl>
                      <dl class="product-spec-list">
                        <dt class="product-spec-term">カロリー</dt>
                        <dd class="product-spec-description">
                          <span>{{ food.calorie }}kcal</span>
                        </dd>
                      </dl>
                      <dl class="product-spec-list">
                        <dt class="product-spec-term">タンパク質</dt>
                        <dd class="product-spec-description">
                          <span>{{ food.protein }}g</span>
                        </dd>
                        <dt class="product-spec-term ml-16">炭水化物</dt>
                        <dd class="product-spec-description">
                          <span>{{ food.carbonhydrate }}g</span>
                        </dd>
                        <dt class="product-spec-term ml-16">脂質</dt>
                        <dd class="product-spec-description">
                          <span>{{ food.lipid }}g</span>
                        </dd>
                      </dl>
                      <dl class="product-spec-list">
                        <dt class="product-spec-term">商品説明</dt>
                        <dd class="product-spec-description">
                          <span>{{ food.details }}</span>
                        </dd>
                      </dl>
                      <dl class="product-spec-list">
                        <dt class="product-spec-term">発売日</dt>
                        <dd class="product-spec-description">
                          <span v-if="food.release">{{ releaseDate }}</span>
                          <span v-else>不明</span>
                        </dd>
                      </dl>
                    </div>
                  </div>
                </v-sheet>
              </v-col>
            </v-row>
          </v-sheet>
        </v-card>
        <v-divider class="my-5" />
        <v-card flat style="background-color: #fbfbfb">
          <v-row no-getters>
            <v-col cols="12" md="8">
              <v-card flat tile style="background-color: #fbfbfb">
                <h3 class="show-info pl-2 mb-2">
                  口コミ<span>（{{ food.reviews.length }}）</span>
                </h3>
                <template v-if="food.reviews.length === 0">
                  <h4 class="my-5 text-decoration-underline">口コミ募集中！</h4>
                  <food-review-modal v-if="login" :food="food" />
                </template>
                <template v-else>
                  <food-review-list :reviews="food.reviews" />
                </template>
              </v-card>
            </v-col>
            <!-- <v-col cols="12" md="4">
              <v-card flat tile style="background-color: #fbfbfb">
                <h3 class="mb-2 pl-2 show-info">カスタマーレビュー</h3>
                <v-card height="300px" class="pl-3 pt-2">作成中</v-card>
              </v-card>
            </v-col> -->
          </v-row>
        </v-card>
      </template>
    </v-container>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import foodReviewModal from "~/components/FoodReviewModal.vue"
import foodReviewList from "~/components/FoodReviewList.vue"
import userDialog from "~/components/UserDialog.vue"
import userDialogReview from "~/components/UserDialogReview.vue"

export default {
  name: "KONBIST",
  components: {
    foodReviewModal,
    foodReviewList,
    userDialogReview,
    userDialog,
  },
  data() {
    return {
      loading: false,
      like: false,
      review: true,
      add: false,
      createDate: "",
      releaseDate: "",
      defaultImage: require("@/assets/images/default.png"),
    }
  },
  computed: {
    ...mapGetters({
      food: "food/food",
      user: "auth/loginUser",
      login: "auth/isLoggedIn",
      todayFoods: "choise/foods",
    }),
    loginUserReview() {
      return this.$store.state.food.food
    },
  },
  watch: {
    loginUserReview() {
      // ユーザーがすでにレビューを投稿してたら非表示にする
      if (this.login) {
        this.review = true
        this.food.reviews.forEach((f) => {
          if (f.user_id === this.user.id) {
            this.review = false
          }
        })
        this.add = false
        this.todayFoods.forEach((f) => {
          if (f.id === this.food.id) {
            this.add = true
          }
        })
      }
    },
  },
  created() {
    this.$axios
      .get(`api/v1/foods/${this.$route.params.id}`)
      .then((res) => {
        this.$store.commit("food/setFood", res.data, { root: true })
      })
      .then(() => {
        // ユーザーがログインしてたらlikeしているか確認
        if (this.login) {
          this.food.like_users.forEach((f) => {
            if (f.id === this.user.id) {
              this.like = true
            }
          })
          this.add = false
          this.todayFoods.forEach((f) => {
            if (f.id === this.food.id) {
              this.add = true
            }
          })
        }
        this.createDate = this.$dayjs(this.food.updated_at).format("YYYY/MM/DD")
        this.releaseDate = this.$dayjs(this.food.release).format("YYYY/MM/DD")
        this.loading = true
      })
  },
  methods: {
    ...mapActions({
      likeFood: "food/likeFood",
      unLikeFood: "food/unLikeFood",
      addFood: "choise/addFood",
      deleteFood: "choise/deleteFood",
    }),
    nice() {
      const foodData = {
        user: this.user.id,
        food: this.food.id,
      }
      if (this.like) {
        this.unLikeFood(foodData).then(() => {
          this.$axios
            .$get(`/api/v1/foods/${this.$route.params.id}`)
            .then((res) => {
              this.$store.commit("food/setFood", res, { root: true })
              this.like = false
            })
        })
      } else {
        this.likeFood(foodData).then(() => {
          this.$axios
            .$get(`/api/v1/foods/${this.$route.params.id}`)
            .then((res) => {
              this.$store.commit("food/setFood", res, { root: true })
              this.like = true
            })
        })
      }
    },
    addMenu() {
      this.addFood(this.food)
      this.add = true
    },
    deleteMenu() {
      this.deleteFood(this.food)
      this.add = false
    },
  },
}
</script>

<style scoped>
.small-image {
  border: 1px solid;
  border-radius: 9px;
  border-color: #bdbdbd;
}
.show-rate {
  font-size: 18px;
  font-weight: 200;
  display: flex;
  align-items: center;
}
.show-info {
  border-left: 3px solid;
  border-color: #2196f3;
}
.product-spec-list {
  border-bottom: 1px solid #e7e7e7;
  margin: 0;
}
.product-spec-term {
  display: inline-block;
  vertical-align: top;
  width: 105px;
  font-size: 15px;
  line-height: 16px;
  color: #999;
  font-weight: 500;
  margin: 12px 0 8px;
}
.product-spec-description {
  display: inline-block;
  vertical-align: top;
  font-size: 15px;
  line-height: 16px;
  letter-spacing: 0.4px;
  color: #2d2926;
  font-weight: 400;
  margin: 12px 0 8px;
  white-space: pre-wrap;
}
.product-spec-link {
  text-decoration: none;
  color: black;
  display: block;
  cursor: default;
  /* text-decoration: underline; */
}
</style>
