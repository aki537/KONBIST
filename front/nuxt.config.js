import colors from "vuetify/es5/util/colors"

export default {
  mode: "spa",
  /*
   ** Headers of the page
   */
  head: {
    titleTemplate: "%s - " + process.env.npm_package_name,
    title: process.env.npm_package_name || "",
    meta: [
      { charset: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      {
        hid: "description",
        name: "description",
        content: process.env.npm_package_description || "",
      },
    ],
    link: [{ rel: "icon", type: "image/x-icon", href: "/favicon.ico" }],
  },
  /*
   ** Customize the progress-bar color
   */
  loading: { color: "#fff" },
  /*
   ** Global CSS
   */
  css: [],
  /*
   ** Plugins to load before mounting the App
   */
  plugins: [
    "plugins/axios",
    { src: "~/plugins/localStorage.js", ssr: false },
    { src: "~/plugins/vue-carousel", ssr: false },
    { src: "~/plugins/dayjs", ssr: false },
    { src: "~/plugins/swiper.js", ssr: false },
  ],
  /*
   ** Nuxt.js dev-modules
   */
  buildModules: ["@nuxtjs/vuetify"],
  /*
   ** Nuxt.js modules
   */
  modules: [
    // Doc: https://axios.nuxtjs.org/usage
    "@nuxtjs/axios",
    "nuxt-webfontloader",
    "nuxt-i18n",
    "nuxt-client-init-module",
  ],
  webfontloader: {
    google: {
      families: [
        "Slabo+27px",
        "Fraunces",
        "Noto+Sans:wght@700",
        "Noto+Sans+JP:wght@900",
      ],
    },
  },
  /*
   ** Axios module configuration
   ** See https://axios.nuxtjs.org/options
   */
  axios: {
    baseURL: "https://konbist-api.com"
  },
  /*
   ** vuetify module configuration
   ** https://github.com/nuxt-community/vuetify-module
   */
  vuetify: {
    customVariables: ["~/assets/variables.scss"],
    theme: {
      dark: false,
      themes: {
        dark: {
          primary: colors.blue.darken2,
          accent: colors.grey.darken3,
          secondary: colors.amber.darken3,
          info: colors.teal.lighten1,
          warning: colors.amber.base,
          error: colors.deepOrange.accent4,
          success: colors.green.accent3,
          backgroud: "#e4f9f5",
        },
        light: {
          backgroud: "#e4f9f5",
        },
      },
    },
  },
  // Doc: https://nuxt-community.github.io/nuxt-i18n/basic-usage.html#nuxt-link
  i18n: {
    locales: ["ja", "en"],
    defaultLocale: "ja",
    // Doc: https://kazupon.github.io/vue-i18n/api/#properties
    vueI18n: {
      fallbackLocale: "ja",
      // silentTranslationWarn: true,
      silentFallbackWarn: true,
      messages: {
        ja: require("./locales/ja.json"),
        en: require("./locales/en.json"),
      },
    },
  },
  // auth: {
  //   redirect: {
  //       login: '/users/login',
  //       logout: '/',
  //       callback: false,
  //       home: '/',
  //   },
  //   strategies: {
  //     local: {
  //       endpoints: {
  //         login: { url: '/api/v1/auth/sign_in', method: 'post', propertyName: 'token' },
  //         logout: false,
  //         user: false
  //       },
  //     }
  //   }
  // },
  /*
   ** Build configuration
   */
  build: {
    /*
     ** You can extend webpack config here
     */
    extend(config, ctx) {
      if (ctx.isDev && ctx.isClient) {
        config.module.rules.push({
          enforce: "pre",
          test: /\.(js|vue)$/,
          loader: "eslint-loader",
          exclude: /(node_modules)/,
        })
      }
    },
    vendor: ["vue-awesome-swiper"],
  },
  // router: {
  //   middleware: ['auth']
  // }
}
