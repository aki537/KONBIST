<template>
  <v-container>
    <h1 class="mt-7">検索</h1>
    <v-row class="mt-3">
      <v-col sm="3" cols="12">
        <v-select v-model="search" :items="items" label="検索項目" />
        <v-card elevation="1">
          <div class="ml-4 d-flex align-center">
            <v-checkbox
              v-if="search == 'フード'"
              v-model="allFood"
              dense
              label="全て表示"
            />
            <v-checkbox
              v-if="search == 'ユーザー'"
              v-model="allUser"
              dense
              label="全て表示"
            />
          </div>
        </v-card>
        <template v-if="search == 'フード'">
          <search-check-box @category="catchCategory" @maker="catchMaker" />
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
        <p class="ma-0 mb-1 caption font-weight-bold">
          検索結果
          <span v-if="search == 'フード' && resFoods.length" class="ml-4">{{resFoods.length}}件</span>
          <span v-if="search == 'ユーザー' && resUsers.length" class="ml-4">{{resUsers.length}}件</span>
        </p>
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
import searchCheckBox from "~/components/sort/SearchCheckBox.vue"

export default {
  components: {
    searchFood,
    userList,
    searchCheckBox,
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
      allFood: false,
      allUser: false,
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
    allFood() {
      this.resSearch()
    },
    allUser() {
      this.resSearch()
    },
  },
  created() {
    // const debounce = require('lodash.debounce')
    // this.delayFunc = debounce(this.resSearch(), 500)
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
      } else if (this.search == "フード" && this.allFood == true) {
        this.$axios
          .$get("api/v1/foods/search", {
            params: {
              search: "",
            },
          })
          .then((res) => {
            this.resFoods = res
          })
          .catch((error) => {
            console.log(error)
          })
      } else if (this.search == "ユーザー" && this.allUser == true) {
        this.$axios
          .$get("api/v1/users/search", {
            params: {
              search: "",
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
}
</script>

<style scoped>
.category {
  color: rgba(0, 0, 0, 0.54);
  font-size: 14px;
  font-weight: 700;
}
</style>
