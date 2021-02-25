<template>
  <v-container class="mx-10">
    <h1 class="mt-6">新発売</h1>
    <v-row class="mt-3">
      <v-col sm="3" cols="12">
        <v-card>
          <v-tabs v-model="tab" vertical>
            <v-tab v-for="(item, i) in items" :key="i">
              <span class="font-weight-bold">{{ item.title }}</span>
            </v-tab>
          </v-tabs>
        </v-card>
      </v-col>
      <v-col sm="9" cols="12">
        <v-tabs-items v-model="tab">
          <v-tab-item>
            <v-card class="pa-3">
              <new-food-list v-if="loading" :foods="newFoods" />
            </v-card>
          </v-tab-item>
          <v-tab-item>
            <v-card class="pa-3">
              <new-food-list :foods="newPlanFoods" />
            </v-card>
          </v-tab-item>
        </v-tabs-items>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import newFoodList from "~/components/newFood/NewFoodList.vue"

export default {
  components: {
    newFoodList,
  },
  data() {
    return {
      newFoods: [],
      newPlanFoods: [],
      loading: false,
      tab: null,
      items: [{ title: "発売中" }, { title: "発売予定" }],
    }
  },
  computed: {},
  created() {
    this.$axios.get("api/v1/new_plan_food").then((res) => {
      console.log(res.data)
      this.newPlanFoods = res.data
    })
    this.$axios.get("api/v1/new_food").then((res) => {
      console.log(res.data)
      this.newFoods = res.data
      this.loading = true
    })
  },
  methods: {},
}
</script>
