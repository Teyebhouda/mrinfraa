<script setup lang="ts">
import { computed } from 'vue'
import type { UserProps } from '@nuxt/ui'

// Props depuis ton API home
const props = defineProps<{
  testimonials?: {
    content?: {
      title?: string
      items?: Array<{
        name: string
        role: string
        message: string
      }>
    }
  }
}>()

// Transforme tes items pour le composant Nuxt UI
const testimonials = computed(() => {
  return props.testimonials?.content?.items?.map((t) => ({
    user: {
      name: t.name,
      description: t.role,
      avatar: {
        src: 'https://via.placeholder.com/80', // placeholder avatar
        loading: 'lazy' as const
      }
    },
    quote: t.message
  })) || []
})
</script>

<template>
<section class="py-28 bg-gray-50 dark:bg-gray-950">
  <div class="max-w-7xl mx-auto px-6">

    <!-- TITRE -->
    <div class="text-center mb-12">
      <h2 class="text-4xl md:text-5xl font-semibold text-gray-900 dark:text-white">
        {{ props.testimonials?.content?.title || "Ce que disent nos clients" }}
      </h2>
    </div>

    <!-- MARQUEE TESTIMONIALS -->
    <div class="flex flex-col gap-6">
      <UMarquee
        pause-on-hover
        :overlay="false"
        :ui="{ root: '[--gap:--spacing(4)]', content: 'w-auto py-1' }"
      >
        <UPageCard
          v-for="(testimonial, index) in testimonials"
          :key="index"
          variant="subtle"
          :description="testimonial.quote"
          :ui="{ description: 'before:content-[open-quote] after:content-[close-quote] line-clamp-3' }"
          class="w-64 shrink-0"
        >
          <template #footer>
            <UUser v-bind="testimonial.user" size="xl" :ui="{ description: 'line-clamp-1' }" />
          </template>
        </UPageCard>
      </UMarquee>

     
    </div>
  </div>
</section>
</template>

<style>
/* Clamp text si nécessaire */
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.line-clamp-1 {
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>