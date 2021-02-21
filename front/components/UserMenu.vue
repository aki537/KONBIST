<template>
  <v-card class="pa-2">
    <div class="d-flex align-center mb-2 ml-2">
      <span class="title">{{ eatDate }}</span>
      <span class="title ml-10">{{ menu.timezone }}</span>
    </div>
    <v-divider />
    <food-list :foods="menu.choise_food" class="mb-1" />
    <v-divider />
    <div class="d-flex align-center my-2">
      <div class="body-1 ml-2">
        合計
        <span class="font-weight-bold">{{ totalCalorie }}</span>
        kcal
      </div>
      <div class="body-2 ml-16">
        炭水化物
        <span class="font-weight-bold">{{ totalCarbo }}</span>
        g
      </div>
      <div class="body-2 ml-3">
        タンパク質
        <span class="font-weight-bold">{{ totalProtein }}</span>
        g
      </div>
      <div class="body-2 ml-3">
        脂質
        <span class="font-weight-bold">{{ totalLipid }}</span>
        g
      </div>
    </div>
  </v-card>
</template>

<script>
import { mapGetters } from "vuex"
import foodList from "~/components/FoodList.vue"

export default {
  components: {
    foodList,
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
      eatDate: "",
      totalCalorie: 0,
      totalCarbo: 0.0,
      totalProtein: 0.0,
      totalLipid: 0.0,
    }
  },
  computed: {
    ...mapGetters({
      loginUser: "auth/loginUser",
      login: "auth/isLoggedIn",
    }),
  },
  mounted() {
    this.eatDate = this.$dayjs(this.menu.date).format("YYYY/MM/DD")
    let calorie = 0
    let carbo = 0
    let protein = 0
    let lipid = 0
    this.foods.forEach((food) => {
      calorie += food.calorie
      carbo += food.carbonhydrate
      protein += food.protein
      lipid += food.lipid
    })
    console.log(this.totalCalorie)
    this.totalCalorie = calorie
    this.totalCarbo = carbo.toFixed(1)
    this.totalProtein = protein.toFixed(1)
    this.totalLipid = lipid.toFixed(1)
  },
  methods: {},
}
</script>

<style scoped></style>
