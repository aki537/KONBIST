<template>
  <v-card flat>
    <v-list>
      <!-- <v-list-item-group> -->
      <v-row>
        <template v-for="(food, i) in foods">
          <v-list-item :key="food.id" :ripple="false" class="list">
            <v-list-item-avatar>
              <v-img v-if="food.image.url" contain :src="food.image.url" />
              <v-img v-else contain :src="defaultImage" />
            </v-list-item-avatar>
            <v-list-item-title
              :to="{ path: `/food/${food.id}` }"
              class="list-item"
            >
              {{ i + 1 }}<span class="ml-3">{{ food.name }}</span>
            </v-list-item-title>
            <v-list-item-subtitle>
              {{ food.maker }}
            </v-list-item-subtitle>
            <div class="mr-1">
              <v-rating
                v-model="food.avg_rate"
                background-color="orange lighten-1"
                color="orange darken-2"
                readonly
                half-increments
                dense
                x-small
              />
              <span class="pl-7">{{ food.avg_rate }}</span>
            </div>
            <div class="mr-2">
              <v-icon> mdi-silverware-fork-knife </v-icon>
              <span class="pl-2">{{ food.like_users.length }}</span>
            </div>
            <food-card-menu :food="food" />
          </v-list-item>
        </template>
      </v-row>
      <!-- </v-list-item-group> -->
    </v-list>
  </v-card>
</template>

<script>
import foodCardMenu from "~/components/FoodCardMenu.vue"

export default {
  components: {
    foodCardMenu,
  },
  props: {
    foods: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      defaultImage: require("@/assets/images/default.png"),
    }
  },
}
</script>

<style scoped>
.tab {
  cursor: pointer;
}
.list-item {
  cursor: pointer;
}
.list:hover {
  transition: 0.3s;
  background-color: #f5f5f5;
}
.list {
  cursor: default;
}
</style>
