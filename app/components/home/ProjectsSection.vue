<script setup lang="ts">
const props = defineProps<{
  projects: any[]
  prevIcon?: string
  nextIcon?: string
}>()

const config = useRuntimeConfig()
const activeProject = ref<any | null>(null)
const projectDetails = ref<any | null>(null)
const loading = ref(false)
const selectedImageIndex = ref(0)

const getImage = (path?: string) => {
  if (!path) return ''
  if (path.startsWith('http')) return path
  return `${config.public.backendBase}/storage/${path}`
}

const openProject = async (project: any) => {
  activeProject.value = project
  selectedImageIndex.value = 0
  loading.value = true
  projectDetails.value = null
  try {
    const res: any = await $fetch(`/api/projects/${project.slug}`)
    projectDetails.value = res.data
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

const closeProject = () => { activeProject.value = null }

const prevImage = () => {
  selectedImageIndex.value =
    (selectedImageIndex.value - 1 + activeProject.value.images.length) % activeProject.value.images.length
}

const nextImage = () => {
  selectedImageIndex.value =
    (selectedImageIndex.value + 1) % activeProject.value.images.length
}
</script>

<template>
  <section id="ProjectsSection" class="relative h-[70vh] md:h-[90vh] w-full overflow-hidden">

    <UCarousel
      v-slot="{ item }"
      loop
      arrows
      :prev-icon="prevIcon"
      :next-icon="nextIcon"
      dots
      :autoplay="{ delay: 5000 }"
      :items="props.projects"
      class="h-full"
      :ui="{ item: 'basis-full' }"
    >
      <div class="relative h-[70vh] sm:h-[80vh] md:h-screen w-full group overflow-hidden">

        <!-- ✅ Ken Burns comme HeroSection -->
        <NuxtImg
          v-if="item.images?.[0]?.path"
          :src="getImage(item.images[0].path)"
          class="absolute inset-0 w-full h-full object-cover transition-transform duration-[8000ms] ease-out scale-100 group-hover:scale-110"
        />

        <!-- Overlay dégradé -->
        <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/30 to-transparent"></div>

        <!-- Contenu -->
        <div class="relative z-10 h-full flex flex-col justify-end sm:justify-center items-center text-center text-white px-6 pb-16 sm:pb-0">

          <!-- Badge catégorie -->
          <span
            v-if="item.category"
            class="mb-4 text-xs font-semibold uppercase tracking-[0.2em] px-3 py-1 bg-primary/80 backdrop-blur-sm rounded-full"
          >
            {{ item.category }}
          </span>

          <h2 class="text-3xl sm:text-4xl md:text-6xl font-black tracking-tight leading-[1.05] mb-4 max-w-3xl">
            {{ item.title }}
          </h2>

          <p class="text-sm sm:text-base md:text-lg max-w-xl text-white/75 mb-8 leading-relaxed">
            {{ item.description }}
          </p>

          <button
            @click="openProject(item)"
            class="group/btn inline-flex items-center gap-2 px-6 py-3 bg-white text-gray-900 rounded-full text-sm font-semibold hover:bg-primary hover:text-white transition-all duration-300 hover:gap-3 shadow-lg"
          >
            <span>Explorer le projet</span>
            <UIcon name="i-lucide-arrow-right" class="w-4 h-4" />
          </button>

        </div>
      </div>
    </UCarousel>

    <!-- ✅ MODAL PREMIUM -->
    <transition name="modal-fade">
      <div
        v-if="activeProject"
        class="fixed inset-0 z-50 flex items-end md:items-center justify-center p-0 md:p-6"
        @click.self="closeProject"
      >
        <!-- Backdrop blur -->
        <div class="absolute inset-0 bg-black/70 backdrop-blur-sm" @click="closeProject"></div>

        <div class="modal-panel relative bg-white dark:bg-gray-900 w-full md:max-w-4xl md:rounded-2xl rounded-t-3xl h-[92vh] md:h-auto md:max-h-[88vh] flex flex-col overflow-hidden shadow-2xl">

          <!-- Handle mobile -->
          <div class="flex justify-center pt-3 pb-1 md:hidden flex-shrink-0">
            <div class="w-10 h-1 bg-gray-300 dark:bg-gray-600 rounded-full"></div>
          </div>

          <!-- ✅ IMAGE SECTION -->
          <div class="relative flex-shrink-0">
            <transition name="img-fade" mode="out-in">
              <NuxtImg
                v-if="activeProject.images?.[selectedImageIndex]?.path"
                :key="selectedImageIndex"
                :src="getImage(activeProject.images[selectedImageIndex].path)"
                class="w-full h-52 sm:h-64 md:h-80 object-cover"
              />
            </transition>

            <!-- Overlay dégradé bas sur image -->
            <div class="absolute inset-0 bg-gradient-to-t from-black/50 to-transparent pointer-events-none"></div>

            <!-- Close button -->
            <button
              @click="closeProject"
              class="absolute top-3 right-3 w-8 h-8 bg-black/50 hover:bg-black/70 backdrop-blur-sm text-white rounded-full flex items-center justify-center transition-all duration-200 hover:scale-110"
            >
              <UIcon name="i-lucide-x" class="w-4 h-4" />
            </button>

            <!-- Navigation arrows -->
            <template v-if="activeProject.images?.length > 1">
              <button
                @click="prevImage"
                class="absolute left-3 top-1/2 -translate-y-1/2 w-9 h-9 bg-black/50 hover:bg-primary backdrop-blur-sm text-white rounded-full flex items-center justify-center transition-all duration-300"
              >
                <UIcon name="i-lucide-chevron-left" class="w-5 h-5" />
              </button>
              <button
                @click="nextImage"
                class="absolute right-3 top-1/2 -translate-y-1/2 w-9 h-9 bg-black/50 hover:bg-primary backdrop-blur-sm text-white rounded-full flex items-center justify-center transition-all duration-300"
              >
                <UIcon name="i-lucide-chevron-right" class="w-5 h-5" />
              </button>

              <!-- Compteur images -->
              <div class="absolute bottom-3 right-4 text-white/80 text-xs font-medium bg-black/40 px-2 py-0.5 rounded-full backdrop-blur-sm">
                {{ selectedImageIndex + 1 }} / {{ activeProject.images.length }}
              </div>
            </template>
          </div>

          <!-- ✅ MINIATURES -->
          <div
            v-if="activeProject.images?.length > 1"
            class="flex gap-2 px-4 py-3 overflow-x-auto flex-shrink-0 border-b border-gray-100 dark:border-gray-800"
          >
            <button
              v-for="(img, index) in activeProject.images"
              :key="img.id"
              @click="selectedImageIndex = Number(index)"
              class="flex-shrink-0 rounded-lg overflow-hidden transition-all duration-300 ring-2"
              :class="selectedImageIndex === index
                ? 'ring-primary scale-105'
                : 'ring-transparent opacity-60 hover:opacity-100'"
            >
              <NuxtImg :src="getImage(img.path)" class="w-14 h-14 object-cover" />
            </button>
          </div>

          <!-- ✅ CONTENU SCROLLABLE -->
          <div class="flex-1 overflow-y-auto p-5 md:p-7 space-y-4">

            <!-- Loading skeleton -->
            <div v-if="loading" class="space-y-3">
              <USkeleton class="h-7 w-2/3 rounded-xl" />
              <USkeleton class="h-4 w-1/3 rounded-xl" />
              <USkeleton class="h-20 w-full rounded-xl" />
            </div>

            <template v-else>
              <!-- Titre + location -->
              <div class="flex items-start justify-between gap-4">
                <h2 class="text-xl md:text-2xl font-black tracking-tight text-gray-900 dark:text-white">
                  {{ activeProject.title }}
                </h2>
                <span
                  v-if="activeProject.location"
                  class="flex-shrink-0 inline-flex items-center gap-1 text-xs text-gray-500 dark:text-gray-400 bg-gray-100 dark:bg-gray-800 px-3 py-1 rounded-full"
                >
                  <UIcon name="i-lucide-map-pin" class="w-3 h-3" />
                  {{ activeProject.location }}
                </span>
              </div>

              <!-- Description -->
              <p class="text-gray-500 dark:text-gray-400 leading-relaxed text-sm md:text-base">
                {{ activeProject.description }}
              </p>

              <!-- Contenu long -->
              <div
                v-if="projectDetails?.content"
                class="prose prose-sm dark:prose-invert max-w-none text-gray-600 dark:text-gray-300"
                v-html="projectDetails.content"
              ></div>
            </template>

          </div>

          <!-- ✅ CTA — harmonisé -->
          <div class="flex-shrink-0 p-4 md:p-5 border-t border-gray-100 dark:border-gray-800 bg-gray-50/80 dark:bg-gray-900/80 backdrop-blur-sm">
            <NuxtLink
              to="#ContactSection"
              @click="closeProject"
              class="flex items-center justify-center gap-2 w-full px-6 py-3 bg-primary text-white rounded-xl font-semibold hover:bg-primary/90 active:scale-[0.98] transition-all duration-300 shadow-lg shadow-primary/20"
            >
              <UIcon name="i-lucide-message-circle" class="w-5 h-5" />
              <span>Contactez-nous pour votre projet</span>
            </NuxtLink>
          </div>

        </div>
      </div>
    </transition>

  </section>
</template>

<style scoped>
/* MODAL ENTRANCE */
.modal-fade-enter-active { transition: opacity 0.3s ease; }
.modal-fade-leave-active { transition: opacity 0.25s ease; }
.modal-fade-enter-from,
.modal-fade-leave-to { opacity: 0; }

/* PANEL slide up mobile */
.modal-fade-enter-active .modal-panel {
  animation: slideUp 0.4s cubic-bezier(0.22, 1, 0.36, 1) forwards;
}
.modal-fade-leave-active .modal-panel {
  animation: slideDown 0.25s ease forwards;
}
@keyframes slideUp {
  from { transform: translateY(60px); opacity: 0; }
  to   { transform: translateY(0);    opacity: 1; }
}
@keyframes slideDown {
  from { transform: translateY(0);    opacity: 1; }
  to   { transform: translateY(60px); opacity: 0; }
}

/* IMAGE transition */
.img-fade-enter-active,
.img-fade-leave-active { transition: opacity 0.3s ease; }
.img-fade-enter-from,
.img-fade-leave-to { opacity: 0; }

/* Scrollbar */
.overflow-y-auto::-webkit-scrollbar { width: 4px; }
.overflow-y-auto::-webkit-scrollbar-thumb {
  background: rgba(0,0,0,0.15);
  border-radius: 10px;
}
</style>