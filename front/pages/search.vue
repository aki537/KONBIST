<template>
  <v-container>
    <h1 class="mt-7">検索</h1>
    <v-row class="mt-3">
      <v-col sm="3" cols="12">
        <v-select v-model="search" :items="items" label="検索項目" />
        <template v-if="search == 'フード'">
          <checkbox @category="catchCategory" @maker="catchMaker" />
        </template>
      </v-col>
      <v-col sm="9" cols="12">
        <v-text-field
          v-model="searchForm"
          solo
          label="検索ワード"
          prepend-inner-icon="mdi-magnify"
          class="py-2"
        />
        <p class="ma-0 mb-1 caption font-weight-bold">検索結果</p>
        <v-divider class="mb-2" />
        <template v-if="search == 'フード' && resFoods.length">
          <search-food :foods="resFoods" :cate="category" :make="maker" />
        </template>
        <template v-if="search == 'ユーザー' && resUsers.length">
          <user-list :users="resUsers" />
        </template>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import _debounce from "lodash.debounce"
import searchFood from "~/components/search/SearchFood.vue"
import userList from "~/components/UserList.vue"
// import rateRank from "~/components/ranking/RateRank.vue"
import checkbox from "~/components/sort/Checkbox.vue"

export default {
  components: {
    searchFood,
    userList,
    checkbox,
  },
  data() {
    return {
      loading: false,
      items: ["フード", "ユーザー"],
      category: [],
      maker: [],
      searchForm: "",
      resFoods: [],
      resUsers: [],
    }
  },
  computed: {
    search: {
      get() {
        return this.$store.state.tab.search
      },
      set(val) {
        this.$store.dispatch("tab/getSearch", val)
      },
    },
  },
  watch: {
    searchForm() {
      _debounce(this.resSearch, 500)()
    },
  },
  methods: {
    resSearch() {
      if (this.search == "フード" && this.searchForm) {
        this.$axios
          .$get("api/v1/foods/search", {
            params: {
              search: this.searchForm,
            },
          })
          .then((res) => {
            this.resFoods = res
          })
          .catch((error) => {
            console.log(error)
          })
      } else if (this.search == "ユーザー" && this.searchForm) {
        this.$axios
          .$get("api/v1/users/search", {
            params: {
              search: this.searchForm,
            },
          })
          .then((res) => {
            this.resUsers = res
          })
          .catch((error) => {
            console.log(error)
          })
      } else {
        this.resFoods = []
        this.resUsers = []
      }
    },
    catchCategory(category) {
      this.category = category
    },
    catchMaker(maker) {
      this.maker = maker
    },
  },
  created () {
    // const debounce = require('lodash.debounce')
    // this.delayFunc = debounce(this.resSearch(), 500)
  }
}
</script>
