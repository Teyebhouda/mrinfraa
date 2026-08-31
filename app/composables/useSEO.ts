// composables/useSEO.ts
import { useSeoMeta, useHead, useRuntimeConfig } from '#imports'

interface SEOSettings {
  meta_title?: string
  meta_description?: string
  meta_keywords?: string
  logo?: string
}

export function useSEOSettings() {
  const config = useRuntimeConfig()
  const siteUrl = config.public.siteBase || 'https://mrinfra.fr'
  const { apiFetch } = useApi()

  // ✅ useAsyncData directement (pas dans un autre composable)
  const { data: settingsData } = useAsyncData('seo-settings', () =>
    apiFetch('/settings') // appel direct API
  )

  const settings = computed(() => (settingsData.value?.data ?? {}) as SEOSettings)

  useSeoMeta({
    title: () => settings.value.meta_title || 'MR INFRA',
    description: () => settings.value.meta_description || '',
    keywords: () => settings.value.meta_keywords || '',

    ogTitle: () => settings.value.meta_title || '',
    ogDescription: () => settings.value.meta_description || '',
    ogType: 'website',
    ogUrl: siteUrl,
    ogImage: () => settings.value.logo
      ? `${siteUrl}${settings.value.logo}`
      : `${siteUrl}/og-image.jpg`,

    twitterCard: 'summary_large_image',
    twitterTitle: () => settings.value.meta_title || '',
    twitterDescription: () => settings.value.meta_description || '',
    twitterImage: () => settings.value.logo
      ? `${siteUrl}${settings.value.logo}`
      : '',
  })

  useHead({
    htmlAttrs: { lang: 'fr' },
    link: [{ rel: 'canonical', href: siteUrl }]
  })
}