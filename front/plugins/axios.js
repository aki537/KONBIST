export default function ({ $axios, redirect }) {
  // $axios.setToken("access_token")
  $axios.onRequest((config) => {
    console.log("-------- start /plugins/axios.js------------")
    config.headers.client = window.localStorage.getItem("client")
    config.headers["access-token"] = window.localStorage.getItem("access-token")
    config.headers.uid = window.localStorage.getItem("uid")
    config.headers["token-type"] = window.localStorage.getItem("token-type")
    config.headers["expiry"] = window.localStorage.getItem("expiry")
    config.headers["content-type"] = "application/json"
    console.log(config)
  })

  $axios.onResponse((response) => {
    $axios.setHeader("Access-Control-Allow-Origin", "*")
    console.log("⇩response")
    console.log(response)
    if (response.headers.client) {
      console.log("認証情報あり。  /plugins/axios.js")
      localStorage.setItem("access-token", response.headers["access-token"])
      localStorage.setItem("client", response.headers.client)
      localStorage.setItem("uid", response.headers.uid)
      localStorage.setItem("token-type", response.headers["token-type"])
      localStorage.setItem("expiry", response.headers["expiry"])
    } else {
      console.log("認証情報を発見できませんでした")
    }
    console.log("-------- end /plugins/axios.js------------")
  })
}
