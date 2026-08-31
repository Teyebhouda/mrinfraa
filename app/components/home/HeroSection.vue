<script setup lang="ts">
interface Slide {
  title: string
  subtitle: string
  background_image: string
}

const props = defineProps<{
  data?: {
    slides?: Slide[]
  }
}>()

const slides = computed(() => props.data?.slides ?? [])
const active = ref(0)
const fade = ref(false)

const garanties = [
  'Travail garanti',
  'Respect des délais',
  'Matériaux de qualité',
  'Support client'
]
const activeGarantie = ref(0)

let slideInterval: any
let garantieInterval: any

const startIntervals = () => {
  if (slides.value.length > 1) {
    slideInterval = setInterval(() => {
      active.value = (active.value + 1) % slides.value.length
    }, 6000)
  }
  garantieInterval = setInterval(() => {
    activeGarantie.value = (activeGarantie.value + 1) % garanties.length
  }, 6000)
}

const stopIntervals = () => {
  clearInterval(slideInterval)
  clearInterval(garantieInterval)
}

watch(active, (newIndex) => {
  fade.value = true
  const timer = setTimeout(() => (fade.value = false), 500)
  const nextIndex = (newIndex + 1) % slides.value.length
  if (slides.value[nextIndex]) {
    const img = new Image()
    img.src = slides.value[nextIndex].background_image
  }
  onBeforeUnmount(() => clearTimeout(timer))
})

onMounted(() => {
  startIntervals()
  if (typeof window !== 'undefined') {
    const handleScroll = () => window.requestAnimationFrame(() => {})
    window.addEventListener('scroll', handleScroll)
    onBeforeUnmount(() => window.removeEventListener('scroll', handleScroll))
  }
})

onBeforeUnmount(() => stopIntervals())
</script>

<template>
<section v-if="slides.length" class="hero">

  <!-- Images Ken Burns -->
  <transition-group name="slide-fade">
    <div
      v-for="(slide, i) in slides"
      :key="i"
      v-show="i === active"
      class="hero-bg"
      :style="{ backgroundImage: `url(${slide.background_image})` }"
    />
  </transition-group>

  <!-- Overlay -->
  <div class="hero-overlay"></div>

  <!-- Content -->
  <div class="hero-content">
    <transition name="content-fade" mode="out-in">
      <div :key="active">
        <h1>{{ slides[active]?.title }}</h1>
        <div class="hero-underline"></div>
        <p>{{ slides[active]?.subtitle }}</p>

        <!-- ✅ UButton au lieu de NuxtLink custom -->
        <UButton
          to="/#ContactSection"
          color="primary"
          size="xl"
          class="mt-5 rounded-2xl shadow-[0_10px_30px_rgba(0,0,0,0.2)] hover:shadow-[0_15px_40px_rgba(0,0,0,0.3)] hover:-translate-y-0.5 transition-all duration-300 font-semibold"
        >
          Nous contacter
        </UButton>
      </div>
    </transition>
  </div>

  <!-- ✅ Dots avec UButton -->
  <div class="hero-dots">
    <UButton
      v-for="(_, i) in slides"
      :key="i"
      :aria-label="`Slide ${i + 1}`"
      color="neutral"
      variant="ghost"
      class="dot-btn p-0"
      :class="{ 'dot-active': i === active }"
      @click="active = i"
    >
      <span class="dot-inner"></span>
    </UButton>
  </div>

  <!-- Garanties — reste custom (animation CSS complexe) -->
  <div class="hero-garanties">
    <span
      v-for="(item, i) in garanties"
      :key="i"
      class="garantie"
      :class="{ active: i === activeGarantie }"
    >
      {{ item }}
      <span class="garantie-line" :class="{ animate: i === activeGarantie }"></span>
    </span>
  </div>

  <!-- Scroll indicator — reste custom 
  <div class="scroll-indicator">
    <div class="mouse"><div class="wheel"></div></div>
    <span class="scroll-text">Scroll</span>
  </div>  -->

</section>
</template>

<style scoped>
.hero {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  height: calc(100vh - 96px);
  overflow: hidden;
  touch-action: pan-y;
}

