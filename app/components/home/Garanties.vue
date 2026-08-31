<script setup lang="ts">
import type { PageFeatureProps } from '@nuxt/ui'

const garanties = [
  {
    title: 'Travail garanti',
    description: 'Tous nos travaux sont réalisés avec qualité et rigueur.',
    icon: 'i-lucide-shield-check'
  },
  {
    title: 'Respect des délais',
    description: 'Nous respectons les plannings convenus pour chaque projet.',
    icon: 'i-lucide-clock'
  },
  {
    title: 'Matériaux de qualité',
    description: 'Nous utilisons uniquement des matériaux certifiés et durables.',
    icon: 'i-lucide-package'
  },
  {
    title: 'Support client',
    description: 'Une équipe dédiée pour répondre à vos questions et besoins.',
    icon: 'i-lucide-headphones'
  }
]

const sectionRef = ref<any>(null) // ✅ any car c'est une instance de composant Vue
const lineVisible = ref(false)
const cardsVisible = ref(false)
let observer: IntersectionObserver | null = null

onMounted(() => {
  nextTick(() => {
    // ✅ sectionRef.value.$el = le vrai élément DOM <section>
    const el = sectionRef.value?.$el

    if (!el) return

    observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          lineVisible.value = false
          cardsVisible.value = false
          setTimeout(() => {
            lineVisible.value = true
            cardsVisible.value = true
          }, 50)
        } else {
          lineVisible.value = false
          cardsVisible.value = false
        }
      })
    }, { threshold: 0.2 })

    observer.observe(el) // ✅ observer sur le vrai DOM
  })
})

onUnmounted(() => { if (observer) observer.disconnect() })
</script>

<template>
  <UPageSection
    ref="sectionRef"
    :ui="{
      root: 'relative overflow-hidden bg-white dark:bg-gray-950 ',
      container: 'max-w-7xl',
      wrapper: 'gap-14',
      title: 'text-4xl md:text-5xl lg:text-6xl font-black tracking-tight leading-[1.05] text-center',
      description: 'text-center mt-0',
    }"
  >
    <!-- Décors background -->
    <template #top>
      <div class="absolute inset-0 pointer-events-none">
        <div class="absolute -top-60 -right-60 w-[500px] h-[500px] bg-primary/5 blur-[140px] rounded-full"></div>
        <div class="absolute -bottom-40 -left-40 w-[400px] h-[400px] bg-primary/5 blur-[120px] rounded-full"></div>
        <div
          class="absolute inset-0 opacity-[0.02] dark:opacity-[0.04]"
          style="background-image: radial-gradient(circle, #000 1px, transparent 1px); background-size: 32px 32px;"
        ></div>
      </div>
    </template>

    <!-- Badge + lignes symétriques -->
    <template #headline>
      <div class="flex items-center justify-center gap-3">
        <span class="line-anim" :class="{ 'animate-line': lineVisible }"></span>
        <span class="text-xs font-semibold uppercase tracking-[0.2em] text-primary px-3 py-1 bg-primary/10 rounded-full">
          Nos engagements
        </span>
        <span class="line-anim line-anim-right" :class="{ 'animate-line-right': lineVisible }"></span>
      </div>
    </template>

    <!-- Titre -->
    <template #title>
      Les Garanties de MR INFRA
    </template>

    <!-- Description -->
    <template #description>
      <p class="text-gray-500 dark:text-gray-400 text-lg leading-relaxed text-center max-w-xl mx-auto mt-2">
        MR INFRA s'engage à fournir un service fiable, sécurisé et de qualité pour tous vos projets.
      </p>
    </template>

    <!-- Grid cards dans le slot default -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 w-full">
      <div
        v-for="(g, i) in garanties"
        :key="i"
        class="card-enter group relative"
        :class="{ 'show-card': cardsVisible }"
        :style="{ animationDelay: `${i * 120}ms` }"
      >
        <!-- Glow hover -->
        <div class="absolute -top-4 -right-4 w-20 h-20 bg-primary/10 rounded-full blur-xl opacity-0 group-hover:opacity-100 transition-all duration-700 pointer-events-none"></div>

        <UCard
          :ui="{
            root: 'relative h-full rounded-2xl border border-gray-100 dark:border-gray-800 bg-gray-50/80 dark:bg-gray-900/80 backdrop-blur-xl hover:bg-white dark:hover:bg-gray-800 hover:border-primary/20 hover:shadow-xl hover:shadow-primary/5 transition-all duration-500 hover:-translate-y-1 overflow-hidden shadow-none',
            body: 'p-6 flex flex-col h-full',
          }"
        >
          <!-- Shimmer top border on hover -->
          <div class="absolute top-0 left-0 right-0 h-px bg-gradient-to-r from-transparent via-primary/50 to-transparent opacity-0 group-hover:opacity-100 transition-all duration-500"></div>

          <!-- ICON -->
          <div class="mb-5">
            <div class="w-11 h-11 flex items-center justify-center rounded-xl bg-primary/10 group-hover:bg-primary/20 transition-colors duration-300">
              <UIcon
                :name="g.icon"
                class="w-5 h-5 text-primary transition-transform duration-500 group-hover:scale-110"
              />
            </div>
          </div>

          <!-- TITLE -->
          <h3 class="text-base font-bold text-gray-900 dark:text-white mb-2 group-hover:text-primary transition-colors duration-300">
            {{ g.title }}
          </h3>

          <!-- DESC -->
          <p class="text-sm text-gray-500 dark:text-gray-400 leading-relaxed grow">
            {{ g.description }}
          </p>

          <!-- Bottom line -->
          <div class="mt-5 h-px w-0 bg-gradient-to-r from-primary to-primary/30 transition-all duration-500 group-hover:w-full"></div>
        </UCard>
      </div>
    </div>

  </UPageSection>
</template>

<style scoped>
.line-anim {
  display: block;
  height: 2px;
  width: 40px;
  background: linear-gradient(to right, var(--ui-color-primary-500), var(--ui-color-primary-300));
  transform: scaleX(0);
  transform-origin: left;
  flex-shrink: 0;
}
.animate-line {
  animation: growLine 0.8s cubic-bezier(0.22, 1, 0.36, 1) forwards;
}
.line-anim-right {
  background: linear-gradient(to left, var(--ui-color-primary-500), var(--ui-color-primary-300));
  transform-origin: right;
}
.animate-line-right {
  animation: growLine 0.8s cubic-bezier(0.22, 1, 0.36, 1) forwards;
  animation-delay: 0.1s;
}
@keyframes growLine { to { transform: scaleX(1); } }

.card-enter {
  opacity: 0;
  transform: translateY(30px) scale(0.97);
  filter: blur(6px);
  will-change: transform, opacity;
}
.show-card {
  animation: cardEnter 0.8s cubic-bezier(0.22, 1, 0.36, 1) forwards;
}
@keyframes cardEnter {
  0%   { opacity: 0; transform: translateY(30px) scale(0.97); filter: blur(6px); }
  100% { opacity: 1; transform: translateY(0) scale(1); filter: blur(0); }
}
</style>