<template>
  <v-card v-if="status" class="pa-2">
    <div class="d-flex align-center mb-2 ml-2">
      <span class="body-1 ml-2">{{ menu.timezone }}</span>
      <span class="body-2 ml-8">{{ totalPrice }}円</span>
    </div>
    <v-divider />
    <food-list :foods="menu.choise_food" class="mb-1" />
    <v-divider />
    <div class="d-flex align-center my-2">
      <div class="caption ml-2">
        合計
        <span class="font-weight-bold">{{ totalCalorie }}</span>
        kcal
      </div>
      <div class="caption ml-16">
        炭水化物
        <span class="font-weight-bold">{{ totalCarbo }}</span>
        g
      </div>
      <div class="caption ml-3">
        タンパク質
        <span class="font-weight-bold">{{ totalProtein }}</span>
        g
      </div>
      <div class="caption ml-3">
        脂質
        <span class="font-weight-bold">{{ totalLipid }}</span>
        g
      </div>
      <v-spacer />
      <template v-if="login">
        <delete-food-menu :menu="menu" />
      </template>
    </div>
  </v-card>
</template>

<script>
import { mapGetters } from "vuex"
import foodList from "~/components/FoodList.vue"
import deleteFoodMenu from "~/components/DeleteFoodMenu.vue"

export default {
  components: {
    foodList,
    deleteFoodMenu,
  },
  props: {
    menu: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      defaultImage: require("@/assets/images/default.png"),
      foods: this.menu.choise_food,
      status: true,
      totalCalorie: 0,
      totalCarbo: 0.0,
      totalProtein: 0.0,
      totalLipid: 0.0,
      totalPrice: 0,
    }
  },
  computed: {
    ...mapGetters({
      loginUser: "auth/loginUser",
      login: "auth/isLoggedIn",
    }),
  },
  mounted() {
    let calorie = 0
    let carbo = 0
    let protein = 0
    let lipid = 0
    let price = 0
    this.foods.forEach((food) => {
      calorie += food.calorie
      carbo += food.carbonhydrate
      protein += food.protein
      lipid += food.lipid
      price += food.price
    })
    this.totalCalorie = calorie
    this.totalPrice = price
    this.totalCarbo = carbo.toFixed(1)
    this.totalProtein = protein.toFixed(1)
    this.totalLipid = lipid.toFixed(1)
  },
  methods: {},
}
</script>

<style scoped></style>
