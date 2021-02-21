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
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-fade-transition>
    </v-expansion-panels>
    <template #append>
      <div class="mx-2">
        <v-card class="mb-2" color="grey darken-2">
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
              v-model="setTimezone"
              :items="timezone"
              label="時間帯"
              class="time-zone ml-6"
            />
          </v-card-text>
          <v-btn block color="blue" class="font-weight-bold">
            献立をセット
          </v-btn>
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
      today: "",
      setDay: "",
      setTimezone: "夜",
      timezone: ["朝", "昼", "夜", "深夜"],
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
    }),
  },
  mounted() {
    console.log("aaaa")
    this.today = new Date()
    this.setDay =
      this.today.getFullYear() +
      "-" +
      Number(this.today.getMonth() + 1) +
      "-" +
      this.today.getDate()
  },
  methods: {
    ...mapActions({
      deleteFood: "choise/deleteFood",
    }),
    deleteMenu(food) {
      this.deleteFood(food)
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
  font-size: 15px;
  line-height: 16px;
  color: white;
  margin: 12px 0 8px;
}
.product-spec-description {
  display: inline-block;
  vertical-align: top;
  font-size: 15px;
  line-height: 16px;
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
