<script setup lang="ts">
import {
  ref,
  reactive,
  computed,
  onMounted,
  onUnmounted,
  nextTick
} from 'vue'

const toast = useToast()

const props = defineProps<{
  testimonials?: any
  settings?: any
  services?: any
}>()

// ==========================
// TESTIMONIALS
// ==========================

const testimonials = computed(
  () =>
    props.testimonials
      ?.content?.items || []
)

const currentTestimonial =
  ref(0)

let testimonialInterval:
  any = null

const nextTestimonial =
  () => {
    if (
      !testimonials.value.length
    )
      return

    currentTestimonial.value =
      (
        currentTestimonial.value +
        1
      ) %
      testimonials.value.length
  }

const services = computed(
  () => {
    if (!props.services)
      return []

    return props.services.map(
      (s: any) => ({
        label: s.title,
        value: s.slug,
        id: s.id
      })
    )
  }
)
// ==========================
// CONTACT FORM
// ==========================

const open = ref(false)
const isOpen = ref(false)
const loading = ref(false)
const errorText = ref('')

// 🔥 timer anti-bot
const formStartedAt = ref(
  Date.now()
)

const openContactModal =
  () => {
    // reset timer à chaque ouverture
    formStartedAt.value =
      Date.now()

    errorText.value = ''
    isOpen.value = true
  }

const form = reactive({
  nom: '',
  email: '',
  service: '',
  message: '',
  company: '',
  telephone: '',
  website: ''
})

const resetForm = () => {
  form.nom = ''
  form.email = ''
  form.service = ''
  form.message = ''
  form.telephone = ''
  form.company = ''
  form.website = ''
}

const handleSubmit =
  async () => {
    // anti double click
    if (loading.value)
      return

    // honeypot
    if (form.website)
      return

    // validation frontend
    if (
      !form.nom ||
      !form.email ||
      !form.message ||
      !form.service
    ) {
      errorText.value =
        'Veuillez remplir tous les champs requis'
      return
    }

    const emailRegex =
      /^[^\s@]+@[^\s@]+\.[^\s@]+$/

    if (
      !emailRegex.test(
        form.email
      )
    ) {
      errorText.value =
        'Email invalide'
      return
    }

    loading.value = true
    errorText.value = ''

    try {
      const res =
        await $fetch<{
          success: boolean
          error?: string
        }>(
          'https://admin.mrinfra.fr/api/contact',
          {
            method: 'POST',

            body: {
              nom: form.nom,
              email:
                form.email,

              telephone:
                form.telephone,

              service:
                form.service,

              company:
                form.company,

              message:
                form.message,

              // honeypot
              website:
                form.website,

              // anti-bot Laravel
              form_time:
                Date.now() -
                formStartedAt.value
            }
          }
        )

      if (res.success) {
        open.value = false

        resetForm()

        toast.add({
          title:
            'Message envoyé',
          description:
            'Nous vous recontacterons rapidement.',
          icon:
            'i-lucide-check-circle',
          duration: 4000
        })
      } else {
        errorText.value =
          res.error ||
          "Erreur lors de l'envoi"
      }
    } catch {
      errorText.value =
        'Erreur serveur, réessayez plus tard'
    } finally {
      loading.value = false
    }
  }

// ==========================
// SECTION ANIMATION
// ==========================

const sectionRef =
  ref<HTMLElement | null>(
    null
  )

const leftCol =
  ref<HTMLElement | null>(
    null
  )

const rightCol =
  ref<HTMLElement | null>(
    null
  )

const leftVisible =
  ref(false)

const rightVisible =
  ref(false)

const cardsVisible =
  ref(false)

const lineVisible =
  ref(false)

let observer:
  | IntersectionObserver
  | null = null

