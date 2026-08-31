<script setup lang="ts">
import { ref, computed, watch } from 'vue'

/* ───────────────── Types ───────────────── */
interface Service {
  id: number
  title: string
  slug: string
  description?: string
  background_image?: string
}

interface ReservationResponse {
  service?: Service
  services: Service[]
}

/* ───────────────── Utils ───────────────── */
const config = useRuntimeConfig()

const getServiceImage = (path?: string) => {
  if (!path) return undefined
  return path.startsWith('http')
    ? path
    : `${config.public.backendBase}${path}`
}

/* ───────────────── Data ───────────────── */
const route = useRoute()
const { apiFetch } = useApi()

const { data } = await useAsyncData<ReservationResponse>(
  'reservation-prepare',
  () =>
    apiFetch('/reservation', {
      query: { service: route.query.service }
    })
)

const service = computed(() => data.value?.service)
const services = computed(() => data.value?.services ?? [])

/* ───────────────── Dates helpers ───────────────── */
const today = computed(() =>
  new Date().toISOString().split('T')?.[0]
)

/* ───────────────── Form ───────────────── */
const form = ref({
  service: undefined as Service | undefined,
  check_in: '',
  check_out: '',
  name: '',
  email: '',
  phone: '',
  note: ''
})

watch(service, (s) => {
  if (s) form.value.service = s
})

/* ───────────────── State ───────────────── */
const loading = ref(false)
const success = ref(false)
const availabilityError = ref<string | null>(null)

/* ───────────────── Availability check ───────────────── */
const checkAvailability = async () => {
  availabilityError.value = null

  if (!form.value.service || !form.value.check_in || !form.value.check_out) {
    return true
  }

  try {
    await apiFetch('/reservation/check', {
      query: {
        service_id: form.value.service.id,
        check_in: form.value.check_in,
        check_out: form.value.check_out
      }
    })
    return true
  } catch {
    availabilityError.value = 'Room not available for selected dates.'
    return false
  }
}

/* ───────────────── Submit ───────────────── */
const submit = async () => {
  success.value = false
  loading.value = true

  const available = await checkAvailability()
  if (!available) {
    loading.value = false
    return
  }

  try {
    await apiFetch('/front/reservations', {
      method: 'POST',
      body: {
        service_id: form.value.service!.id,
        check_in: form.value.check_in,
        check_out: form.value.check_out,
        name: form.value.name,
        email: form.value.email,
        phone: form.value.phone,
        note: form.value.note
      }
    })

    success.value = true
  } finally {
    loading.value = false
  }
}
</script>


<template>
<div class="bg-[#FAFAF8] text-[#1C1C1C]">

  <!-- ───────── HERO ───────── -->
  <section class="relative h-[80vh] flex items-center justify-center overflow-hidden">

    <NuxtImg
     v-if="getServiceImage(service?.background_image)"
      :src="getServiceImage(service?.background_image)"
      class="absolute inset-0 w-full h-full object-cover"
      format="webp"
    />

    <div class="absolute inset-0 bg-black/55 backdrop-blur-[2px]" />

    <div class="relative z-10 text-center text-white max-w-3xl px-6">
      <p class="uppercase tracking-[0.35em] text-sm text-[#C9A24D] mb-6">
        Reservation
      </p>

      <h1 class="text-5xl md:text-6xl font-light tracking-wide">
        {{ service?.title }}
      </h1>

      <p class="mt-8 text-white/80 text-lg">
        An exclusive experience designed for elegance, comfort and serenity.
      </p>

     <!-- <UButton
        size="xl"
        class="mt-12 rounded-full px-14 py-4
               bg-[#C9A24D] text-black
               hover:bg-white transition"
        @click="
          document
            .getElementById('booking-form')
            ?.scrollIntoView({ behavior: 'smooth' })
        "
      >
        Book your stay
      </UButton>  -->
    </div>
  </section>

  <!-- ───────── FORM ───────── -->
  <section id="booking-form" class="-mt-40 relative z-20 px-6 pb-32">
    <div class="max-w-5xl mx-auto">

      <UCard
        class="relative rounded-[40px]
               bg-white/95 backdrop-blur-xl
               shadow-[0_60px_160px_-30px_rgba(0,0,0,0.25)]
               p-16"
      >

        <!-- Floating title
        <div class="absolute -top-7 left-1/2 -translate-x-1/2">
          <span
            class="px-10 py-3 rounded-full
                   bg-[#C9A24D] text-black
                   text-sm font-medium tracking-wide shadow-lg"
          >
            Book your stay
          </span>
        </div>   -->

        <form @submit.prevent="submit" class="mt-10">

          <!-- GRID GLOBAL -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-10">
  <p v-if="availabilityError" class="text-red-600 text-sm mt-4 text-center">
  {{ availabilityError }}
</p>

            <!-- Room -->
          <UFormField label="Room type">
  <USelectMenu
    v-model="form.service"
    :items="services"
    option-attribute="title"
    placeholder="Select your room"
    size="xl"
    class="w-full"
  />
</UFormField>



            <!-- Dates -->
          <UFormField label="Check-in">
  <UInput
    v-model="form.check_in"
    type="date"
    :min="today"
    size="xl"
    class="w-full"
  />
</UFormField>

<UFormField label="Check-out">
  <UInput
    v-model="form.check_out"
    type="date"
    :min="form.check_in || today"
    size="xl"
    class="w-full"
  />
</UFormField>


            <!-- Name -->
            <UFormField  label="Full name">
              <UInput v-model="form.name" size="xl" class="w-full" />
            </UFormField >

            <!-- Email -->
            <UFormField  label="Email">
              <UInput
                v-model="form.email"
                type="email"
                size="xl"
                class="w-full"
              />
            </UFormField >

            <!-- Phone -->
            <UFormField  label="Phone" class="md:col-span-2">
              <UInput v-model="form.phone" size="xl" class="w-full" />
            </UFormField >

            <!-- Notes -->
            <UFormField  label="Special requests" class="md:col-span-2">
              <UTextarea
                v-model="form.note"
                :rows="4"
                placeholder="Late check-in, airport transfer, dietary needs..."
                class="w-full"
              />
            </UFormField >

          </div>

          <!-- ACTIONS -->
          <div class="mt-16 flex flex-col items-center gap-6">
            <p v-if="success" class="text-green-600 text-sm">
              Reservation request sent successfully.
            </p>

           <UButton
  type="submit"
  size="xl"
  :loading="loading"
  class="rounded-full px-20 py-6
         bg-black text-white
         hover:bg-[#C9A24D] hover:text-black
         transition-all"
>
  Confirm reservation
</UButton>

          </div>

        </form>
      </UCard>
    </div>
  </section>

</div>
</template>