.hero-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(to bottom, rgba(0,0,0,0.4), rgba(0,0,0,0.6));
}

.hero-content {
  position: relative;
  z-index: 2;
  max-width: 900px;
  text-align: center;
  color: white;
  padding: 0 20px;
}

.hero-content h1 {
  font-size: clamp(2.2rem, 5vw, 3.8rem);
  font-weight: 800;
  letter-spacing: -0.02em;
  line-height: 1.1;
  margin: 0;
}

.hero-underline {
  width: 80px;
  height: 3px;
  background: linear-gradient(to right, var(--ui-color-primary-500), transparent);
  margin: 18px auto;
}

.hero-content p {
  font-size: clamp(1rem, 1.5vw, 1.25rem);
  margin: 14px 0;
  opacity: 0.9;
  line-height: 1.6;
}

/* ✅ Dots avec UButton */
.hero-dots {
  position: absolute;
  right: 20px;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  gap: 10px;
  z-index: 3;
}

.dot-btn {
  width: 12px !important;
  height: 12px !important;
  min-width: 12px !important;
  min-height: 12px !important;
  border-radius: 50% !important;
  background: rgba(255,255,255,0.4) !important;
  transition: transform 0.3s ease, background 0.3s ease !important;
}

.dot-btn:hover { transform: scale(1.5) !important; }

.dot-active {
  background: var(--ui-color-primary-500) !important;
  transform: scale(1.3) !important;
}

.dot-inner { display: none; }

/* Garanties */
.hero-garanties {
  position: absolute;
  bottom: 20px;
  left: 20px;
  display: flex;
  flex-wrap: wrap;
  gap: 18px;
  font-size: 0.85rem;
  text-transform: uppercase;
  color: rgba(255,255,255,0.7);
  z-index: 3;
}
.garantie {
  position: relative;
  font-weight: 400;
  transition: color 0.3s ease;
}
.garantie.active { color: white; font-weight: 600; }
.garantie-line {
  position: absolute;
  left: 0;
  bottom: -4px;
  height: 3px;
  background: var(--ui-color-primary-500);
  width: 0;
}
.garantie-line.animate {
  animation: growLine 6s linear forwards;
}
@keyframes growLine {
  from { width: 0; }
  to { width: 100%; }
}

/* Scroll indicator */
.scroll-indicator {
  position: absolute;
  bottom: 25px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 3;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  opacity: 0.8;
}
.scroll-indicator:hover { opacity: 1; }
.mouse {
  width: 26px;
  height: 42px;
  border: 2px solid white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  padding-top: 6px;
}
.wheel {
  width: 4px;
  height: 8px;
  background: white;
  border-radius: 2px;
  animation: scrollWheel 1.8s infinite;
}
.scroll-text {
  font-size: 0.7rem;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: rgba(255,255,255,0.7);
}
@keyframes scrollWheel {
  0%  { opacity: 0; transform: translateY(0); }
  40% { opacity: 1; }
  80% { transform: translateY(10px); opacity: 0; }
  100%{ opacity: 0; }
}

/* Ken Burns */
.hero-bg {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  z-index: 0;

  /* 🔥 ZOOM Ken Burns */
  animation: kenBurns 8s ease-in-out forwards;
  will-change: transform;
}

/* 🔥 Effet zoom progressif moderne */
@keyframes kenBurns {
  0% {
    transform: scale(1) translate(0, 0);
  }
  100% {
    transform: scale(1.12) translate(-1%, -1%);
  }
}

/* ✅ Transition entre slides */
.slide-fade-enter-active,
.slide-fade-leave-active {
  transition: opacity 1s ease;
  position: absolute;
  inset: 0;
}
.slide-fade-enter-from { opacity: 0; }
.slide-fade-leave-to { opacity: 0; }

/* ✅ Transition du contenu texte */
.content-fade-enter-active,
.content-fade-leave-active {
  transition: opacity 0.6s ease, transform 0.6s ease;
}
.content-fade-enter-from {
  opacity: 0;
  transform: translateY(20px);
}
.content-fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}
</style>