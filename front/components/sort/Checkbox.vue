<template>
  <div>
    <v-card elevation="1">
      <p class="ma-0 mt-12 py-2 text-center category">カテゴリ</p>
      <v-divider class="mb-1" />
      <div class="check-box ml-4">
        <v-checkbox
          v-model="categorySort.onigiri"
          dense
          label="おにぎり"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.bento"
          dense
          label="お弁当"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.sandwich"
          dense
          label="サンドイッチ"
          class="box"
        />
        <v-checkbox v-model="categorySort.pan" dense label="パン" class="box" />
        <v-checkbox
          v-model="categorySort.noudle"
          dense
          label="麺類"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.sideDish"
          dense
          label="惣菜"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.soup"
          dense
          label="スープ"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.salad"
          dense
          label="サラダ"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.fried"
          dense
          label="揚げ物"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.chinese"
          dense
          label="中華まん"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.gratin"
          dense
          label="グラタン・ドリア"
          class="box"
        />
        <v-checkbox
          v-model="categorySort.dessert"
          dense
          label="デザート"
          class="box"
        />
      </div>
    </v-card>
    <v-card class="pb-4" elevation="1">
      <p class="ma-0 mt-2 py-2 text-center category">ブランド</p>
      <v-divider class="mb-1" />
      <div class="ml-4">
        <v-checkbox
          v-model="makerSort.seven"
          dense
          label="セブンイレブン"
          class="box mt-0"
        />
        <v-checkbox
          v-model="makerSort.loson"
          dense
          label="ローソン"
          class="box"
        />
        <v-checkbox
          v-model="makerSort.famima"
          dense
          label="ファミリーマート"
          class="box"
        />
        <v-checkbox
          v-model="makerSort.mini"
          dense
          label="ミニストップ"
          class="box"
        />
      </div>
    </v-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      categorySort: [
        { onigiri: false },
        { bento: false },
        { sandwich: false },
        { pan: false },
        { noudle: false },
        { sideDish: false },
        { soup: false },
        { salad: false },
        { fried: false },
        { chinese: false },
        { gratin: false },
        { dessert: false },
      ],
      makerSort: [
        { seven: false },
        { louson: false },
        { famima: false },
        { mini: false },
      ],
    }
  },
  mounted() {
    this.$emit("category", this.categorySort)
    this.$emit("maker", this.makerSort)
  },
}
</script>

<style scoped>
.box {
  height: 17px;
}
.check-box {
  overflow: scroll;
  max-height: 230px;
}
.category {
  color: rgba(0, 0, 0, 0.54);
  font-size: 14px;
  font-weight: 700;
}
</style>
