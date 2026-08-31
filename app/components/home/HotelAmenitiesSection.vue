<script setup lang="ts">
const amenities = [
  {
    icon: 'i-heroicons-building-office-2',
    title: '24/7 Front Desk',
    description:
      'Our professional reception team is available around the clock to assist you with check-in, concierge services, and personalized requests.'
  },
  {
    icon: 'i-heroicons-wifi',
    title: 'High-Speed Wi-Fi',
    description:
      'Complimentary high-speed internet access throughout the hotel to keep you connected at all times.'
  },
  {
    icon: 'i-heroicons-truck',
    title: 'Airport Transfer',
    description:
      'Private airport transportation available upon request for a smooth and stress-free arrival and departure.'
  },
  {
    icon: 'i-heroicons-sparkles',
    title: 'Daily Housekeeping',
    description:
      'Meticulous daily housekeeping services ensuring comfort, cleanliness, and attention to every detail.'
  },
  {
    icon: 'i-heroicons-user-group',
    title: 'Concierge Service',
    description:
      'Our concierge team is delighted to assist with restaurant reservations, city tours, and exclusive experiences.'
  },
  {
    icon: 'i-heroicons-shield-check',
    title: 'Secure & Private Stay',
    description:
      'Modern security systems, controlled access, and privacy-focused services for your peace of mind.'
  }
]
</script>

<template>
  <section class="relative py-20 bg-[#FAFAF8] dark:bg-gray-950 text-[#1C1C1C]" id="amenities">
 <div class="absolute inset-x-0 top-0 h-px bg-gradient-to-r from-transparent via-[#C9A24D]/40 to-transparent" />

    <!-- HEADER -->
    <div class="max-w-5xl mx-auto text-center mb-24 px-6">
      <p class="uppercase tracking-[0.35em] text-sm text-primary mb-4">
        Hotel Amenities
      </p>

      <h2 class="text-4xl md:text-5xl font-light tracking-wide">
        Exceptional Services for a Refined Stay
      </h2>

      <p class="mt-6 text-gray-600 text-lg">
        Every detail is designed to elevate your experience,
        from arrival to departure.
      </p>
    </div>

    <!-- GRID -->
    <div class="max-w-6xl mx-auto grid sm:grid-cols-2 lg:grid-cols-3 gap-14 px-6">
      <div
        v-for="(item, index) in amenities"
        :key="index"
        class="group flex flex-col items-center text-center
               p-12 rounded-[36px] bg-white
               shadow-[0_30px_90px_-30px_rgba(0,0,0,0.25)]
               transition-all duration-500
               hover:-translate-y-2 hover:shadow-[0_50px_120px_-30px_rgba(0,0,0,0.35)]"
      >
        <UIcon
          :name="item.icon"
          class="w-10 h-10 text-primary mb-6 transition-transform duration-500 group-hover:scale-110"
        />

        <h3 class="text-xl font-medium mb-4">
          {{ item.title }}
        </h3>

        <p class="text-gray-600 leading-relaxed text-sm max-w-xs">
          {{ item.description }}
        </p>
      </div>
    </div>
  </section>
</template>
