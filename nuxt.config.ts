// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  ssr: false,
  devtools: { enabled: true },
  css: [
    "~/assets/css/main.css",
    "~/assets/css/components.css",
    "~/assets/css/ionic.css",
    "@fontsource/quicksand/400.css", 
    "@fontsource/quicksand/700.css"
  ],

  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },

  modules: [
    "@vueform/nuxt", 
    "@nuxt/ui", 
    "@nuxtjs/ionic"
  ],

  colorMode: {
    preference: 'light'
  },

  runtimeConfig: {
    public: {
      environment: process.env.VITE_ENVIRONMENT,
      pocketbaseURL: process.env.VITE_POCKETBASE_URL
    }
  },

  compatibilityDate: "2024-10-16"
});