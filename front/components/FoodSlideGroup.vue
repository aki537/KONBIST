<template>
  <v-card 
    width="548px" 
    flat 
  >
    <v-list>
      <v-row>
        <v-list-item
          v-for="(food, i) in foods" 
          :key="food.id"
          :to="{ path: `/food/${food.id}`}"
        >
          <v-list-item-avatar>
            <v-img
              contain
              :src="food.image.url"
              
            />
          </v-list-item-avatar>
          <v-list-item-content
          :to="{ path: `/food/${food.id}`}">
          <v-list-item-title class="list-item">
            {{ i + number }}&emsp;&nbsp;{{food.name}}
          </v-list-item-title>
          <v-list-item-subtitle class="ml-6">
            {{ food.maker }}
          </v-list-item-subtitle>
          </v-list-item-content>
          <v-list-item-icon>
            <v-btn
              icon
              color="green"
              class="mr-5"
              x-small
              to="/food/create"
            >
              <v-icon>
                mdi-plus-thick
              </v-icon>
            </v-btn>
            <v-btn
              icon
              color="grey"
              class="mr-16"
              x-small
              to="/food/create"
            >
              <v-icon>
                mdi-dots-horizontal
              </v-icon>
            </v-btn>
          </v-list-item-icon>
        </v-list-item>
      </v-row>
    </v-list>
  </v-card>      
</template>

<script>
export default {
  props: ['foods', 'number']
}
</script>

<style>
.tab {
  cursor: pointer;
}
.list-item {
  width: 100px;
}
</style>