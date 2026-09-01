import { defineNuxtConfig } from "nuxt/config";

export default defineNuxtConfig({
  ssr: true,

  app: {
    head: {
      title: '',
      htmlAttrs: { lang: 'fr' },
      link: [
        { rel: 'apple-touch-icon', sizes: '180x180', href: '/apple-touch-icon.png' },
        { rel: 'icon', type: 'image/png', sizes: '96x96', href: '/favicon-96x96.png' },
        { rel: 'icon', type: 'image/svg+xml', href: '/favicon.svg' },
        { rel: 'manifest', href: '/site.webmanifest' },
        { rel: 'shortcut icon', href: '/favicon.ico' }
      ]
    }
  },

  nitro: {
    prerender: {
      failOnError: false
    }
  },

  // ✅ URL du site FRONTEND (pas admin)
  site: {
    url: 'https://mrinfra.fr',
    name: 'MR INFRA',
    description: 'Expert en bâtiment et infrastructure',
    defaultLocale: 'fr',
  },

  modules: [
    '@nuxt/ui',
    '@nuxt/image',
    '@nuxtjs/color-mode',
    '@nuxt/icon',
    '@nuxtjs/seo',
    'nuxt-skew-protection',
    'nuxt-ai-ready'
  ],

 sitemap: {
   exclude: ['/reservation'],
  strictNuxtContentPaths: false,
  urls: async () => {
    try {
      const response = await fetch('https://admin.mrinfra.fr/api/services')
        .then(r => r.json())

      // ✅ Gérer les deux formats Laravel
      const services = response.data ?? response // si paginé ou pas

      console.log('Sitemap services:', services) // debug

      if (!Array.isArray(services)) {
        console.error('Services is not an array:', services)
        return []
      }

      return services
        .filter((s: any) => s.slug) // ✅ ignorer les slugs undefined
        .map((s: any) => ({
          loc: `/services/${s.slug}`,
          lastmod: s.updated_at ?? new Date().toISOString(),
          changefreq: 'monthly',
          priority: 0.8
        }))
    } catch (e) {
      console.error('Sitemap fetch error:', e)
      return []
    }
  }
},

  robots: {
    allow: '/',
      disallow: ['/reservation'], // ✅ Google ne crawle pas cette page
    sitemap: 'https://mrinfra.fr/sitemap.xml',
  },

  colorMode: {
    preference: 'light'
  },

  css: ['~/assets/css/main.css'],

  ui: {
    theme: {
      colors: ['primary', 'secondary', 'tertiary', 'info', 'success', 'warning', 'error'],
      defaultVariants: {
        color: 'neutral',
        size: 'sm'
      }
    }
  },

  compatibilityDate: '2025-07-15',
  devtools: { enabled: false },

 

  runtimeConfig: {
    public: {
      apiBase: 'https://admin.mrinfra.fr/api',
      siteBase: 'https://mrinfra.fr', // ✅ domaine FRONTEND pas admin
      backendBase: 'https://admin.mrinfra.fr' // ✅ domaine ADMIN pour API calls
    }
  },
})