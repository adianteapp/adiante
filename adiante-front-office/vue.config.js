module.exports = {
  devServer: {
    port: 8081
  },

  transpileDependencies: [
    'vue'
  ],

  configureWebpack: {
    devtool: 'source-map',
    resolve: {
      fallback: {
        path: require.resolve('path-browserify'),
        os: require.resolve('os-browserify/browser'),
        fs: false
      }
    }
  },

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
