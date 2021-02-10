<template>
  <v-app>
    <v-container>
      <v-card width="400px" class="mx-auto mt-5">
        <v-card-title>
          <h1 class="display-1">フード投稿</h1>
        </v-card-title>
        <v-card-text>
          <v-form ref="form" lazy-validation>
            <v-file-input
              accept="image/png, image/jpeg, image/bmp"
              outlined
              label="商品画像"
              @change="setImage"
            />
            <v-text-field
              v-model="name"
              placeholder="例:大盛りご飯スタミナ豚丼"
              label="商品名"
            />
            <v-textarea
              v-model="details"
              placeholder="例:にんにくの効いた甘くて濃いタレで仕上げた豚丼。"
              label="商品詳細"
            />
            <v-text-field
              v-model.number="calorie"
              placeholder="例:739"
              label="カロリー"
            />
            <v-text-field
              v-model.number="carbonhydrate"
              placeholder="例:112.0"
              label="炭水化物"
            />
            <v-text-field
              v-model.number="protein"
              placeholder="例:26.4"
              label="タンパク質"
            />
            <v-text-field
              v-model.number="lipid"
              placeholder="例:21.1"
              label="脂質"
            />
            <v-select
              v-model="category"
              :items="categoryList"
              label="カテゴリー"
            />
            <v-select v-model="maker" :items="makerList" label="販売メーカー" />
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
      name: "",
      image: "",
      details: "",
      calorie: "",
      carbonhydrate: "",
      protein: "",
      lipid: "",
      category: "",
      maker: "",
      categoryList: [
        "おにぎり",
        "お弁当",
        "パン",
        "麺類",
        "惣菜",
        "サラダ",
        "お寿司",
        "揚げ物",
        "その他",
      ],
      makerList: [
        "セブンイレブン",
        "ファミリーマート",
        "ローソン",
        "ミニストップ",
      ],
    }
  },
  methods: {
    setImage(e) {
      this.image = e
    },
    foodCreate() {
      const formData = new FormData()
      formData.append("name", this.name)
      formData.append("image", this.image)
      formData.append("details", this.details)
      formData.append("calorie", this.calorie)
      formData.append("carbonhydrate", this.carbonhydrate)
      formData.append("protein", this.protein)
      formData.append("lipid", this.lipid)
      formData.append("category", this.category)
      formData.append("maker", this.maker)
      const config = {
        headers: {
          "content-type": "multipart/form-data",
        },
      }
      this.$axios
        .post("api/v1/foods", formData, config)
        .then((res) => {
          console.log(res)
          console.log("投稿が成功しました")
          this.$router.push("/")
        })
        .catch((err) => {
          console.log(err)
          console.log("投稿失敗")
        })
    },
  },
}
</script>
