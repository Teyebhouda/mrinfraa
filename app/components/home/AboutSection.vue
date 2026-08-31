<script setup lang="ts">
const props = defineProps<{
  data?: {
    title?: string
    description?: string
    badge?: string
    stats?: Array<{ label: string; value: number; suffix?: string; icon?: string }>
  }
}>()

const animateValue = (el: HTMLElement, end: number) => {
  const duration = 2000
  const startTime = performance.now()
  const update = (currentTime: number) => {
    const progress = Math.min((currentTime - startTime) / duration, 1)
    const eased = 1 - Math.pow(1 - progress, 3)
    el.innerText = Math.floor(eased * end).toString()
    if (progress < 1) requestAnimationFrame(update)
    else el.innerText = end.toString()
  }
  requestAnimationFrame(update)
}

const leftCol = ref<HTMLElement | null>(null)
const rightCol = ref<HTMLElement | null>(null)
const leftVisible = ref(false)
const rightVisible = ref(false)
const statsVisible = ref(false)
const lineVisible = ref(false)
let observer: IntersectionObserver | null = null

onMounted(() => {
  nextTick(() => {
    observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          if (entry.target === leftCol.value) {
            setTimeout(() => { leftVisible.value = true; lineVisible.value = true }, 100)
          }
          if (entry.target === rightCol.value) {
            setTimeout(() => {
              rightVisible.value = true
              statsVisible.value = true
              document.querySelectorAll('[data-counter]').forEach((el: any) => {
                animateValue(el, parseInt(el.dataset.counter))
              })
            }, 250)
          }
        } else {
          if (entry.target === leftCol.value) { leftVisible.value = false; lineVisible.value = false }
          if (entry.target === rightCol.value) { rightVisible.value = false; statsVisible.value = false }
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
    id="AboutSection"
    orientation="horizontal"
    :ui="{
      root: 'relative overflow-hidden bg-white dark:bg-gray-950 ',
      container: 'max-w-7xl',
      wrapper: 'lg:grid-cols-3 gap-16 items-center',
      header: 'lg:col-span-2',
      title: 'text-4xl md:text-5xl lg:text-6xl font-black tracking-tight leading-[1.05]',
      description: 'text-gray-500 dark:text-gray-400 text-lg leading-relaxed mt-0',
    }"
  >
    <!-- Fonds décoratifs -->
    <template #top>
      <div class="absolute inset-0 pointer-events-none">
        <div class="absolute -top-60 -left-60 w-[500px] h-[500px] bg-primary/5 blur-[140px] rounded-full"></div>
        <div class="absolute -bottom-40 -right-40 w-[400px] h-[400px] bg-yellow-400/5 blur-[120px] rounded-full"></div>
        <div
          class="absolute inset-0 opacity-[0.02] dark:opacity-[0.04]"
          style="background-image: radial-gradient(circle, #000 1px, transparent 1px); background-size: 32px 32px;"
        ></div>
      </div>
    </template>

    <!-- Badge + ligne animée -->
    <template #headline>
      <div class="flex items-center gap-3">
        <span class="line-anim" :class="{ 'animate-line': lineVisible }"></span>
        <span class="text-xs font-semibold uppercase tracking-[0.2em] text-primary px-3 py-1 bg-primary/10 rounded-full">
          {{ props.data?.badge ?? 'Qui sommes-nous' }}
        </span>
      </div>
    </template>

    <!-- Titre -->
    <template #title>
      <div
        ref="leftCol"
        class="left-section"
        :class="{ 'show-left': leftVisible }"
      >
        {{ props.data?.title }}
      </div>
    </template>

    <!-- Description avec bordure gauche -->
    <template #description>
      <div class="flex gap-5 mt-6">
        <div class="w-0.5 bg-gradient-to-b from-primary to-transparent flex-shrink-0 rounded-full"></div>
        <p class="text-gray-500 dark:text-gray-400 text-lg leading-relaxed">
          {{ props.data?.description }}
        </p>
      </div>
    </template>

    <!-- RIGHT — Stats dans le slot default -->
    <div
      ref="rightCol"
      class="relative pl-10 flex flex-col justify-center right-section"
      :class="{ 'show-right': rightVisible }"
    >
      <!-- Ligne verticale timeline -->
      <div class="absolute left-3 top-0 bottom-0 w-px bg-gradient-to-b from-transparent via-primary/30 to-transparent"></div>

      <div class="flex flex-col gap-5">
        <div
          v-for="(stat, i) in props.data?.stats"
          :key="i"
          class="stat-card group"
          :class="{ 'show-stat': statsVisible }"
          :style="{ animationDelay: `${i * 130}ms` }"
        >
          <!-- Point timeline -->
          <div class="absolute -left-[38px] top-1/2 -translate-y-1/2 w-3.5 h-3.5 rounded-full bg-primary ring-4 ring-primary/20 transition-all duration-500 group-hover:scale-150 group-hover:ring-primary/40"></div>

          <!-- Card -->
          <div class="relative p-5 rounded-2xl border border-gray-100 dark:border-gray-800 bg-gray-50/80 dark:bg-gray-900/80 backdrop-blur-xl hover:bg-white dark:hover:bg-gray-800 hover:border-primary/20 hover:shadow-xl hover:shadow-primary/5 transition-all duration-500 hover:-translate-y-1 overflow-hidden">

            <div class="absolute -top-4 -right-4 w-16 h-16 bg-primary/10 rounded-full blur-xl opacity-0 group-hover:opacity-100 transition-all duration-700"></div>

            <div class="flex items-center gap-4 relative z-10">
              <!-- Icône -->
              <div class="w-10 h-10 rounded-xl bg-primary/10 flex items-center justify-center flex-shrink-0 group-hover:bg-primary/20 transition-colors duration-300">
                <UIcon :name="stat.icon ?? 'i-lucide-trending-up'" class="w-5 h-5 text-primary" />
              </div>

              <div>
                <p class="text-4xl font-black tabular-nums text-gray-900 dark:text-white leading-none">
                  <span :data-counter="stat.value">0</span>
                  <span class="text-primary text-3xl">{{ stat.suffix ?? '+' }}</span>
                </p>
                <p class="mt-1 text-sm font-medium text-gray-500 dark:text-gray-400">
                  {{ stat.label }}
                </p>
              </div>
            </div>

          </div>
        </div>
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

.stat-card {
  position: relative;
  opacity: 0;
  transform: translateY(30px) scale(0.97);
  filter: blur(6px);
}
.show-stat {
  animation: statEnter 0.8s cubic-bezier(0.22, 1, 0.36, 1) forwards;
}
@keyframes statEnter {
  0%   { opacity: 0; transform: translateY(30px) scale(0.97); filter: blur(6px); }
  100% { opacity: 1; transform: translateY(0) scale(1); filter: blur(0); }
}
.tabular-nums { font-variant-numeric: tabular-nums; }
</style>