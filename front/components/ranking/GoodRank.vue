<template>
  <v-card flat>
    <v-list>
      <v-row>
        <template v-for="(food, i) in total">
          <v-list-item :key="food.id" :ripple="false" class="list">
            <v-list-item-avatar tile>
              <v-img v-if="food.image.url" contain :src="food.image.url" />
              <v-img v-else contain :src="defaultImage" />
            </v-list-item-avatar>
            <v-list-item-title class="list-item" @click="pagelink(food.id)">
              {{ i + 1 }}<span class="ml-3">{{ food.name }}</span>
            </v-list-item-title>
            <v-list-item-subtitle>
              {{ food.maker }}
            </v-list-item-subtitle>
            <div class="mr-2">
              <v-icon> mdi-silverware-fork-knife </v-icon>
              <span class="pl-2">{{ food.like_users.length }}</span>
            </div>
            <food-card-menu :food="food" />
          </v-list-item>
        </template>
      </v-row>
    </v-list>
  </v-card>
</template>

<script>
import foodCardMenu from "~/components/FoodCardMenu.vue"

export default {
  components: {
    foodCardMenu,
  },
  props: {
    foods: {
      type: Array,
      required: true,
    },
    cate: {
      type: Array,
      required: true,
    },
    make: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      defaultImage: require("@/assets/images/default.png"),
    }
  },
  computed: {
    sortFoods() {
      const result = []
      if (this.cate.onigiri) {
        this.foods.filter((value) => {
          if (value.category.indexOf("おにぎり") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.bento) {
        this.foods.filter((value) => {
          if (value.category.indexOf("お弁当") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.sandwich) {
        this.foods.filter((value) => {
          if (value.category.indexOf("サンドイッチ") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.pan) {
        this.foods.filter((value) => {
          if (value.category.indexOf("パン") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.noudle) {
        this.foods.filter((value) => {
          if (value.category.indexOf("麺類") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.sideDish) {
        this.foods.filter((value) => {
          if (value.category.indexOf("惣菜") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.soup) {
        this.foods.filter((value) => {
          if (value.category.indexOf("スープ") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.salad) {
        this.foods.filter((value) => {
          if (value.category.indexOf("サラダ") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.fried) {
        this.foods.filter((value) => {
          if (value.category.indexOf("揚げ物") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.chinese) {
        this.foods.filter((value) => {
          if (value.category.indexOf("中華まん") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.gratin) {
        this.foods.filter((value) => {
          if (value.category.indexOf("グラタン・ドリア") !== -1) {
            result.push(value)
          }
        })
      }
      if (this.cate.dessert) {
        this.foods.filter((value) => {
          if (value.category.indexOf("デザート") !== -1) {
            result.push(value)
          }
        })
      }
      if (
        !this.cate.onigiri &&
        !this.cate.bento &&
        !this.cate.sandwich &&
        !this.cate.pan &&
        !this.cate.noudle &&
        !this.cate.sideDish &&
        !this.cate.soup &&
        !this.cate.salad &&
        !this.cate.fried &&
        !this.cate.chinese &&
        !this.cate.gratin &&
        !this.cate.dessert
      ) {
        this.foods.filter((value) => {
          result.push(value)
        })
      }
      return result
    },
    total() {
      const result = this.sortFoods
      const res = []
      if (this.make.seven) {
        result.filter((value) => {
          if (value.maker.indexOf("セブンイレブン") !== -1) {
            res.push(value)
          }
        })
      }
      if (this.make.loson) {
        result.filter((value) => {
          if (value.maker.indexOf("ローソン") !== -1) {
            res.push(value)
          }
        })
      }
      if (this.make.famima) {
        result.filter((value) => {
          if (value.maker.indexOf("ファミリーマート") !== -1) {
            res.push(value)
          }
        })
      }
      if (this.make.mini) {
        result.filter((value) => {
          if (value.maker.indexOf("ミニストップ") !== -1) {
            res.push(value)
          }
        })
      }
      if (
        !this.make.seven &&
        !this.make.loson &&
        !this.make.famima &&
        !this.make.mini
      ) {
        result.filter((value) => {
          res.push(value)
        })
      }
      return res
        .slice()
        .sort((a, b) => {
          if (a.like_users.length < b.like_users.length) return 1
          if (a.like_users.length > b.like_users.length) return -1
          return 0
        })
        .slice(0, 50)
    },
  },
  methods: {
    pagelink(link) {
      this.$router.push({ path: `/food/${link}` })
    },
  },
}
</script>

<style scoped>
.tab {
  cursor: pointer;
}
.list-item {
  width: 100px;
  cursor: pointer;
}
.list:hover {
  transition: 0.3s;
  background-color: #f5f5f5;
}
.list {
  cursor: default;
}
</style>
