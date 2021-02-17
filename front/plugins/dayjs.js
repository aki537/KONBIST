import "dayjs/locale/ja"
import dayjs from "dayjs"
import Vue from "vue"

dayjs.locale("ja")

Vue.prototype.$dayjs = dayjs
