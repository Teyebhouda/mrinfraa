<script setup>
// ✅ Tous les imports en haut (pas au milieu du script)
import HeroSection from "~/components/home/HeroSection.vue"
import ServicesSection from "~/components/home/ServicesSection.vue"
import ProjectsSection from "~/components/home/ProjectsSection.vue"
import AboutSection from "~/components/home/AboutSection.vue"
import LocationSection from "~/components/home/LocationSection.vue"
import Garanties from "~/components/home/Garanties.vue"
import { useSEOSettings } from '~/composables/useSEO'

// ✅ await fonctionne car la fonction est maintenant async
 useSEOSettings()

const { apiFetch } = useApi()
const { data } = await useAsyncData('home', () => apiFetch('/home'))
const { data: settingsData } = await useSettings()

const settings = computed(() => settingsData.value?.data ?? {})
const sections = computed(() => data.value?.sections ?? {})

// Scroll to top
const showScrollTop = ref(false)
const handleScroll = () => { showScrollTop.value = window.scrollY > 300 }
const scrollToTop = () => { window.scrollTo({ top: 0, behavior: 'smooth' }) }

onMounted(() => window.addEventListener('scroll', handleScroll))
onUnmounted(() => window.removeEventListener('scroll', handleScroll))

// WhatsApp
const showWhatsApp = ref(false)
onMounted(() => {
  const observer = new IntersectionObserver(
    ([entry]) => { showWhatsApp.value = !entry.isIntersecting },
    { root: null, threshold: 0 }
  )
  const heroEl = document.querySelector('#hero-section')
  if (heroEl) observer.observe(heroEl)
})
</script>

<template>
  <div>
    <HeroSection 
    id="hero-section"
    ref="heroRef"
    :data="{
    slides: sections.hero?.content?.slides,
    services: sections.services?.content?.items
  }" />
  <!-- SCROLL TO TOP -->
<button
  v-if="showScrollTop"
  @click="scrollToTop"
  class="fixed bottom-6 right-6 z-50 p-3  bg-primary-500 text-white shadow-lg rounded-full hover:bg-primary-400 transition"
>
  <UIcon name="i-heroicons-arrow-up" class="w-4 h-4" />
</button>
  
    <a
      v-if="settings.phone && showWhatsApp"
      :href="`https://wa.me/${settings.phone.replace(/\D/g, '')}?text=Bonjour%20${settings.company_name},%20je%20suis%20intéressé%20par%20vos%20services.`"
      target="_blank"
      class="fixed bottom-3 left-6 z-50 p-3 rounded-full bg-primary-500 text-white shadow-lg hover:bg-primary-400 transition"
    >
      <svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24" class="w-6 h-6">
        <path d="M20.52 3.48A11.95 11.95 0 0 0 12 0C5.37 0 0 5.37 0 12a11.96 11.96 0 0 0 2.03 6.6L0 24l5.53-1.43A11.95 11.95 0 0 0 12 24c6.63 0 12-5.37 12-12 0-3.2-1.25-6.22-3.48-8.52zM12 22a10 10 0 0 1-5.32-1.48l-.38-.22-3.28.85.88-3.21-.25-.41A10 10 0 1 1 22 12a10 10 0 0 1-10 10zm5.06-7.06c-.27-.14-1.6-.79-1.84-.88-.24-.1-.41-.14-.58.14-.17.27-.65.88-.8 1.06-.14.17-.28.19-.52.07-.24-.12-1.01-.37-1.92-1.17-.71-.63-1.19-1.4-1.33-1.64-.14-.24-.01-.37.1-.49.1-.1.24-.28.37-.42.12-.14.16-.24.24-.4.08-.17.04-.28-.02-.42-.07-.14-.58-1.4-.8-1.93-.21-.5-.43-.43-.58-.44l-.49-.01c-.17 0-.42.06-.64.28-.22.22-.83.81-.83 1.97 0 1.16.85 2.28.97 2.44.12.17 1.68 2.56 4.06 3.59 2.38 1.04 2.38.69 2.81.64.43-.05 1.37-.56 1.56-1.1.18-.54.18-1 .12-1.1-.06-.1-.24-.17-.5-.31z"/>
      </svg>
    </a>
  

  <!-- BOUTON FIXE À GAUCHE STYLE BULLE 
<a
  v-if="showWhatsApp"
  href="#ContactSection"
  class="fixed left-0 bottom-40 z-50 px-1.5 py-1 border border-primary-500 text-primary-500 rounded-r-full bg-transparent text-sm font-medium hover:bg-primary-50 hover:text-primary-600 transition"
>
  Nous contacter
</a>   -->
 <AboutSection
      :data="sections.ParallaxStats?.content" :services="sections.services?.content?.items" 
    />
  

     <ServicesSection
      :services="sections.services?.content?.items"
    />  
    <Garanties  />

     <!-- PROJECTS -->
    <ProjectsSection
      :projects="sections.projects?.content?.items"
    />
   <!-- <testimonials :testimonials="sections.testimonials" /> -->

   
      <!-- <HotelAmenitiesSection /> -->
      <!-- 🗺️ LOCATION (settings only) -->
    <LocationSection :testimonials="sections.testimonials"  :settings="settings" :services="sections.services?.content?.items"/>

   
  </div>
</template>
