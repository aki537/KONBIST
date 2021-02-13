<template>
  <v-card max-width="800px" flat>
    <v-list>
      <!-- <v-list-item-group> -->
      <v-row>
        <v-list-item
          v-for="food in foods"
          :key="food.id"
          :ripple="false"
          class="list"
        >
          <v-list-item-avatar>
            <v-img contain :src="food.image.url" />
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
          <food-card-menu class="item-action" :food="food" />
          <v-list-item-action>
            <v-btn icon color="green" class="mr-5" x-small>
              <v-icon> mdi-plus-thick </v-icon>
            </v-btn>
          </v-list-item-action>
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
}
</script>

<style scoped>
.tab {
  cursor: pointer;
}
.list-item {
  width: 100px;
}
.list:hover {
  transition: 0.3s;
  background-color: #f5f5f5;
}
.list {
  cursor: default;
}
</style>
