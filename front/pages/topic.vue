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
        <checkbox @category="catchCategory" @maker="catchMaker" />
      </v-col>
      <v-col sm="9" cols="12">
        <v-tabs-items v-model="tab">
          <v-tab-item>
            <v-card class="pa-3">
              <winter-foods
                v-if="loading"
                :foods="recoFoods"
                :cate="category"
                :make="maker"
              />
            </v-card>
          </v-tab-item>
          <v-tab-item>
            <v-card class="pa-3">
              <winter-foods
                v-if="loading"
                :foods="foods"
                :cate="category"
                :make="maker"
              />
            </v-card>
          </v-tab-item>
        </v-tabs-items>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { mapMutations } from "vuex"
import winterFoods from "~/components/topic/WinterFoods.vue"
import checkbox from "~/components/sort/Checkbox.vue"

export default {
  components: {
    winterFoods,
    checkbox,
  },
  data() {
    return {
      foods: [],
      recoFoods: [],
      loading: false,
      items: [{ title: "おすすめ" }, { title: "冬のおすすめ" }],
      category: [],
      maker: [],
    }
  },
  computed: {
    tab: {
      get() {
        return this.$store.state.topic.tab
      },
      set(val) {
        this.setTab(val)
      },
    },
  },
  created() {
    this.$axios.get("api/v1/recommends").then((res) => {
      console.log(res.data)
      this.recoFoods = res.data
      this.loading = true
    })
    this.$axios.get("api/v1/winter_choises").then((res) => {
      console.log(res.data)
      this.foods = res.data
    })
  },
  methods: {
    ...mapMutations({ setTab: "topic/setTab" }),
    catchCategory(category) {
      this.category = category
    },
    catchMaker(maker) {
      this.maker = maker
    },
  },
}
</script>
