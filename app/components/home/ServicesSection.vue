<script setup lang="ts">
const props = defineProps<{
  services: Array<{
    id: number
    title: string
    slug: string
    description: string
    long_description?: string
    background_image?: string
  }>
}>()

const config = useRuntimeConfig()

const getServiceImage = (path?: string) => {
  if (!path) return undefined
  if (path.startsWith('http')) return path
  return `${config.public.backendBase}${path}`
}

const activeIndex = ref(0)
const activeService = computed(() => props.services[activeIndex.value])

const leftVisible = ref(false)
const rightVisible = ref(false)
const cardsVisible = ref(false)
const lineVisible = ref(false)

const leftCol = ref<HTMLElement | null>(null)
const rightCol = ref<HTMLElement | null>(null)
let observer: IntersectionObserver | null = null

onMounted(() => {
  nextTick(() => {
    observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          if (entry.target === leftCol.value) {
            leftVisible.value = false
            cardsVisible.value = false
            lineVisible.value = false
            setTimeout(() => {
              leftVisible.value = true
              cardsVisible.value = true
              lineVisible.value = true
            }, 100)
          }
          if (entry.target === rightCol.value) {
            rightVisible.value = false
            setTimeout(() => { rightVisible.value = true }, 200)
          }
        } else {
          if (entry.target === leftCol.value) {
            leftVisible.value = false
            cardsVisible.value = false
            lineVisible.value = false
          }
          if (entry.target === rightCol.value) { rightVisible.value = false }
        }
      })
    }, { threshold: 0.2 })

    if (leftCol.value) observer.observe(leftCol.value)
    if (rightCol.value) observer.observe(rightCol.value)
  })
})

onUnmounted(() => { if (observer) observer.disconnect() })
</script>

