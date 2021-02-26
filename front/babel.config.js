module.exports = {
  presets: [
    [
      "@babel/preset-env",
      {
        "modules": false,
        "useBuiltIns": "usage"
      }
    ]
  ],
  env: {
    test: {
      presets: [
        [
          "@babel/preset-env",
          {
            targets: {
              node: "current"
            }
          }
        ]
      ]
    }
  }
};