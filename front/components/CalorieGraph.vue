<template>
  <div>
    <v-container>
      <div class="d-flex mb-4">
        <h2>{{ $dayjs(value).format("YYYY/MM/DD") }}のメニュー</h2>
        <v-dialog v-model="dialog" width="800">
          <template #activator="{ on, attrs }">
            <v-btn
              color="blue lighten-1"
              dark
              v-bind="attrs"
              class="ml-5 font-weight-bold"
              v-on="on"
            >
              カレンダーから選択
            </v-btn>
          </template>
          <v-sheet
            tile
            height="35px"
            color="grey lighten-3"
            class="d-flex align-center mt-6"
          >
            <v-btn outlined small class="ma-4" @click="setToday">今日</v-btn>
            <v-btn icon @click="$refs.calendar.prev()">
              <v-icon>mdi-chevron-left</v-icon>
            </v-btn>
            <v-btn icon @click="$refs.calendar.next()">
              <v-icon>mdi-chevron-right</v-icon>
            </v-btn>
            <v-toolbar-title>{{ title }}</v-toolbar-title>
            <v-spacer />
            <v-btn
              outlined
              small
              class="ma-4"
              color="red"
              @click="dialog = false"
            >
              閉じる
            </v-btn>
          </v-sheet>
          <v-sheet height="600px">
            <v-calendar
              ref="calendar"
              v-model="value"
              :events="events"
              :event-color="getEventColor"
              locale="ja-jp"
              :day-format="(timestamp) => new Date(timestamp.date).getDate()"
              :month-format="
                (timestamp) => new Date(timestamp.date).getMonth() + 1 + ' /'
              "
              @change="getEvents"
            ></v-calendar>
          </v-sheet>
        </v-dialog>
      </div>
      <v-row>
        <v-col cols="5">
          <template v-if="dayMenus.length">
            <v-card
              v-for="menu in dayMenus"
              :key="menu.id"
              flat
              class="pb-2"
              style="background-color: #fbfbfb"
            >
              <calorie-menu :menu="menu" />
            </v-card>
          </template>
          <template v-else>
            <h4 class="mt-3">保存されたメニューはありません</h4>
          </template>
        </v-col>
        <v-col cols="7">
          <BarChart :chart-data="chartData" :options="chartOptions" />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import colors from "vuetify/es5/util/colors"
import calorieMenu from "~/components/CalorieMenu"

export default {
  components: {
    calorieMenu,
  },
  props: {
    menus: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      chartDataValues: [],
      chartColors: [
        colors.red.lighten1,
        colors.blue.lighten1,
        colors.yellow.lighten1,
        colors.green.lighten1,
      ],
      chartLabels: ["カロリー", "炭水化物", "タンパク質", "脂質"],
      chartOptions: {
        maintainAspectRatio: false,
        animation: {
          duration: 1000,
          easing: "easeInOutCubic",
        },
        // scales: {
        //   yAxes: [
        //     {
        //       ticks: {
        //         max: 4000,
        //         min: 0,
        //       },
        //     },
        //   ],
        // },
      },
      events: [],
      value: this.$dayjs().format("YYYY-MM-DD"),
      dayMenus: [],
      dialog: false,
    }
  },
  computed: {
    chartData() {
      return {
        datasets: [
          {
            label: this.value,
            data: this.chartDataValues,
            backgroundColor: this.chartColors,
          },
        ],
        labels: this.chartLabels,
      }
    },
    title() {
      return this.$dayjs(this.value).format("YYYY年M月")
    },
  },
  watch: {
    value() {
      this.calorieData()
    },
  },
  mounted: function () {
    this.calorieData()
  },
  methods: {
    calorieData: function () {
      let data = []
      let menus = []
      let calorie = 0
      let carbon = 0
      let protein = 0
      let lipid = 0
      this.menus.filter((menu) => {
        if (menu.date == this.value) {
          menus.push(menu)
          menu.choise_food.filter((food) => {
            calorie += food.calorie
            carbon += food.carbonhydrate
            protein += food.protein
            lipid += food.lipid
          })
        }
      })
      data.push(calorie)
      data.push(carbon.toFixed(1))
      data.push(protein.toFixed(1))
      data.push(lipid.toFixed(1))
      this.chartDataValues = data
      this.dayMenus = menus
      console.log(this.dayMenus)
    },
    getEvents() {
      const events = []
      this.menus.forEach((f) => {
        let menu = {
          name: f.timezone,
          start: f.date,
          end: f.date,
          color: "blue",
          timed: false,
        }
        events.push(menu)
      })
      this.events = events
    },
    getEventColor(event) {
      return event.color
    },
    setToday() {
      this.value = this.$dayjs().format("YYYY-MM-DD")
      this.dialog = !this.dialog
    },
  },
}
</script>

<style scoped></style>