onMounted(() => {
  testimonialInterval =
    setInterval(
      nextTestimonial,
      4000
    )

  nextTick(() => {
    observer =
      new IntersectionObserver(
        (entries) => {
          entries.forEach(
            (
              entry
            ) => {
              if (
                entry.isIntersecting
              ) {
                // LEFT
                if (
                  entry.target ===
                  leftCol.value
                ) {
                  leftVisible.value =
                    false

                  lineVisible.value =
                    false

                  setTimeout(
                    () => {
                      leftVisible.value =
                        true

                      lineVisible.value =
                        true
                    },
                    100
                  )
                }

                // RIGHT
                if (
                  entry.target ===
                  rightCol.value
                ) {
                  rightVisible.value =
                    false

                  cardsVisible.value =
                    false

                  setTimeout(
                    () => {
                      rightVisible.value =
                        true

                      cardsVisible.value =
                        true
                    },
                    200
                  )
                }
              } else {
                // replay animation
                if (
                  entry.target ===
                  leftCol.value
                ) {
                  leftVisible.value =
                    false

                  lineVisible.value =
                    false
                }

                if (
                  entry.target ===
                  rightCol.value
                ) {
                  rightVisible.value =
                    false

                  cardsVisible.value =
                    false
                }
              }
            }
          )
        },
        {
          threshold: 0.25
        }
      )

    if (leftCol.value)
      observer.observe(
        leftCol.value
      )

    if (rightCol.value)
      observer.observe(
        rightCol.value
      )
  })
})

onUnmounted(() => {
  if (
    testimonialInterval
  ) {
    clearInterval(
      testimonialInterval
    )
  }

  if (observer)
    observer.disconnect()
})
</script>

<template>
  <UPageSection
    id="ContactSection"
    orientation="horizontal"
    :ui="{
      root: 'relative overflow-hidden bg-gray-50 dark:bg-gray-950 ',
      container: 'max-w-7xl',
      wrapper: 'lg:grid-cols-2 gap-12 items-start',
      header: 'flex flex-col justify-start',
      title: 'text-3xl md:text-4xl lg:text-5xl font-black tracking-tight leading-[1.05]',
      description: 'mt-0',
    }"
  >
    <!-- Décors -->
    <template #top>
      <div class="absolute inset-0 pointer-events-none">
        <div class="absolute -top-60 -left-60 w-[500px] h-[500px] bg-primary/5 blur-[140px] rounded-full"></div>
        <div class="absolute -bottom-40 -right-40 w-[400px] h-[400px] bg-primary/5 blur-[120px] rounded-full"></div>
        <div class="absolute inset-0 opacity-[0.02] dark:opacity-[0.04]"
          style="background-image: radial-gradient(circle, #000 1px, transparent 1px); background-size: 32px 32px;">
        </div>
      </div>
    </template>

    <!-- Badge -->
    <template #headline>
      <div class="flex items-center gap-3">
        <span class="line-anim" :class="{ 'animate-line': lineVisible }"></span>
        <span class="text-xs font-semibold uppercase tracking-[0.2em] text-primary px-3 py-1 bg-primary/10 rounded-full">
          Contactez-nous
        </span>
      </div>
    </template>

    <!-- Titre -->
   <template #title>
  <div ref="leftCol" class="left-section" :class="{ 'show-left': leftVisible }">
    Construisons ensemble
    <span class="text-primary"> votre projet</span>
  </div>
