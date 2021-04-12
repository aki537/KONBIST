<template>
  <v-navigation-drawer
    v-model="drawer"
    :clipped="clipped"
    fixed
    stateless
    app
    dark
    max-width="300"
  >
    <v-card
      class="white--text d-flex justify-center font-weight-bold mx-2 mt-1 pa-1"
      color="grey darken-1"
    >
      選択中
    </v-card>
    <template v-if="foods != []">
      <v-expansion-panels class="px-2" accordion>
        <v-fade-transition group hide-on-leave>
          <v-expansion-panel v-for="food in foods" :key="food.id">
            <v-expansion-panel-header class="d-flex">
              <v-avatar
                size="40"
                class="small-image"
                max-width="40"
                color="white"
              >
                <v-img
                  v-if="food.image.url"
                  :src="food.image.url"
                  alt="avatar"
                  contain
                />
                <v-img v-else :src="defaultImage" contain />
              </v-avatar>
              <span class="font-weight-bold ml-1">{{ food.name }}</span>
            </v-expansion-panel-header>
            <div class="d-flex justify-space-around">
              <v-btn
                small
                color="blue white--text"
                class="font-weight-bold"
                :to="{ path: `/food/${food.id}` }"
              >
                詳細
              </v-btn>
              <v-btn
                small
                class="font-weight-bold"
                color="red"
                text
                @click="deleteMenu(food)"
              >
                削除
              </v-btn>
            </div>
            <v-expansion-panel-content class="mt-2">
              <p>カロリー：{{ food.calorie }}kcal</p>
              <p>炭水化物：{{ food.carbonhydrate }}g</p>
              <p>タンパク質：{{ food.protein }}g</p>
              <p>脂質：{{ food.lipid }}g</p>
              <p>価格：{{ food.price }}円</p>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-fade-transition>
      </v-expansion-panels>
    </template>
    <template #append>
      <div class="mx-2">
        <v-card class="mb-1" color="grey darken-2">
          <v-card-title class="justify-center total font-weight-bold">
            合計
          </v-card-title>
          <v-divider />
          <v-card-text class="total-text">
            <dl class="product-spec-list">
              <dt class="product-spec-term font-weight-bold">カロリー</dt>
              <dd class="product-spec-description">
                <span class="font-weight-black">{{ calorie }}</span>
                <span>kacl</span>
              </dd>
            </dl>
            <dl class="product-spec-list">
              <dt class="product-spec-term font-weight-bold">炭水化物</dt>
              <dd class="product-spec-description">
                <span class="font-weight-black">{{ carbo }}</span>
                <span>g</span>
              </dd>
            </dl>
            <dl class="product-spec-list">
              <dt class="product-spec-term font-weight-bold">タンパク質</dt>
              <dd class="product-spec-description">
                <span class="font-weight-black">{{ protein }}</span>
                <span>g</span>
              </dd>
            </dl>
            <dl class="product-spec-list">
              <dt class="product-spec-term font-weight-bold">脂質</dt>
              <dd class="product-spec-description">
                <span class="font-weight-black">{{ lipid }}</span>
                <span>g</span>
              </dd>
            </dl>
            <dl class="product-spec-list">
              <dt class="product-spec-term font-weight-bold">価格</dt>
              <dd class="product-spec-description">
                <span class="font-weight-black">{{ price }}</span>
                <span>円</span>
              </dd>
            </dl>
          </v-card-text>
          <v-card-text class="total d-flex px-1">
            <v-menu
              ref="menu"
              v-model="menu"
              :close-on-content-click="false"
              :return-value.sync="setDay"
              transition="scale-transition"
              offset-y
              min-width="auto"
            >
              <template #activator="{ on, attrs }">
                <v-text-field
                  v-model="setDay"
                  label="食べる日"
                  readonly
                  v-bind="attrs"
                  v-on="on"
                />
              </template>
              <v-date-picker v-model="setDay" no-title scrollable>
                <v-spacer></v-spacer>
                <v-btn text color="primary" @click="menu = false">
                  Cancel
                </v-btn>
                <v-btn text color="primary" @click="$refs.menu.save(setDay)">
                  OK
                </v-btn>
              </v-date-picker>
            </v-menu>
            <v-select
              v-model="timeNumber"
              item-text="state"
              item-value="number"
              :items="timezone"
              label="時間帯"
              class="time-zone ml-6"
            />
          </v-card-text>
          <v-btn block color="blue" class="font-weight-bold" @click="setMenu">
            メニューをセット
          </v-btn>
          <!-- <v-btn block color="blue" class="font-weight-bold" @click="setMenu">
            メニューをセット
          </v-btn> -->
        </v-card>
      </div>
    </template>
  </v-navigation-drawer>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  data() {
    return {
      clipped: true,
      fixed: false,
      total: 0.0,
      defaultImage: require("@/assets/images/default.png"),
      menu: false,
      choise: false,
      today: "",
      setDay: "",
      timeNumber: 2,
      timezone: [
        { state: "朝食", number: 0 },
        { state: "昼食", number: 1 },
        { state: "夕食", number: 2 },
        { state: "夜食", number: 3 },
      ],
      setTimezone: "",
    }
  },
  computed: {
    ...mapGetters({
      drawer: "choise/drawer",
      foods: "choise/foods",
      calorie: "choise/calorie",
      carbo: "choise/carbo",
      protein: "choise/protein",
      lipid: "choise/lipid",
      price: "choise/price",
    }),
  },
  mounted() {
    this.today = new Date()
    this.setDay =
      this.today.getFullYear() +
      "-" +
      Number(this.today.getMonth() + 1) +
      "-" +
      this.today.getDate()
  },
  // watch: {
  //   choiseMenu() {
  //     // メニューが選択されてるか確認
  //     if (this.foods) {
  //     }
  //   },
  // },
  methods: {
    ...mapActions({
      deleteFood: "choise/deleteFood",
      registerFoods: "choise/registerFoods",
    }),
    deleteMenu(food) {
      this.deleteFood(food)
    },
    setMenu() {
      switch (this.timeNumber) {
        case 0:
          this.setTimezone = "朝食"
          break
        case 1:
          this.setTimezone = "昼食"
          break
        case 2:
          this.setTimezone = "夕食"
          break
        case 3:
          this.setTimezone = "夜食"
      }
      this.registerFoods({
        day: this.setDay,
        zone: this.setTimezone,
        number: this.timeNumber,
      })
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
.total {
  padding: 0;
}
.total-text {
  padding-top: 0;
}
.product-spec-list {
  border-bottom: 1px solid #e7e7e7;
  margin: 0;
}
.product-spec-term {
  display: inline-block;
  vertical-align: top;
  width: 100px;
  font-size: 13px;
  line-height: 9px;
  color: white;
  margin: 12px 0 8px;
}
.product-spec-description {
  display: inline-block;
  vertical-align: top;
  font-size: 15px;
  line-height: 9px;
  letter-spacing: 0.4px;
  color: white;
  font-weight: 400;
  margin: 12px 0 8px;
  white-space: pre-wrap;
}
.time-zone {
  max-width: 85px;
}
</style>
