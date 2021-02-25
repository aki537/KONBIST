<template>
  <v-card flat>
    <v-list>
      <v-row>
        <template v-for="food in foods">
          <v-list-item :key="food.id" :ripple="false" class="list">
            <div class="release">{{ food.release }}</div>
            <v-list-item-avatar>
              <v-img v-if="food.image.url" contain :src="food.image.url" />
              <v-img v-else contain :src="defaultImage" />
            </v-list-item-avatar>
            <v-list-item-title class="list-item" @click="pagelink(food.id)">
              <span class="ml-3">{{ food.name }}</span>
            </v-list-item-title>
            <v-list-item-subtitle>
              {{ food.maker }}
            </v-list-item-subtitle>
            <food-card-menu :food="food" />
          </v-list-item>
        </template>
      </v-row>
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
  methods: {
    pagelink(link) {
      this.$router.push({ path: `/food/${link}` })
    },
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
.release {
  width: 300px;
}
</style>
