<template>
  <v-container>
    <h1 class="mt-7">ランキング</h1>
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
              <total-rank :foods="totalRank" :cate="category" :make="maker" />
            </v-card>
          </v-tab-item>
          <v-tab-item>
            <v-card class="pa-3">
              <good-rank :foods="good" />
            </v-card>
          </v-tab-item>
          <v-tab-item>
            <v-card class="pa-3">
              <rate-rank :foods="rate" />
            </v-card>
          </v-tab-item>
        </v-tabs-items>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import totalRank from "~/components/ranking/TotalRank.vue"
import goodRank from "~/components/ranking/GoodRank.vue"
import rateRank from "~/components/ranking/RateRank.vue"
import checkbox from "~/components/sort/Checkbox.vue"

export default {
  components: {
    totalRank,
    goodRank,
    rateRank,
    checkbox,
  },
  data() {
    return {
      foods1: [],
      foods2: [],
      foods3: [],
      loading: false,
      items: [{ title: "総合順" }, { title: "いいね順" }, { title: "評価順" }],
      category: [],
      maker: [],
    }
  },
  computed: {
    totalRank() {
      return this.foods1
        .slice()
        .sort((a, b) => {
          if (a.avg_rate < b.avg_rate) return 1
          if (a.avg_rate > b.avg_rate) return -1
          if (a.like_users.length < b.like_users.length) return 1
          if (a.like_users.length > b.like_users.length) return -1
          return 0
        })
        .slice(0, 50)
    },
    good() {
      return this.foods2
        .slice()
        .sort((a, b) => {
          if (a.like_users.length < b.like_users.length) return 1
          if (a.like_users.length > b.like_users.length) return -1
          return 0
        })
        .slice(0, 50)
    },
    rate() {
      return this.foods3
        .slice()
        .sort((a, b) => {
          if (a.avg_rate < b.avg_rate) return 1
          if (a.avg_rate > b.avg_rate) return -1
          return 0
        })
        .slice(0, 50)
    },
    tab: {
      get() {
        return this.$store.state.tab.rankingTab
      },
      set(val) {
        this.$store.dispatch("tab/getRankingTab", val)
      },
    },
  },
  created() {
    this.$axios.get("api/v1/foods").then((res) => {
      console.log(res.data)
      this.foods1 = res.data
      this.foods2 = res.data
      this.foods3 = res.data
      this.loading = true
    })
  },
  methods: {
    catchCategory(category) {
      this.category = category
    },
    catchMaker(maker) {
      this.maker = maker
    },
  },
}
</script>
