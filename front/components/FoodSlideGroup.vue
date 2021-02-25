<template>
  <v-card flat>
    <v-list class="mx-10">
      <v-row>
        <v-list-item
          v-for="(food, i) in foods"
          :key="food.id"
          dense
          class="list"
        >
          <nuxt-link :to="{ path: `/food/${food.id}` }">
            <v-list-item-avatar tile size="45">
              <v-img v-if="food.image.url" contain :src="food.image.url" />
              <v-img v-else contain :src="defaultImage" />
            </v-list-item-avatar>
          </nuxt-link>
          <v-list-item-content>
            <v-list-item-title class="list-item" @click="pagelink(food.id)">
              {{ i + number }}&emsp;&nbsp;{{ food.name }}
            </v-list-item-title>
            <v-list-item-subtitle class="ml-6">
              {{ food.maker }}
            </v-list-item-subtitle>
          </v-list-item-content>
          <food-card-menu :food="food" />
        </v-list-item>
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
    number: {
      type: Number,
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
.list-item:hover {
  opacity: 0.7;
  cursor: pointer;
}
.list:hover {
  background-color: #f5f5f5;
}
</style>
