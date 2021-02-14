<template>
  <v-menu
    v-model="menu"
    transition="slide-x-reverse-transition"
    min-width="200px"
    max-width="350px"
    rounded
    offset-x
    internal-activator
    left
  >
    <template #activator="{ on, attrs }">
      <v-btn icon text color="grey" v-bind="attrs" :ripple="false" v-on="on">
        <v-icon v-on="on" v-if="heart" color="red"> mdi-heart </v-icon>
        <v-icon v-on="on" v-else> mdi-dots-horizontal </v-icon>
      </v-btn>
    </template>
    <v-card>
      <v-list-item two-line :to="{ path: `/food/${food.id}` }">
        <v-list-item-avatar>
          <v-img :src="food.image.url" />
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title>
            {{ food.name }}
          </v-list-item-title>
          <v-list-item-subtitle>
            {{ food.maker }}
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-divider />
      <div class="text-center">
        <v-btn v-if="like" block depressed text class="py-6" @click="nice">
          食べたいから解除
        </v-btn>
        <v-btn v-else block depressed text class="py-6" @click="nice">
          食べたい！
        </v-btn>
        <v-divider />
        <v-btn
          block
          depressed
          text
          :to="{ path: `/food/${food.id}` }"
          class="py-6"
        >
          献立に追加
        </v-btn>
        <v-divider />
      </div>
    </v-card>
  </v-menu>
</template>

<script>
import { mapActions, mapGetters } from "vuex"

export default {
  props: {
    food: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      defaultImage: "http://localhost:3000/fallback/default.png",
      menu: false,
      liking: [],
      like: false,
      users: this.food.like_users,
      heart: Boolean,
    }
  },
  computed: {
    ...mapGetters({
      user: "user/user",
      loginUser: "auth/loginUser",
      currentUser: "auth/currentUser",
    }),
  },
  mounted() {
    this.like = false
    this.liking = []
    this.loginUser.foodlike.forEach((food) => {
      if (food.name === this.food.name) {
        this.liking.push(food.name)
      }
    })
    console.log(this.liking)
    // console.log(this.food.name)
    if (this.liking[0] === this.food.name) {
      this.like = true
      this.heart = true
    } else {
      this.like = false
      this.heart = false
    }
    console.log(this.like)
  },
  beforeUpdate() {
    this.like = false
    this.liking = []
    this.loginUser.foodlike.forEach((food) => {
      if (food.name === this.food.name) {
        this.liking.push(food.name)
      }
    })
    console.log(this.liking)
    // console.log(this.food.name)
    if (this.liking[0] === this.food.name) {
      this.like = true
    } else {
      this.like = false
    }
    console.log(this.like)
  },
  methods: {
    ...mapActions({
      likeFood: "food/likeFood",
      unLikeFood: "food/unLikeFood",
    }),
    nice() {
      const foodData = {
        user: this.loginUser.id,
        food: this.food.id,
      }
      if (this.like) {
        this.unLikeFood(foodData).then(() => {
          this.like = false
          console.log(this.like)
          this.heart = false
        })
      } else {
        this.likeFood(foodData).then(() => {
          console.log(this.like)
          this.heart = true
        })
      }
    },
    pagelink(link) {
      this.$router.push({ path: link })
    },
    // dolike() {
    //   this.like = false
    //   this.liking = []
    //   this.loginUser.foodlike.forEach((food) => {
    //     if (food.name === this.food.name) {
    //       this.liking.push(food.name)
    //     }
    //   })
    //   console.log(this.liking)
    //   console.log(this.food.name)
    //   if (this.liking[0] == this.food.name) {
    //     this.like = true
    //   } else {
    //     this.like = false
    //   }
    //   console.log(this.like)
    // },
  },
}
</script>
