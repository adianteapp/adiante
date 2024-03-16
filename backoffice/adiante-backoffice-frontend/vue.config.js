module.exports = {
  devServer: {
    port: 8081,
    allowedHosts: [
      `${process.env.VUE_APP_ALLOWED_DOMAIN}`
    ]
  },

  transpileDependencies: [
    'vue'
  ],

  pluginOptions: {
    i18n: {
      locale: 'en',
      fallbackLocale: 'en',
      localeDir: 'locales',
      enableLegacy: true,
      runtimeOnly: false,
      compositionOnly: true,
      fullInstall: true
    }
  }
}
