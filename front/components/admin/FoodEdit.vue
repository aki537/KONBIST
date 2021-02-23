<template>
  <v-dialog v-model="editDialog" max-width="600">
    <template #activator="{ on, attrs }">
      <v-btn small v-bind="attrs" v-on="on"> 編集 </v-btn>
    </template>

    <v-card>
      <v-system-bar lights-out>
        <v-spacer></v-spacer>
        <v-btn icon class="mt-5" @click="editDialog = false">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </v-system-bar>
      <v-card-title class="headline justify-center">
        {{ food.name }}
      </v-card-title>
      <v-card-text>
        <v-form ref="form">
          <template v-if="food.image.url">
            <v-img
              v-if="input_image !== null"
              :src="input_image"
              contain
              max-width="200"
              max-height="100"
            />
            <v-img
              v-else
              :src="food.image.url"
              contain
              max-width="200"
              max-height="100"
            />
          </template>
          <template v-else>
            <v-img
              v-if="input_image"
              :src="input_image"
              contain
              max-width="200"
              max-height="100"
            />
          </template>
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
            v-model.number="price"
            placeholder="例:500"
            label="価格"
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
          <v-menu
            ref="menu"
            v-model="menu"
            :close-on-content-click="false"
            :return-value.sync="release"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template #activator="{ on, attrs }">
              <v-text-field
                v-model="release"
                label="発売日"
                readonly
                v-bind="attrs"
                v-on="on"
              />
            </template>
            <v-date-picker v-model="release" no-title scrollable>
              <v-spacer></v-spacer>
              <v-btn text color="primary" @click="menu = false"> Cancel </v-btn>
              <v-btn text color="primary" @click="$refs.menu.save(release)">
                OK
              </v-btn>
            </v-date-picker>
          </v-menu>
          <v-card-actions>
            <v-btn
              color="light-green darken-1"
              class="white--text"
              @click="foodEdit"
            >
              保存する
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    food: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      editDialog: false,
      id: this.food.id,
      input_image: null,
      name: this.food.name,
      image: this.food.image,
      details: this.food.details,
      calorie: this.food.calorie,
      carbonhydrate: this.food.carbonhydrate,
      protein: this.food.protein,
      lipid: this.food.lipid,
      category: this.food.category,
      maker: this.food.maker,
      price: this.food.price,
      release: this.food.release,
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
      menu: false,
      today: "",
    }
  },
  computed: {},
  methods: {
    foodEdit() {
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
      formData.append("release", this.release)
      formData.append("price", this.price)
      const config = {
        headers: {
          "content-type": "multipart/form-data",
        },
      }
      this.$axios
        .patch(`api/v1/foods/${this.id}`, formData, config)
        .then((res) => {
          console.log(res)
          console.log("フードを更新しました")
          this.editDialog = false
        })
        .catch((err) => {
          console.log(err)
          console.log("投稿失敗")
        })
    },
    setImage(file) {
      this.image = file
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf(".") <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener("load", () => {
          this.input_image = fr.result
        })
      } else {
        this.input_image = null
      }
    },
  },
}
</script>

<style scoped></style>
