<template>
  <v-container>
    <h1 class="mt-7">トピック</h1>
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
              <winter-foods v-if="loading" :foods="foods" />
            </v-card>
          </v-tab-item>
        </v-tabs-items>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import winterFoods from "~/components/topic/WinterFoods.vue"

export default {
  components: {
    winterFoods,
  },
  data() {
    return {
      foods: [],
      loading: false,
      tab: null,
      items: [{ title: "冬のおすすめ" }],
    }
  },
  computed: {},
  created() {
    this.$axios.get("api/v1/winter_choises").then((res) => {
      console.log(res.data)
      this.foods = res.data
      this.loading = true
    })
  },
  methods: {},
}
</script>
