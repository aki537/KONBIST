import Vue from "vue"
import { Bar, mixins } from "vue-chartjs"
// import Chart from "chart.js"
// import { generateChart } from "vue-chartjs"
const { reactiveProp } = mixins

// Chart.defaults.LineWithLine = Chart.defaults.line
// Chart.controllers.LineWithLine = Chart.controllers.line.extend({
//   /* custom magic here */
// })

Vue.component("BarChart", {
  extends: Bar,
  mixins: [reactiveProp],
  props: {
    options: {
      type: Object,
      default: () => {},
    },
  },
  mounted() {
    this.renderChart(this.chartData, this.options)
  },
})
