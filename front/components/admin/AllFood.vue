<template>
  <div>
    <v-card v-for="food in foods" :key="food.id" class="mx-2 my-3">
      <div class="d-flex">
        <v-avatar size="40" class="ml-1" tile>
          <v-img :src="food.image.url" contain></v-img>
        </v-avatar>
        <nuxt-link :to="{ path: `/food/${food.id}` }">
          {{ food.name }}
        </nuxt-link>
        <v-spacer />
        <v-menu open-on-hover bottom offset-y>
          <template #activator="{ on, attrs }">
            <v-btn small color="primary" dark v-bind="attrs" v-on="on">
              トピック
            </v-btn>
          </template>

          <v-list dense>
            <v-list-item link>
              <v-list-item-title
                v-if="food.winter_choises[0]"
                @click="noWinter(food.winter_choises[0].id)"
              >
                冬のおすすめから解除
              </v-list-item-title>
              <v-list-item-title v-else @click="winter(food.id)">
                冬のおすすめに追加
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
        <food-edit :food="food" />
        <v-btn
          small
          color="red darken-3 white--text"
          @click="deleteFood(food.id)"
        >
          削除
        </v-btn>
      </div>
      <div class="caption">
        <span>価格:{{ food.price }}円</span>
        <span>カロリー:{{ food.calorie }}kcl</span>
        <span>炭水化物:{{ food.carbonhydrate }}g</span>
        <span>タンパク質:{{ food.protein }}g</span>
        <span>脂質:{{ food.lipid }}g</span>
        <span>発売日:{{ food.release }}</span>
        <span>カテゴリ:{{ food.category }}</span>
        <span>ブランド:{{ food.maker }}</span>
      </div>
      <div class="caption">
        トピック:
        <span v-if="food.winter_choises[0]">冬のおすすめ</span>
      </div>
    </v-card>
  </div>
</template>

<script>
import foodEdit from "~/components/admin/FoodEdit.vue"

export default {
  components: {
    foodEdit,
  },
  props: {
    foods: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {}
  },
  methods: {
    deleteFood(id) {
      this.$axios
        .delete(`api/v1/foods/${id}`)
        .then((res) => {
          console.log(res.data)
          console.log("フード削除")
        })
        .catch((err) => {
          console.log(err)
        })
    },
    winter(id) {
      this.$axios
        .post("api/v1/winter_choises", {
          food_id: id,
        })
        .then((res) => {
          console.log(res.data)
          console.log("冬のおすすめ追加")
        })
        .catch((err) => {
          console.log(err)
        })
    },
    noWinter(id) {
      this.$axios
        .delete(`api/v1/winter_choises/${id}`)
        .then((res) => {
          console.log(res.data)
          console.log("冬のおすすめから削除")
        })
        .catch((err) => {
          console.log(err)
        })
    },
  },
}
</script>
