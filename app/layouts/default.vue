<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'

const showScrollTop = ref(false)

const handleScroll = () => {
  showScrollTop.value = window.scrollY > 300
}

const scrollToTop = () => {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
})

onBeforeUnmount(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<template>
  <div class="relative">
    <AppHeader />

    <!-- Contenu de la page -->
    <NuxtPage />

    <!-- BOUTON SCROLL TO TOP -->
    <button
      v-if="showScrollTop"
      @click="scrollToTop"
      class="fixed bottom-6 right-6 z-50 w-12 h-12 md:w-14 md:h-14 bg-yellow-500 hover:bg-yellow-400 text-black rounded-full shadow-lg flex items-center justify-center transition-all"
      aria-label="Scroll to top"
    >
      <UIcon name="i-lucide-arrow-up" class="text-lg md:text-xl" />
    </button>
  </div>
</template>