</template>

    <!-- Description + CTA + Infos contact -->
    <template #description>
      <div class="left-section space-y-6 mt-4" :class="{ 'show-left': leftVisible }">

        <!-- Texte -->
        <div class="flex gap-4">
          <div class="w-0.5 bg-gradient-to-b from-primary to-transparent flex-shrink-0 rounded-full"></div>
          <p class="text-gray-500 dark:text-gray-400 text-lg leading-relaxed">
            MR INFRA vous accompagne dans vos projets de construction et de rénovation avec exigence et savoir-faire.
            <br />
            <span class="font-semibold text-gray-700 dark:text-white">
              Bénéficiez d'une étude sur mesure et d'un devis gratuit, sans engagement.
            </span>
          </p>
        </div>

        <!-- ✅ UButton CTA -->
        <UButton
          color="primary"
          size="lg"
          leading-icon="i-lucide-message-circle"
          class="rounded-xl shadow-lg shadow-primary/20 font-semibold"
          @click="openContactModal"
        >
          Parlons de votre projet
        </UButton>

        <!-- ✅ Infos contact -->
        <div class="pt-4 space-y-3 border-t border-gray-200 dark:border-gray-800">
          <div v-if="props.settings?.adress" class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
              <UIcon name="i-lucide-map-pin" class="w-4 h-4 text-primary" />
            </div>
            <span class="text-sm text-gray-600 dark:text-gray-400">{{ props.settings.adress }}</span>
          </div>

          <div v-if="props.settings?.phone" class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
              <UIcon name="i-lucide-phone" class="w-4 h-4 text-primary" />
            </div>
            <UButton
              :to="`tel:${props.settings.phone}`"
              variant="link"
              color="neutral"
              class="text-sm text-gray-600 dark:text-gray-400 hover:text-primary p-0 font-medium"
            >
              {{ props.settings.phone }}
            </UButton>
          </div>

          <div v-if="props.settings?.email" class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-lg bg-primary/10 flex items-center justify-center flex-shrink-0">
              <UIcon name="i-lucide-mail" class="w-4 h-4 text-primary" />
            </div>
            <UButton
              :to="`mailto:${props.settings.email}`"
              variant="link"
              color="neutral"
              class="text-sm text-gray-600 dark:text-gray-400 hover:text-primary p-0 font-medium"
            >
              {{ props.settings.email }}
            </UButton>
          </div>
        </div>

      </div>
    </template>

    <!-- RIGHT — Testimonial + Map -->
    <div
      ref="rightCol"
      class="flex flex-col gap-6 right-section"
      :class="{ 'show-right': rightVisible }"
    >

      <!-- ✅ UCard Testimonial -->
      <UCard
        class="testimonial-card"
        :class="{ 'show-card': cardsVisible }"
        :ui="{
          root: 'rounded-2xl border border-gray-100 dark:border-gray-800 bg-white/80 dark:bg-gray-900/80 backdrop-blur-xl shadow-none hover:shadow-xl transition-all duration-500',
          body: 'p-6',
        }"
      >
        <transition name="fade-slide" mode="out-in">
          <div :key="currentTestimonial">
            <div class="flex gap-1 mb-4">
              <UIcon
                v-for="n in 5" :key="n"
                name="i-lucide-star"
                class="w-4 h-4 text-primary"
              />
            </div>

            <p class="text-gray-600 dark:text-gray-300 leading-relaxed italic mb-4">
              "{{ testimonials[currentTestimonial]?.message }}"
            </p>

            <div class="flex items-center gap-3">
              <UAvatar
                :alt="testimonials[currentTestimonial]?.name"
                size="sm"
                color="primary"
              />
              <div>
                <p class="font-semibold text-sm text-gray-900 dark:text-white">
                  {{ testimonials[currentTestimonial]?.name }}
                </p>
                <p class="text-xs text-gray-500 dark:text-gray-400">
                  {{ testimonials[currentTestimonial]?.role }}
                </p>
              </div>
            </div>
          </div>
        </transition>

        <!-- Progress dots -->
        <div class="flex gap-2 mt-5">
          <div
            v-for="(t, i) in testimonials"
            :key="i"
            class="h-1 flex-1 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden"
          >
            <div
              class="h-full bg-primary transition-all duration-500"
              :class="i === currentTestimonial ? 'w-full' : 'w-0'"
            ></div>
          </div>
        </div>
      </UCard>

      <!-- Map -->
      <div
        class="map-card relative rounded-2xl overflow-hidden shadow-lg border border-gray-100 dark:border-gray-800"
        :class="{ 'show-card': cardsVisible }"
      >
        <iframe
          :src="props.settings?.map_embed"
          class="w-full aspect-video border-0"
        ></iframe>

        <!-- Badge adresse sur la map -->
        <div class="absolute bottom-4 left-4 bg-white dark:bg-gray-800 px-4 py-2 rounded-xl shadow-md border border-gray-100 dark:border-gray-700">
          <p class="font-bold text-sm text-gray-900 dark:text-white">
            {{ props.settings?.company_name }}
          </p>
          <p class="text-xs text-gray-500 dark:text-gray-400">
            {{ props.settings?.adress }}
          </p>
        </div>
      </div>

    </div>

    <!-- ✅ MODAL CONTACT avec UModal -->
    <UModal
      v-model:open="isOpen"
      :title="'Contactez-nous'"
      :description="'Remplissez le formulaire, nous vous répondons rapidement.'"
      :ui="{
        content: 'max-w-md',
        body: 'p-6',
        header: 'px-6 pt-6 pb-0',
      }"
    >
      <template #body>
        <div class="space-y-4">

          <!-- ✅ UInput -->
          <UInput
            v-model="form.nom"
            placeholder="Nom *"
            icon="i-lucide-user"
            size="lg"
            class="w-full"
          />

          <UInput
            v-model="form.company"
            placeholder="Entreprise (facultatif)"
            icon="i-lucide-building-2"
            size="lg"
            class="w-full"
          />

          <UInput
            v-model="form.email"
            type="email"
            placeholder="Email *"
            icon="i-lucide-mail"
            size="lg"
            class="w-full"
          />

          <UInput
            v-model="form.telephone"
            type="tel"
            placeholder="Téléphone"
            icon="i-lucide-phone"
            size="lg"
            class="w-full"
          />

          <!-- Honeypot caché -->
          <input v-model="form.website" type="text" class="hidden" tabindex="-1" autocomplete="off" />

          <!-- ✅ USelect services -->
          <USelect
            v-model="form.service"
            :items="services"
            placeholder="Sélectionnez un service *"
            size="lg"
            class="w-full"
          />

          <!-- ✅ UTextarea -->
          <UTextarea
            v-model="form.message"
            placeholder="Votre message *"
            :rows="4"
            size="lg"
            class="w-full"
          />

          <!-- ✅ UAlert erreur -->
          <UAlert
            v-if="errorText"
            color="error"
            variant="soft"
            :title="errorText"
            icon="i-lucide-alert-circle"
          />

          <!-- ✅ UButton submit -->
          <UButton
            color="primary"
            variant="solid"
            size="lg"
            block
            :loading="loading"
            :disabled="loading"
            trailing-icon="i-lucide-send"
            class="rounded-xl font-semibold"
            @click="handleSubmit"
          >
            {{ loading ? 'Envoi en cours...' : 'Envoyer le message' }}
          </UButton>

        </div>
      </template>
    </UModal>

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

.testimonial-card,
.map-card {
  opacity: 0;
  transform: translateY(40px) scale(0.96);
  filter: blur(8px);
}
.show-card {
  animation: premiumReveal 0.9s cubic-bezier(0.22, 1, 0.36, 1) forwards;
}
.map-card { animation-delay: 0.15s; }

@keyframes premiumReveal {
  0%   { opacity: 0; transform: translateY(40px) scale(0.96); filter: blur(8px); }
  60%  { opacity: 1; transform: translateY(-4px) scale(1.01); }
  100% { opacity: 1; transform: translateY(0) scale(1); filter: blur(0); }
}

.fade-slide-enter-active,
.fade-slide-leave-active { transition: all 0.5s ease; }
.fade-slide-enter-from { opacity: 0; transform: translateY(10px); }
.fade-slide-leave-to { opacity: 0; transform: translateY(-10px); }
</style>

