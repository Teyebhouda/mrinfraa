<script setup lang="ts">
const route = useRoute()
const config = useRuntimeConfig()
const slug = computed(() => route.params.slug as string)

// ✅ SSR fetch — pas de immediate:false, pas de onMounted refresh
const { data, error } = await useFetch<{ data: any }>(
  () => `${config.public.apiBase}/services/${slug.value}`,
  {
    key: () => `service-${slug.value}`, // ✅ clé unique par service
    // ❌ supprimé: immediate: false
  }
)

const service = computed(() => data.value?.data ?? null)

// IMAGE
const getImage = (path?: string) => {
  if (!path) return ''
  if (path.startsWith('http')) return path
  return `${config.public.backendBase}${path}`
}

// SCROLL ANIMATION
const visible = ref(false)
onMounted(() => setTimeout(() => { visible.value = true }, 200))

// ✅ SEO — données disponibles dès le SSR
useSeoMeta({
  title: () =>
    service.value?.seo?.title ||
    `${service.value?.title ?? ''} à Montreuil (93100) | MR INFRA`,

  description: () =>
    service.value?.seo?.description ||
    `${service.value?.description ?? ''} Intervention rapide à Montreuil et en Île-de-France.`,

  keywords: () =>
    service.value?.seo?.keywords ||
    `${service.value?.title ?? ''}, maçonnerie Montreuil, gros œuvre 93`,

  ogTitle: () => service.value?.seo?.title || service.value?.title,
  ogDescription: () => service.value?.seo?.description || service.value?.description,
  ogImage: () => service.value?.background_image ? getImage(service.value.background_image) : '',
  ogType: 'article',

  twitterCard: 'summary_large_image',
  twitterTitle: () => service.value?.seo?.title || service.value?.title,
  twitterDescription: () => service.value?.seo?.description || service.value?.description,
  twitterImage: () => service.value?.background_image ? getImage(service.value.background_image) : '',
})

useHead({
  link: [
    { rel: 'canonical', href: `https://mrinfra.fr/services/${slug.value}` }
  ],
  script: [
    {
      type: 'application/ld+json',
      innerHTML: computed(() => JSON.stringify({
        "@context": "https://schema.org",
        "@type": "Service",
        "name": service.value?.title,
        "description": service.value?.description,
        "provider": {
          "@type": "LocalBusiness",
          "name": "MR INFRA",
          "address": {
            "@type": "PostalAddress",
            "addressLocality": "Montreuil",
            "postalCode": "93100",
            "addressCountry": "FR"
          }
        }
      }))
    }
  ]
})
</script>

<template>
<div class="bg-white dark:bg-gray-950 text-gray-900 dark:text-white">

  <!-- 🔥 HERO PREMIUM -->
<section class="relative min-h-[500px] flex items-center justify-center overflow-hidden py-20">
    <!-- IMAGE -->
   <NuxtImg
  v-if="service?.background_image"
  :src="getImage(service.background_image)"
  class="absolute inset-0 w-full h-full object-cover scale-110"
/>

    <!-- OVERLAY -->
    <div class="absolute inset-0 bg-black/60 backdrop-blur-sm"></div>

    <!-- CONTENT -->
    <div class="relative z-10 text-center px-6 max-w-3xl">

     <h1
  class="text-4xl md:text-6xl font-extrabold leading-tight text-white drop-shadow-[0_5px_20px_rgba(0,0,0,0.7)] transition-all duration-1000"
  :class="visible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'"
>

  {{ service?.title }}
</h1>
      <p
        class="mt-6 text-lg md:text-xl text-white/80 transition-all duration-1000 delay-200"
        :class="visible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'"
      >
        {{ service?.description }}
      </p>

      <div
        class="mt-8 transition-all duration-1000 delay-300"
        :class="visible ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-10'"
      >
        <NuxtLink
          to="/#ContactSection"
          class="px-8 py-3 bg-yellow-500 text-black font-semibold rounded-full hover:bg-yellow-400 transition"
        >
          Demander un devis
        </NuxtLink>
      </div>

    </div>

  </section>

  <!-- 🔥 CONTENU PREMIUM -->
  <section class="max-w-6xl mx-auto px-6 py-20">

    <!-- GRID -->
    <div class="grid md:grid-cols-2 gap-16 items-center">

      <!-- IMAGE -->
      <div
        class="overflow-hidden rounded-2xl shadow-2xl transition-all duration-700 hover:scale-105"
      >
        <NuxtImg
          :src="getImage(service?.background_image)"
          class="w-full h-full object-cover"
        />
      </div>

      <!-- TEXTE -->
      <div>
        <h2 class="text-3xl md:text-4xl font-bold mb-6">
          À propos du service
        </h2>

        <div
          class="prose dark:prose-invert max-w-none text-lg leading-relaxed"
          v-html="service?.long_description || service?.description"
        ></div>
      </div>

    </div>

  </section>

  <!-- 🔥 SECTION AVANTAGES -->
  <section class="bg-gray-100 dark:bg-gray-900 py-20">
    <div class="max-w-6xl mx-auto px-6">

      <h2 class="text-3xl font-bold text-center mb-12">
        Pourquoi nous choisir ?
      </h2>

      <div class="grid md:grid-cols-3 gap-8">

        <div class="p-6 bg-white dark:bg-gray-800 rounded-xl shadow hover:shadow-xl transition">
          <h3 class="font-semibold text-xl mb-2">Qualité</h3>
          <p class="text-gray-600 dark:text-gray-300">
            Matériaux haut de gamme et finitions impeccables.
          </p>
        </div>

        <div class="p-6 bg-white dark:bg-gray-800 rounded-xl shadow hover:shadow-xl transition">
          <h3 class="font-semibold text-xl mb-2">Expertise</h3>
          <p class="text-gray-600 dark:text-gray-300">
            Équipe qualifiée avec plusieurs années d’expérience.
          </p>
        </div>

        <div class="p-6 bg-white dark:bg-gray-800 rounded-xl shadow hover:shadow-xl transition">
          <h3 class="font-semibold text-xl mb-2">Délais respectés</h3>
          <p class="text-gray-600 dark:text-gray-300">
            Livraison rapide et respect des engagements.
          </p>
        </div>

      </div>

    </div>
  </section>

  <!-- 🔥 CTA FINAL -->
  <section class="py-20 text-center">
    <h2 class="text-3xl md:text-4xl font-bold mb-6">
      Un projet en tête ?
    </h2>

    <p class="text-gray-600 dark:text-gray-300 mb-8">
      Contactez-nous dès maintenant pour un devis personnalisé.
    </p>

    <NuxtLink
      to="/#ContactSection"
      class="px-10 py-4 bg-yellow-500 text-black font-bold rounded-full hover:bg-yellow-400 transition text-lg"
    >
      Demander un devis
    </NuxtLink>
  </section>

</div>
</template>