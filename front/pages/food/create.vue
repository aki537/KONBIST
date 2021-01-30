<template>
  <v-app>
    <v-container>
      <v-card width="400px" class="mx-auto mt-5">
        <v-card-title>
          <h1 class="display-1">
            フード投稿
          </h1>
        </v-card-title>
        <v-card-text>
          <v-form ref="form" lazy-validation>
            <v-text-field
              v-model="food.name"
              placeholder="例:大盛りご飯スタミナ豚丼"
              label="商品名"
            />
            <v-textarea
              v-model="food.details"
              placeholder="例:にんにくの効いた甘くて濃いタレで仕上げた豚丼。"
              label="商品詳細"
            />
            <v-text-field
              v-model="food.calorie"
              placeholder="例:739"
              label="カロリー"
            />
            <v-text-field
              v-model="food.carbohydrate"
              placeholder="例:112.0"
              label="炭水化物"
            />
            <v-text-field
              v-model="food.protein"
              placeholder="例:26.4"
              label="タンパク質"
            />
            <v-text-field
              v-model="food.lipid"
              placeholder="例:21.1"
              label="脂質"
            />
            <v-select
              :items="food.category"
              label="カテゴリー"
            />
            <v-select
              :items="food.maker"
              label="販売メーカー"
            />
            <v-card-actions>
              <v-btn
                color="light-green darken-1"
                class="white--text"
                @click="foodCreate"
              >
                保存する
              </v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </v-container>
  </v-app>
</template>

<script>
export default {
  data() {
    return {
      food: {
        name: '',
        details: '',
        calorie: '',
        carbohydrate: '',
        protein: '',
        lipid: '',
        category: ['おにぎり', 'お弁当', 'パン', '麺類', '惣菜', 'サラダ', 'お寿司', '揚げ物', 'その他'],
        maker: ['セブンイレブン', 'ファミリーマート', 'ローソン', 'ミニストップ']
      }
    }
  },
  methods: {
    
  }
}
</script>