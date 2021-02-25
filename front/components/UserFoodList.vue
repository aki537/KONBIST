<template>
  <v-card flat style="background-color: #fbfbfb">
    <v-list style="background-color: #fbfbfb">
      <!-- <v-list-item-group> -->
      <v-row>
        <v-list-item
          v-for="food in foods"
          :key="food.id"
          :ripple="false"
          class="list"
        >
          <v-list-item-avatar>
            <v-img v-if="food.image.url" contain :src="food.image.url" />
            <v-img v-else contain :src="defaultImage" />
          </v-list-item-avatar>
          <v-list-item-title
            :to="{ path: `/food/${food.id}` }"
            class="list-item"
          >
            {{ food.name }}
          </v-list-item-title>
          <v-list-item-subtitle>
            {{ food.maker }}
          </v-list-item-subtitle>
          <food-card-menu :food="food" />
        </v-list-item>
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
  width: 100px;
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
