<script setup lang="ts">
import { ref } from 'vue'

const formData = ref({
  name: '',
  email: '',
  telephone: '',
  company: '', // ✅ nouveau champ
  service: '',
  message: ''
})

const submitForm = () => {
  console.log('Demande envoyée', formData.value)
  // ici tu peux appeler ton API ou envoyer par mail
}
</script>

<template>
<section id="ContactSection" class="py-24 bg-gray-50 dark:bg-gray-900">
  <div class="max-w-7xl mx-auto px-6 grid lg:grid-cols-2 gap-12 items-center">

    <!-- LEFT CONTENT -->
    <div>
      <p class="uppercase tracking-[0.35em] text-sm text-primary mb-4">
        DEMANDER UN DEVIS
      </p>
      <h2 class="text-4xl md:text-5xl font-semibold mb-6 text-gray-900 dark:text-white">
        Obtenez votre devis personnalisé
      </h2>
      <p class="text-gray-600 dark:text-gray-400 mb-8">
        Remplissez le formulaire ci-contre et notre équipe vous contactera rapidement pour discuter de votre projet.
      </p>
    </div>

    <!-- RIGHT FORM -->
    <div>
      <UCard class="p-8 rounded-2xl shadow-lg bg-white dark:bg-gray-800">
        <form @submit.prevent="submitForm" class="space-y-4">

          <UInput
            v-model="formData.name"
            label="Nom complet"
            placeholder="Votre nom"
              :ui="{ base: 'bg-white dark:bg-gray-900 text-gray-900 dark:text-white' }"

            required
          />
          <UInput
  v-model="formData.company"
  label="Entreprise (facultatif)"
  placeholder="Nom de votre entreprise"
/>

          <UInput
            v-model="formData.email"
            type="email"
            label="Email"
            placeholder="Votre email"
              :ui="{ base: 'bg-white dark:bg-gray-900 text-gray-900 dark:text-white' }"

            required
          />
<UInput
  v-model="formData.telephone"
  type="tel"
  label="Téléphone"
  placeholder="Votre numéro"
    :ui="{ base: 'bg-white dark:bg-gray-900 text-gray-900 dark:text-white' }"

/>
          <UInput
            v-model="formData.service"
            label="Service"
            placeholder="Service souhaité"
            :ui="{ base: 'bg-white dark:bg-gray-900 text-gray-900 dark:text-white' }"
          />

          <UTextarea
            v-model="formData.message"
            label="Message"
            placeholder="Décrivez votre projet"
              :ui="{ base: 'bg-white dark:bg-gray-900 text-gray-900 dark:text-white' }"
            items="4"
          />

          <UButton
            type="submit"
            color="primary"
            variant="solid"
            class="w-full mt-4"
          >
            Envoyer la demande
          </UButton>

        </form>
      </UCard>
    </div>

  </div>
</section>
</template>