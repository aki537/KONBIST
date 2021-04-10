<template>
  <div>
    <v-sheet
      tile
      height="35px"
      color="grey lighten-3"
      class="d-flex align-center"
    >
      <v-btn outlined small class="ma-4" @click="setToday">今日</v-btn>
      <v-btn icon @click="$refs.calendar.prev()">
        <v-icon>mdi-chevron-left</v-icon>
      </v-btn>
      <v-btn icon @click="$refs.calendar.next()">
        <v-icon>mdi-chevron-right</v-icon>
      </v-btn>
      <v-toolbar-title>{{ title }}</v-toolbar-title>
    </v-sheet>
    <v-sheet height="550px">
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
  </div>
</template>

<script>
export default {
  props: {
    menus: {
      type: Array,
      required: true,
    },
  },
  data() {
    return {
      events: [],
      value: this.$dayjs().format("YYYY-MM-DD"),
    }
  },
  computed: {
    title() {
      return this.$dayjs(this.value).format("YYYY年M月")
    },
  },
  methods: {
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
    },
  },
}
</script>

<style scoped></style>
