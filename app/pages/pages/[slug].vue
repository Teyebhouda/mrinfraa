<script setup lang="ts">
import { computed, onMounted, watch } from 'vue'

const route = useRoute()
const slug = computed(() => route.params.slug as string)

const { apiFetch } = useApi()

// ✅ FETCH SSR (SEO OK)
const { data, pending, error, refresh } = await useAsyncData<{ page: any }>(
  () => `page-${slug.value}`,
  () => apiFetch(`/pages/${slug.value}`)
)

// ✅ PAGE
const page = computed(() => data.value?.page)


// 🔥 FORCE REFRESH CLIENT (Hostinger fix)
onMounted(() => {
  refresh()
})

// 🔥 RELOAD SI SLUG CHANGE
watch(slug, () => {
  refresh()
})


// ✅ SEO
useHead(() => ({
  title: page.value?.meta?.title || page.value?.title || 'Page',
  meta: [
    {
      name: 'description',
      content: page.value?.meta?.description || ''
    },
    {
      name: 'keywords',
      content: page.value?.meta?.keywords || ''
    }
  ]
}))
</script>
<template>
  <section class="py-24 bg-white dark:bg-gray-900 min-h-screen">
     
    <UContainer>

      <!-- Loading -->
      <div v-if="pending" class="text-center text-gray-500">
        Chargement...
      </div>

      <!-- Error -->
      <div v-else-if="error" class="text-center text-red-500">
        Erreur de chargement
      </div>

      <!-- Not found -->
      <div v-else-if="!page" class="text-center text-red-500">
        Page introuvable
      </div>

      <!-- Content -->
      <article
        v-else
        class="max-w-3xl mx-auto space-y-10"
      >
        <h1 class="text-3xl font-light tracking-wide text-gray-900 dark:text-white">
          {{ page.title }}
        </h1>

        <div
          v-if="page.content"
          class="prose prose-neutral max-w-none"
          v-html="page.content"
        />

        <p v-else class="text-sm text-gray-500 italic">
          Contenu à venir.
        </p>
      </article>

    </UContainer>
  </section>
</template>