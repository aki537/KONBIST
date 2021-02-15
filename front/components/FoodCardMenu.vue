<template>
  <v-menu
    :key="login"
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
      <template v-if="like">
        <v-btn v-bind="attrs" icon text :ripple="false" v-on="on">
          <v-icon color="red" v-on="on"> mdi-heart </v-icon>
        </v-btn>
      </template>
      <template v-else>
        <v-btn v-bind="attrs" icon text color="grey" :ripple="false" v-on="on">
          <v-icon v-on="on"> mdi-dots-horizontal </v-icon>
        </v-btn>
      </template>
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
        <template v-if="login">
          <v-btn v-if="like" block depressed text class="py-6" @click="nice">
            食べたいから解除
          </v-btn>
          <v-btn v-else block depressed text class="py-6" @click="nice">
            食べたい！
          </v-btn>
        </template>
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
      like: Boolean,
      users: this.food.like_users,
    }
  },
  computed: {
    ...mapGetters({
      user: "user/user",
      loginUser: "auth/loginUser",
      currentUser: "auth/currentUser",
      login: "auth/isLoggedIn",
    }),
    update() {
      return this.$store.state.auth.isLoggedIn
    },
  },
  watch: {
    update() {
      if (this.login) {
        this.loginUser.foodlike.forEach((food) => {
          if (food.name === this.food.name) {
            this.liking.push(food.name)
          }
        })
        if (this.liking[0] === this.food.name) {
          this.like = true
        } else {
          this.like = false
        }
      } else {
        this.like = false
      }
    },
  },
  created() {
    if (this.login) {
      this.loginUser.foodlike.forEach((food) => {
        if (food.name === this.food.name) {
          this.liking.push(food.name)
        }
      })
      if (this.liking[0] === this.food.name) {
        this.like = true
      } else {
        this.like = false
      }
    } else {
      this.like = false
    }
  },
  // beforeUpdate() {
  //   if (this.login) {
  //     this.liking = []
  //     this.loginUser.foodlike.forEach((food) => {
  //       if (food.name === this.food.name) {
  //         this.liking.push(food.name)
  //       }
  //     })
  //     if (this.liking[0] === this.food.name) {
  //       this.like = true
  //     } else {
  //       this.like = false
  //     }
  //   } else {
  //     this.like = false
  //   }
  // },
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
        })
      } else {
        this.likeFood(foodData).then(() => {
          console.log(this.like)
          this.like = true
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
