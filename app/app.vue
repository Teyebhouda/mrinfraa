<script setup lang="ts">
import { ref, onMounted } from 'vue'
import AppHeader from '~/components/layout/AppHeader.vue'
import AppFooter from '~/components/layout/AppFooter.vue'

// 🎬 LOADING RIDEAU
const loading = ref(true)

onMounted(() => {
  setTimeout(() => {
    loading.value = false
  }, 900) // Durée du rideau (1.4s) + buffer
})
</script>

<template>
  <UApp>

  
 <!-- 🎬 RIDEAU DIAGONAL -->
<div
  v-if="loading"
  class="fixed inset-0 z-[9999] overflow-hidden pointer-events-none"
>
  <div class="absolute inset-0 animate-curtain-diagonal"></div>
</div>

    <!-- APP -->
    <AppHeader />
    <NuxtPage />
    <AppFooter />

  </UApp>
</template>

<style>
/* 🎬 RIDEAU DIAGONAL SMOOTH */
/* 🎬 ANIMATION RIDEAU ULTRA SMOOTH */
@keyframes curtainDiagonal {
  0% {
    transform: translateX(0) translateY(0);
  }
  100% {
    transform: translateX(120%) translateY(-120%);
  }
}

.animate-curtain-diagonal {
  position: absolute;
  inset: 0;

  /* ✅ PRIMARY SOLIDE (pas transparent) */
  background-color: rgb(var(--color-primary-500));

  /* ✨ légère variation pour effet premium */
  background-image: linear-gradient(
    135deg,
    rgb(var(--color-primary-500)),
    rgb(var(--color-primary-400))
  );

  /* 🎬 animation smooth */
  animation: curtainDiagonal 1.2s cubic-bezier(0.77, 0, 0.175, 1) forwards;
}
</style>