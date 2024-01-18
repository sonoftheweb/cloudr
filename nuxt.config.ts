// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  modules: ['vuetify-nuxt-module', '@pinia/nuxt'],
  vuetify: {
    vuetifyOptions: './vuetify.options.ts',
  },
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: '@use "~/assets/_vuetify.scss" as *;',
        },
      },
    },
  },
})