<template>
  <UPageSection
    id="ServicesSection"
    orientation="horizontal"
    :ui="{
      root: 'relative overflow-hidden bg-gray-50 dark:bg-gray-950 ',
      container: 'max-w-7xl',
      wrapper: 'lg:grid-cols-2 gap-8 items-stretch',
      header: 'flex flex-col justify-center',
      title: 'text-4xl md:text-5xl lg:text-6xl font-black tracking-tight leading-[1.05]',
      description: 'mt-0',
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

    <!-- Badge + ligne -->
    <template #headline>
      <div class="flex items-center gap-3">
        <span class="line-anim" :class="{ 'animate-line': lineVisible }"></span>
        <span class="text-xs font-semibold uppercase tracking-[0.2em] text-primary px-3 py-1 bg-primary/10 rounded-full">
          Nos expertises
        </span>
      </div>
    </template>

    <!-- Titre -->
    <template #title>
      Savoir-faire & expertises
    </template>

    <!-- Description -->
    <template #description>
      <div class="flex gap-5 mt-4">
        <div class="w-0.5 bg-gradient-to-b from-primary to-transparent flex-shrink-0 rounded-full"></div>
        <p class="text-gray-500 dark:text-gray-400 text-lg leading-relaxed">
          Une expertise complète pour tous vos projets de construction et de rénovation.
        </p>
      </div>
    </template>

    <!-- Slot body — Liste services (gauche) -->
    <template #body>
      <div
        ref="leftCol"
        class="flex flex-col gap-4 left-section"
        :class="{ 'show-left': leftVisible }"
      >
        <div
          v-for="(service, index) in services"
          :key="service.id"
          @click="activeIndex = index"
          class="service-card relative group cursor-pointer rounded-2xl border transition-all duration-500"
          :class="[
            cardsVisible ? 'show-service' : '',
            activeIndex === index
              ? 'border-primary/30 bg-white dark:bg-gray-800 shadow-lg shadow-primary/5'
              : 'border-gray-100 dark:border-gray-800 bg-gray-50/80 dark:bg-gray-900/80 hover:bg-white dark:hover:bg-gray-800 hover:border-primary/20 hover:shadow-lg hover:shadow-primary/5'
          ]"
          :style="{ animationDelay: `${index * 120}ms` }"
        >
          <!-- Barre active gauche -->
          <div
            class="absolute left-0 top-3 bottom-3 w-0.5 rounded-full bg-primary transition-all duration-500"
            :class="activeIndex === index ? 'opacity-100' : 'opacity-0'"
          ></div>

          <!-- Glow hover -->
          <div class="absolute -top-4 -right-4 w-16 h-16 bg-primary/10 rounded-full blur-xl opacity-0 group-hover:opacity-100 transition-all duration-700"></div>

          <div class="relative z-10 p-5 flex items-start gap-4">
            <div>
              <h3
                class="text-base font-bold transition-colors duration-300"
                :class="activeIndex === index ? 'text-primary' : 'text-gray-900 dark:text-white group-hover:text-primary'"
              >
                {{ service.title }}
              </h3>
              <p class="text-sm text-gray-500 dark:text-gray-400 mt-1 line-clamp-2">
                {{ service.description }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </template>

    <!-- Slot default — Détail service actif (droite) -->
    <div
      ref="rightCol"
      class="flex flex-col justify-center right-section"
      :class="{ 'show-right': rightVisible }"
    >
      <transition name="service-content" mode="out-in">
        <div :key="activeService?.id" class="flex flex-col gap-6">

          <!-- IMAGE -->
          <div class="relative h-56 sm:h-72 rounded-2xl overflow-hidden border border-gray-100 dark:border-gray-800 shadow-xl">
            <NuxtImg
              :src="getServiceImage(activeService?.background_image)"
              class="w-full h-full object-cover hover:scale-105 transition-transform duration-700"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-black/40 to-transparent"></div>
            <div class="absolute bottom-4 left-4">
              <UBadge :label="activeService?.title" color="primary" variant="solid" class="rounded-full" />
            </div>
          </div>

          <!-- CARD DÉTAIL -->
          <UCard
            :ui="{
              root: 'rounded-2xl border border-gray-100 dark:border-gray-800 bg-white/80 dark:bg-gray-900/80 backdrop-blur-xl shadow-none',
              body: 'p-6',
            }"
          >
            <h3 class="text-xl font-black text-gray-900 dark:text-white mb-4 tracking-tight">
              {{ activeService?.title }}
            </h3>

            <div
              class="text-gray-500 dark:text-gray-400 leading-relaxed prose prose-sm dark:prose-invert max-w-none"
              v-html="activeService?.long_description || activeService?.description"
            ></div>

            <!-- CTA avec UButton -->
            <UButton
              :to="`/services/${activeService?.slug}`"
              color="primary"
              variant="soft"
              trailing-icon="i-lucide-arrow-right"
              class="mt-5"
            >
              En savoir plus
            </UButton>
          </UCard>

        </div>
      </transition>
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
@keyframes growLine { to { transform: scaleX(1); } }

.left-section {
  opacity: 0;
  transform: translateX(-40px);
  filter: blur(8px);
  transition: opacity 1s ease, transform 1s cubic-bezier(0.22, 1, 0.36, 1), filter 1s ease;
}
.show-left { opacity: 1; transform: translateX(0); filter: blur(0); }

.right-section {
  opacity: 0;
  transform: translateX(40px);
  filter: blur(8px);
  transition: opacity 1s ease, transform 1s cubic-bezier(0.22, 1, 0.36, 1), filter 1s ease;
  transition-delay: 0.15s;
}
.show-right { opacity: 1; transform: translateX(0); filter: blur(0); }

.service-card {
  opacity: 0;
  transform: translateY(30px) scale(0.97);
  filter: blur(6px);
}
.show-service {
  animation: serviceEnter 0.8s cubic-bezier(0.22, 1, 0.36, 1) forwards;
}
@keyframes serviceEnter {
  0%   { opacity: 0; transform: translateY(30px) scale(0.97); filter: blur(6px); }
  100% { opacity: 1; transform: translateY(0) scale(1); filter: blur(0); }
}

.service-content-enter-active,
.service-content-leave-active { transition: all 0.45s ease; }
.service-content-enter-from {
  opacity: 0;
  transform: translateY(20px) scale(0.98);
  filter: blur(8px);
}
.service-content-leave-to { opacity: 0; transform: translateY(-10px); }

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>