<script setup lang="ts">
import type { FooterColumn } from '@nuxt/ui'
import { ref, computed, onMounted } from 'vue'

interface HomeData {
  footerPages?: Array<{ title: string; slug: string }>
}

const { apiFetch } = useApi()
const config = useRuntimeConfig()

// 🔥 STATE
const settings = ref<any>({})
const homeData = ref<HomeData | null>(null)

// 🔥 FETCH (NO CACHE)
onMounted(async () => {
  try {
    const res = await apiFetch('/home')
    homeData.value = res as HomeData

    const settingsRes = await useSettings()
    settings.value = settingsRes.data.value?.data ?? {}
  } catch (e) {
    console.error('Footer API error:', e)
  }
})

// 🔥 COMPUTED
const footerPages = computed(() => homeData.value?.footerPages ?? [])

// LOGO
const logoUrl = computed(() => {
  if (!settings.value.logo) return null
  if (settings.value.logo.startsWith('http')) return settings.value.logo
  return config.public.backendBase + settings.value.logo
})

// SOCIAL PARSE
const socialsParsed = computed(() => {
  const result: Record<string, string> = {}

  try {
    const raw = JSON.parse(settings.value.socials || '{}')

    for (const url in raw) {
      const match = url.match(/(?:www\.)?([a-z0-9\-]+)\.com/)
      if (match && match[1]) {
        result[match[1]] = url
      }
    }
  } catch {}

  return result
})

// COLUMNS
const columns = computed<FooterColumn[]>(() => [
  {
    label: 'Contact',
    children: [
      settings.value.email && {
        label: settings.value.email,
        to: `mailto:${settings.value.email}`
      },
      settings.value.phone && {
        label: settings.value.phone,
        to: `tel:${settings.value.phone}`
      },
      settings.value.adress && {
        label: settings.value.adress
      }
    ].filter(Boolean) as any
  },
  {
    label: 'Informations',
    children: footerPages.value.map((page: any) => ({
      label: page.title,
      to: `/pages/${page.slug}`
    }))
  },
  {
    label: 'Navigation',
    children: [
      { label: 'Accueil', to: '/' },
      { label: 'À propos', to: { path: '/', hash: '#AboutSection' } },
      { label: 'Services', to: { path: '/', hash: '#ServicesSection' } },
      { label: 'Contact', to: { path: '/', hash: '#ContactSection' } }
    ]
  }
])
</script>

<template>
  <UFooter class="bg-black text-white">

    <UContainer class="py-12">

      <!-- TOP -->
      <div class="grid md:grid-cols-[1.2fr_2fr] gap-10 items-start">

        <!-- BRAND -->
        <div class="space-y-4">
          <img
            v-if="logoUrl"
            :src="logoUrl"
            class="h-24 object-contain block logo-img" 
          />

         <p v-if="settings.adress" class="text-sm text-white/60 max-w-sm">
  {{ settings.adress }}
</p>

          <!-- SOCIAL -->
          <div class="flex gap-3 pt-2">
            <ULink
              v-for="(url, key) in socialsParsed"
              :key="key"
              :to="url"
              target="_blank"
              class="w-9 h-9 rounded-full border border-white/20 flex items-center justify-center text-white/60 hover:bg-yellow-500 hover:text-black transition"
            >
              <UIcon :name="`i-simple-icons-${key}`" />
            </ULink>
          </div>
        </div>

        <!-- COLUMNS -->
        <UFooterColumns
          :columns="columns"
          :ui="{
            label: 'text-xs uppercase tracking-widest text-white/50 mb-4',
            link: 'text-sm text-white/70 hover:text-yellow-500 transition'
          }"
        />

      </div>

      <!-- DIVIDER -->
      <div class="h-px bg-yellow-500/30 my-8" />

      <!-- BOTTOM -->
      <div class="text-center text-xs text-white/40 tracking-widest uppercase">
        © {{ new Date().getFullYear() }} {{ settings.company_name }} · Tous droits réservés
      </div>

    </UContainer>

  </UFooter>
</template>
<style>
/* Option 3 — Fond blanc derrière le logo */
.logo-img {
  background: white;
  border-radius: 8px;
  padding: 2px 8px;
}
</style>
