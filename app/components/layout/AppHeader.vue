<script setup lang="ts">
import type { NavigationMenuItem } from '@nuxt/ui'

const { data } = await useSettings()
const settings = computed(() => data.value?.data ?? {})
const config = useRuntimeConfig()
const route = useRoute()

const logoUrl = computed(() =>
  settings.value.logo
    ? settings.value.logo.startsWith('http')
      ? settings.value.logo
      : config.public.backendBase + settings.value.logo
    : null
)

const mobileMenuOpen = ref(false)

function scrollToSection(id: string) {
  mobileMenuOpen.value = false
  setTimeout(() => {
    const el = document.getElementById(id)
    if (el) el.scrollIntoView({ behavior: 'smooth' })
  }, 350)
}

const NavigationItems = computed<NavigationMenuItem[]>(() => [
  { label: 'Accueil', to: '/' },
  {
    label: 'À propos',
    to: route.path === '/' ? '#AboutSection' : '/#AboutSection',
    onClick: () => scrollToSection('AboutSection')
  },
  {
    label: 'Services',
    to: route.path === '/' ? '#ServicesSection' : '/#ServicesSection',
    onClick: () => scrollToSection('ServicesSection')
  },
  {
    label: 'Projets',
    to: route.path === '/' ? '#ProjectsSection' : '/#ProjectsSection',
    onClick: () => scrollToSection('ProjectsSection')
  },
  {
    label: 'Contact',
    to: route.path === '/' ? '#ContactSection' : '/#ContactSection',
    onClick: () => scrollToSection('ContactSection')
  }
])

const isLightPage = computed(() => route.path.includes('/pages/'))
</script>

<template>

  <!-- ✅ TOP BAR -->
  <UBanner
    variant="ghost"
    class="hidden lg:block bg-black/60 backdrop-blur-sm text-white border-b border-primary/20"
  >
    <template #title>
      <div class="flex items-center gap-5 text-xs flex-wrap">

        <span v-if="settings.company_name" class="font-bold tracking-widest text-white">
          {{ settings.company_name }}
        </span>

        <span class="text-primary/50">|</span>

        <span v-if="settings.adress" class="flex items-center gap-1.5 text-white/70">
          <UIcon name="i-lucide-map-pin" class="text-primary w-3.5 h-3.5" />
          {{ settings.adress }}
        </span>

        <span class="text-primary/50">|</span>

        <!-- ✅ UButton tel -->
        <UButton
          v-if="settings.phone"
          :to="`tel:${settings.phone}`"
          variant="link"
          color="neutral"
          leading-icon="i-lucide-phone"
          :ui="{ leadingIcon: 'text-primary' }"
          class="text-white hover:text-primary p-0 font-semibold text-xs"
        >
          {{ settings.phone }}
        </UButton>

        <span class="text-primary/50">|</span>

        <!-- ✅ UButton email -->
        <UButton
          v-if="settings.email"
          :to="`mailto:${settings.email}`"
          variant="link"
          color="neutral"
          leading-icon="i-lucide-mail"
          :ui="{ leadingIcon: 'text-primary' }"
          class="text-white hover:text-primary p-0 font-semibold text-xs"
        >
          {{ settings.email }}
        </UButton>

      </div>
    </template>

    <template #actions>
      <div class="flex items-center gap-3">
        <span class="text-xs font-semibold text-white/70">🌐 FR</span>

        <!-- ✅ UColorModeButton -->
        <UColorModeButton size="sm" />

        <!-- ✅ UButton CTA 
        <UButton
          color="primary"
          variant="solid"
          size="xs"
          class="font-bold uppercase tracking-wider ml-1"
          @click="scrollToSection('ContactSection')"
        >
          Demander un Devis
        </UButton> -->
      </div>
    </template>
  </UBanner>

  <!-- ✅ HEADER avec prop toggle natif -->
  <UHeader
    v-model:open="mobileMenuOpen"
    title="MR INFRA"
    :toggle="{
      color: 'neutral',
      variant: 'ghost',
      class: 'lg:hidden bg-white/10 border border-white/20 text-white hover:bg-primary hover:text-white rounded-lg'
    }"
    :class="[
      'absolute top-0 lg:top-10 left-0 w-full z-50 backdrop-blur-md',
      isLightPage ? 'bg-black/90 shadow-md' : 'bg-transparent',
    ]"
    :ui="{
      root: 'h-[70px] lg:h-[90px]',
      container: 'h-full',
    }"
  >

    <!-- ✅ LOGO — fix affichage noir/jaune sur fond sombre -->
    <template #title>
      <ULink to="/" class="flex items-center shrink-0 h-full py-2">
        <NuxtImg
          v-if="logoUrl"
          :src="logoUrl"
          format="png"
          quality="100"
          densities="x1 x2"
          class="h-[52px] lg:h-[75px] w-auto object-contain block logo-img"
        />
      </ULink>
    </template>

    <!-- ✅ MENU DESKTOP — slot default (centre) -->
  <UNavigationMenu
  :items="NavigationItems"
  :ui="{
    root: 'flex items-center',
    list: 'flex items-center gap-8',
    link: `
      text-[11px] font-bold uppercase tracking-[0.25em]
      text-white/90
      hover:text-white hover:bg-white/10
      rounded-md transition-all duration-300 px-3 py-1.5

      aria-[current=page]:bg-white/15
      aria-[current=page]:text-white
      aria-[current=page]:font-extrabold

      data-[active]:bg-white/10
      data-[active]:text-black/90
      data-[active]:font-extrabold
    `,
    indicator: 'hidden',
    childList: 'hidden',
  }"
  class="hidden lg:flex"
/>

    <!-- ✅ SLOT RIGHT — CTA desktop visible -->
    <template #right>
      <UButton
        color="primary"
        variant="solid"
        size="sm"
        class="hidden lg:flex font-bold uppercase tracking-wider rounded-lg"
        @click="scrollToSection('ContactSection')"
      >
        Devis gratuit
      </UButton>
    </template>

    <!-- ✅ MENU MOBILE BODY -->
    <template #body>
      <div class="flex flex-col h-full">
        <UNavigationMenu
          :items="NavigationItems"
          orientation="vertical"
          class="-mx-2.5 flex-1"
        />

        <div class="p-6 border-t border-gray-200 dark:border-gray-800 flex flex-col gap-3">
          <p class="text-center text-sm text-gray-600 dark:text-gray-400 font-medium">
            Vous avez un projet ? N'hésitez pas à nous contacter !
          </p>

          <!-- ✅ UButton au lieu de ULink -->
          <UButton
            color="primary"
            variant="solid"
            block
            size="lg"
            class="font-bold rounded-xl"
            @click="scrollToSection('ContactSection')"
          >
            Contactez-nous
          </UButton>
        </div>
      </div>
    </template>

  </UHeader>
</template>

<style scoped>

/* Option 1 — Logo noir disparaît sur fond sombre → le rendre blanc 
.logo-img {
  filter: brightness(0) invert(1);
}
*/
/* Option 2 — Garder les couleurs mais ajouter lisibilité 
.logo-img {
  filter: drop-shadow(0 0 6px rgba(255,255,255,0.4));
}
*/
/* Option 3 — Fond blanc derrière le logo */
.logo-img {
  background: white;
  border-radius: 8px;
  padding: 2px 8px;
}

/* Force override du style actif UNavigationMenu sur fond sombre */
:deep([data-active]) {
  background-color: rgba(255, 255, 255, 0.15) !important;
  color: white !important;
}

:deep([aria-current="page"]) {
  background-color: rgba(255, 255, 255, 0.15) !important;
  color: white !important;
}
</style> 