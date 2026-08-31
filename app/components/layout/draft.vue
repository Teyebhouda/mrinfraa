<script setup lang="ts">
import type { NavigationMenuItem } from '@nuxt/ui'
import { ref, computed } from 'vue'

const { data } = await useSettings()
const settings = computed(() => data.value?.data ?? {})

const config = useRuntimeConfig()

const logoUrl = computed(() =>
  settings.value.logo
    ? settings.value.logo.startsWith('http')
      ? settings.value.logo
      : config.public.backendBase + settings.value.logo
    : null
)

import { useRoute } from 'vue-router'

const route = useRoute()

const NavigationItems = computed<NavigationMenuItem[]>(() => [
  { label: 'Accueil', to: '/' },
  { label: 'A propos', to: route.path === '/' ? '#AboutSection' : '/#AboutSection' },
  { label: 'Services', to: route.path === '/' ? '#ServicesSection' : '/#ServicesSection' },
  { label: 'Projets', to: route.path === '/' ? '#ProjectsSection' : '/#ProjectsSection' },
  { label: 'Location', to: route.path === '/' ? '#ContactSection' : '/#ContactSection' },
  { label: 'Contact', to: route.path === '/' ? '#ContactSection' : '/#ContactSection' }
])

const navUi = {
  root: 'flex items-center',
  list: 'flex items-center gap-10',
  item: 'relative',
  link: `
    text-[12px]
    font-semibold
    uppercase
    tracking-[0.25em]
    text-white/80
    dark:text-white/80
    hover:text-black 
    dark:hover:text-white
    transition-all duration-300
    relative
    after:absolute after:-bottom-2 after:left-1/2
    after:h-[1px] after:w-0
    after:bg-black dark:after:bg-white
    after:transition-all after:duration-300
    after:-translate-x-1/2
    hover:after:w-full
    aria-[current=page]:text-black
    dark:aria-[current=page]:text-white
    aria-[current=page]:after:w-full
  `,
  indicator: 'hidden'
}



const mobileMenuOpen = ref(false)
</script>


<template>
  <!-- TOP BAR -->
<!-- TOP BAR -->
<UBanner
  variant="ghost"
  class="hidden lg:block  bg-black/50 text-white border-b border-yellow-500/30 shadow-sm"
  
>
  <!-- LEFT -->
  <template #title>
    <div class="flex items-center gap-6 text-xs md:text-sm flex-wrap">

      <!-- COMPANY -->
      <span 
        v-if="settings.company_name"
        class="font-bold tracking-widest text-white"
      >
        {{ settings.company_name }}
      </span>

      <!-- SEPARATOR -->
      <span class="text-yellow-500/50">|</span>

      <!-- ADDRESS -->
      <span 
        v-if="settings.adress" 
        class="flex items-center gap-2 text-white/70"
      >
        <UIcon name="i-heroicons-map-pin" class="text-yellow-500 text-base" />
        {{ settings.adress }}
      </span>

      <!-- SEPARATOR -->
      <span class="text-yellow-500/50">|</span>

      <!-- PHONE -->
      <ULink
        v-if="settings.phone"
        :to="`tel:${settings.phone}`"
        class="flex items-center gap-2 font-semibold text-white hover:text-yellow-400 transition"
      >
        <UIcon name="i-heroicons-phone" class="text-yellow-500 text-base" />
        {{ settings.phone }}
      </ULink>

      <!-- SEPARATOR -->
      <span class="text-yellow-500/50">|</span>

      <!-- EMAIL -->
      <ULink
        v-if="settings.email"
        :to="`mailto:${settings.email}`"
        class="flex items-center gap-2 font-semibold text-white hover:text-yellow-400 transition"
      >
        <UIcon name="i-heroicons-envelope" class="text-yellow-500 text-base" />
        {{ settings.email }}
      </ULink>

    </div>
  </template>

  <!-- RIGHT -->
  <template #actions>
    <div class="flex items-center gap-4">

      <!-- LANG -->
      <span class="text-sm font-semibold tracking-wide text-white/80">
        🌐 FR
      </span>

      <!-- DARK MODE -->
      <UColorModeButton />

      <!-- CTA -->
      <ULink
        to="#ContactSection"
        class="ml-2 px-4 py-1.5 text-xs font-bold uppercase tracking-wider bg-yellow-500 text-black rounded hover:bg-yellow-400 transition"
      >
        Devis
      </ULink>

    </div>
  </template>
</UBanner>

<div class="h-px w-full bg-white/20"></div>


  <!-- HEADER -->
<UHeader
  title="MR INFRA"
  class="
    absolute top-0 lg:top-12 left-0 w-full z-50
    bg-transparent backdrop-blur-md
    text-gray-900 dark:text-white
  "
>

  <!-- LOGO -->
  <template #title>
    <ULink to="/">
      <img
        v-if="logoUrl"
        :src="logoUrl"
        class="h-18 lg:h-22 object-contain"
      />
    </ULink>
  </template>

  <!-- MENU DESKTOP -->
  <UNavigationMenu
    :items="NavigationItems"
    :ui="navUi"
    class="hidden lg:flex"
  />

  <!-- 🔥 BOUTON MENU MOBILE CUSTOM -->
  <template #toggle="{ open, toggle }">
  <button
    @click="toggle()"
    class="
      lg:hidden
      flex items-center justify-center
      w-10 h-10
      rounded-lg
      bg-white/10 backdrop-blur
      border border-white/20
      text-primary-500
      hover:bg-primary-500
      hover:text-black
      transition-all duration-300
    "
  >
    <UIcon
      :name="open ? 'i-heroicons-x-mark' : 'i-heroicons-bars-3'"
      class="w-6 h-6"
    />
  </button>
</template>

  <!-- MOBILE BODY -->
  <template #body>
    <div class="flex flex-col h-full">

      <!-- MENU MOBILE -->
      <UNavigationMenu
        :items="[...NavigationItems]"
        orientation="vertical"
        class="-mx-2.5 flex-1"
      />

      <!-- CONTACT -->
      <div class="p-6 border-t border-gray-200 dark:border-gray-800 flex flex-col gap-3">
        
        <p class="text-center text-gray-700 dark:text-gray-300 font-medium">
          Vous avez un projet ou une question ? N'hésitez pas à nous contacter !
        </p>

        <ULink
          href="#ContactSection"
          class="w-full px-6 py-3 bg-primary-500 text-black font-bold hover:bg-primary-400 transition text-center"
        >
          Contacter nous
        </ULink>
      </div>

    </div>
  </template>

</UHeader>




</template>
<style> 
/* Icône menu mobile */
button[aria-label="Open menu"] svg {
  color: rgb(var(--color-primary-500));
}
</style>

