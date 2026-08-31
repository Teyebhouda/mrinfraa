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
    open.value = true
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
  <section
    ref="sectionRef"
    id="ContactSection"
    class="py-16 sm:py-24 bg-gray-50 dark:bg-gray-950 relative overflow-hidden"
  >
    <div
      class="max-w-7xl mx-auto px-6 flex flex-col lg:flex-row gap-12"
    >
      <!-- LEFT -->
      <div
        ref="leftCol"
        class="flex-1 space-y-6 left-section"
        :class="{
          'show-left':
            leftVisible
        }"
      >
        <div
          class="flex items-center gap-6 mb-4"
        >
          <span
            class="line-anim"
            :class="{
              'animate-line':
                lineVisible
            }"
          ></span>

          <h3
            class="text-2xl sm:text-3xl md:text-4xl font-extrabold tracking-tight text-gray-900 dark:text-white leading-tight"
          >
            <span
              class="text-yellow-500"
            >
              MR INFRA,
            </span>

            L’expertise au
            service de vos
            projets
          </h3>
        </div>

        <p
          class="text-gray-600 dark:text-gray-300 max-w-md"
        >
          MR INFRA vous
          accompagne dans
          vos projets de
          construction et de
          rénovation avec
          exigence et
          savoir-faire.

          <br
            class="hidden sm:block"
          />

          <span
            class="font-semibold text-gray-800 dark:text-white"
          >
            Bénéficiez d’une
            étude sur mesure
            et d’un devis
            gratuit, sans
            engagement.
          </span>
        </p>

       <button
  @click="openContactModal"
  class="px-6 py-3 bg-yellow-500 hover:bg-yellow-600 text-white font-semibold shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-0.5 rounded-xl"
>
  Parlons de votre projet
</button>

        <!-- CONTACT INFO -->
        <div
          class="pt-4 space-y-2 text-gray-700 dark:text-gray-300 border-t border-gray-200 dark:border-gray-800"
        >
          <p>
            <strong>
              Adresse :
            </strong>
            {{
              props.settings
                ?.adress
            }}
          </p>

          <p>
            <strong>
              Téléphone :
            </strong>

            <a
              :href="`tel:${props.settings?.phone}`"
              class="underline hover:text-yellow-500"
            >
              {{
                props.settings
                  ?.phone
              }}
            </a>
          </p>

          <p>
            <strong>
              Email :
            </strong>

            <a
              :href="`mailto:${props.settings?.email}`"
              class="underline hover:text-yellow-500"
            >
              {{
                props.settings
                  ?.email
              }}
            </a>
          </p>
        </div>
      </div>

      <!-- RIGHT -->
      <div
        ref="rightCol"
        class="flex-1 flex flex-col gap-6 right-section"
        :class="{
          'show-right':
            rightVisible
        }"
      >
        <!-- TESTIMONIAL -->
        <div
          class="testimonial-card relative p-6 rounded-2xl bg-white/80 dark:bg-gray-800/80 backdrop-blur-xl border border-gray-200/50 dark:border-gray-700/50 shadow-sm hover:shadow-2xl transition-all duration-500"
          :class="{
            'show-card':
              cardsVisible
          }"
        >
          <transition
            name="fade-slide"
            mode="out-in"
          >
            <div
              :key="
                currentTestimonial
              "
            >
              <p
                class="text-gray-700 dark:text-gray-200 mb-4 leading-relaxed italic"
              >
                “{{
                  testimonials[
                    currentTestimonial
                  ]
                    ?.message
                }}”
              </p>

              <div
                class="flex items-center gap-3"
              >
                <div>
                  <p
                    class="font-semibold text-gray-900 dark:text-white"
                  >
                    {{
                      testimonials[
                        currentTestimonial
                      ]
                        ?.name
                    }}
                  </p>

                  <p
                    class="text-sm text-gray-500 dark:text-gray-400"
                  >
                    {{
                      testimonials[
                        currentTestimonial
                      ]
                        ?.role
                    }}
                  </p>
                </div>
              </div>
            </div>
          </transition>

          <!-- PROGRESS -->
          <div
            class="flex gap-2 mt-4"
          >
            <div
              v-for="(
                t,
                i
              ) in testimonials"
              :key="i"
              class="h-1 flex-1 rounded-full bg-gray-200 dark:bg-gray-700 overflow-hidden"
            >
              <div
                class="h-full bg-yellow-500 transition-all duration-500"
                :class="
                  i ===
                  currentTestimonial
                    ? 'w-full'
                    : 'w-0'
                "
              ></div>
            </div>
          </div>
        </div>

        <!-- MAP -->
        <div
          class="map-card relative rounded-2xl overflow-hidden shadow-lg"
          :class="{
            'show-card':
              cardsVisible
          }"
        >
          <iframe
            :src="
              props.settings
                ?.map_embed
            "
            class="w-full aspect-video border-0"
          ></iframe>

          <div
            class="absolute bottom-4 left-4 bg-white dark:bg-gray-800 px-4 py-2 rounded-xl shadow-md"
          >
            <p
              class="font-semibold text-gray-900 dark:text-white"
            >
              {{
                props.settings
                  ?.company_name
              }}
            </p>

            <p
              class="text-sm text-gray-500 dark:text-gray-300"
            >
              {{
                props.settings
                  ?.adress
              }}
            </p>
          </div>
        </div>
      </div>
    </div>

    <!-- MODAL -->
    <div
      v-if="open"
      class="fixed inset-0 z-50 flex items-center justify-center px-4"
    >
      <div
        class="absolute inset-0 bg-black/40"
        @click="
          open = false
        "
      ></div>

      <div
        class="modal-card relative bg-white/90 dark:bg-gray-900/90 backdrop-blur-xl w-full max-w-md p-6 sm:p-8 rounded-2xl shadow-2xl border border-gray-200/50 dark:border-gray-700/50"
      >
        <h3
          class="text-xl font-semibold mb-4 text-gray-900 dark:text-white"
        >
          Contactez-nous
        </h3>

        <div
          class="space-y-4"
        >
          <input
            v-model="
              form.nom
            "
            placeholder="Nom"
            class="input"
          />

          <input
            v-model="
              form.company
            "
            placeholder="Entreprise (facultatif)"
            class="input"
          />

          <input
            v-model="
              form.email
            "
            type="email"
            placeholder="Email"
            class="input"
          />

          <input
            v-model="
              form.telephone
            "
            type="tel"
            placeholder="Téléphone"
            class="input"
          />

          <input
            v-model="
              form.website
            "
            type="text"
            class="hidden"
          />

          <select
            v-model="
              form.service
            "
            class="input"
          >
            <option value="">
              Sélectionnez un
              service
            </option>

            <option
              v-for="service in services"
              :key="
                service.id
              "
              :value="
                service.value
              "
            >
              {{
                service.label
              }}
            </option>
          </select>

          <textarea
            v-model="
              form.message
            "
            placeholder="Message"
            class="input h-28 resize-none"
          ></textarea>

          <p
            v-if="errorText"
            class="text-red-500 text-sm"
          >
            {{
              errorText
            }}
          </p>

        <button
  @click="
    !loading &&
    handleSubmit()
  "
  :disabled="loading"
  class="w-full py-3 bg-yellow-500 hover:bg-yellow-600 text-white rounded-2xl font-semibold transition duration-300"
  :class="{
    'opacity-50 cursor-not-allowed':
      loading
  }"
