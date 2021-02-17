<template>
  <v-container class="mt-5 px-10">
    <template v-if="loading">
      <v-card flat>
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
        <div
          class="subtitle-1 mt-2 blue--text darken-4--text text-decoration-underline"
        >
          {{ food.maker }}
        </div>
        <div class="display-1 mt-2 mb-4 font-weight-bold">
          {{ food.name }}
        </div>
        <v-divider />
        <v-sheet>
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
              <v-sheet class="ml-8">
                <div class="my-5 show-rate">
                  <span class="font-weight-bold"> 総合評価 </span>
                  <v-rating
                    v-model="rating"
                    background-color="orange lighten-1"
                    color="orange darken-2"
                    readonly
                    half-increments
                    class="ml-5"
                    dense
                    large
                  />
                  <span class="ml-5 font-weight-bold">
                    {{ rating }}
                  </span>
                  <small class="ml-10">
                    口コミ数：5
                    <br />
                    食べたい : 5人
                  </small>
                </div>
                <v-divider />
                <div v-if="login" class="font-weight-bold my-5">
                  <v-btn color="indigo accent-3 white--text font-weight-bold">
                    献立に追加
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
      <v-card flat>
        <v-row no-getters>
          <v-col cols="12" md="8">
            <v-card flat>
              <h3 class="show-info pl-2 mb-2">
                口コミ<span>（{{ food.reviews.length }}）</span>
              </h3>
              <template v-if="food.reviews.length === 0">
                <h4 class="my-5 text-decoration-underline">口コミ募集中！</h4>
                <food-review-modal :food="food" />
              </template>
              <template v-else>
                <food-review-list :reviews="food.reviews" />
              </template>
            </v-card>
          </v-col>
          <v-col cols="12" md="4">
            <v-card flat>
              <h3 class="mb-2 pl-2 show-info">カスタマーレビュー</h3>
              <v-card height="300px">作成中</v-card>
            </v-card>
          </v-col>
        </v-row>
      </v-card>
    </template>
  </v-container>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import foodReviewModal from "~/components/FoodReviewModal.vue"
import foodReviewList from "~/components/FoodReviewList.vue"

export default {
  components: {
    foodReviewModal,
    foodReviewList,
  },
  data() {
    return {
      loading: false,
      rating: 4.3,
      like: false,
      review: true,
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
    }),
    loginUserReview() {
      return this.$store.state.food.food
    },
  },
  // async mounted() {
  //   let res = await this.$axios.$get("/api/v1/isLike", {
  //     params: {
  //       user_id: this.$store.state.auth.currentUser.id,
  //       food_id: this.$store.state.food.food.id,
  //     },
  //   })
  //   this.like = Boolean(res)
  // },
  watch: {
    loginUserReview() {
      console.log(this.user.id)
      if (this.login) {
        this.food.reviews.forEach((f) => {
          if (f.user_id === this.user.id) {
            this.review = false
            console.log(this.review)
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
        }
        // ユーザーがすでにレビューを投稿してたら非表示にする
        console.log(this.user.id)
        if (this.login) {
          this.food.reviews.forEach((f) => {
            if (f.user_id === this.user.id) {
              this.review = false
              console.log(this.review)
            }
          })
        }
        this.createDate = this.$dayjs(this.food.created_at).format("YYYY/MM/DD")
        this.releaseDate = this.$dayjs(this.food.release).format("YYYY/MM/DD")
        this.loading = true
      })
  },
  methods: {
    ...mapActions({
      likeFood: "food/likeFood",
      unLikeFood: "food/unLikeFood",
    }),
    nice() {
      const foodData = {
        user: this.user.id,
        food: this.food.id,
      }
      if (this.like) {
        this.unLikeFood(foodData).then(() => {
          this.like = false
        })
      } else {
        this.likeFood(foodData).then(() => {
          this.like = true
        })
      }
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
  color: #2196f3;
  display: block;
  text-decoration: underline;
}
</style>