>
            {{
              loading
                ? 'Envoi...'
                : 'Envoyer'
            }}
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all .5s ease;
}

.fade-slide-enter-from {
  opacity: 0;
  transform:
    translateY(10px);
}

.fade-slide-leave-to {
  opacity: 0;
  transform:
    translateY(-10px);
}

/* INPUTS */
.input {
  width: 100%;
  padding: 12px;
  border-radius: 12px;
  background:
    rgba(255,255,255,.8);
  border:
    1px solid
    rgba(0,0,0,.08);
  transition: .3s;
}

.input:focus {
  outline: none;
  border-color: #facc15;
  box-shadow:
    0 0 0 3px
    rgba(250,204,21,.3);
}

/* LINE */
.line-anim {
  width: 60px;
  height: 3px;
  background:
    linear-gradient(
      to right,
      var(--color-primary-500),
      var(--color-primary-300)
    );

  transform: scaleX(0);
  transform-origin: left;
}

.animate-line {
  animation:
    growLine .8s ease
    forwards;
}

@keyframes growLine {
  to {
    transform:
      scaleX(1);
  }
}

/* LEFT / RIGHT */
.left-section {
  opacity: 0;
  transform:
    translateX(-60px);
  filter: blur(10px);
  transition: 1s
    cubic-bezier(
      .22,1,.36,1
    );
}

.show-left {
  opacity: 1;
  transform:
    translateX(0);
  filter: blur(0);
}

.right-section {
  opacity: 0;
  transform:
    translateX(60px);
  filter: blur(10px);
  transition: 1s
    cubic-bezier(
      .22,1,.36,1
    );
}

.show-right {
  opacity: 1;
  transform:
    translateX(0);
  filter: blur(0);
}

/* CARDS */
.testimonial-card,
.map-card {
  opacity: 0;
  transform:
    translateY(40px)
    scale(.96);
  filter: blur(8px);
}

.show-card {
  animation:
    premiumReveal
    .9s
    cubic-bezier(
      .22,1,.36,1
    )
    forwards;
}

.map-card {
  animation-delay:
    .15s;
}

@keyframes premiumReveal {
  0% {
    opacity: 0;
    transform:
      translateY(40px)
      scale(.96);
    filter: blur(8px);
  }

  60% {
    opacity: 1;
    transform:
      translateY(-4px)
      scale(1.01);
  }

  100% {
    opacity: 1;
    transform:
      translateY(0)
      scale(1);
    filter: blur(0);
  }
}

/* MODAL */
.modal-card {
  animation:
    modalReveal .35s
    cubic-bezier(
      .22,1,.36,1
    );
}

@keyframes modalReveal {
  from {
    opacity: 0;
    transform:
      scale(.92)
      translateY(12px);
  }

  to {
    opacity: 1;
    transform:
      scale(1)
      translateY(0);
  }
}
</style>

