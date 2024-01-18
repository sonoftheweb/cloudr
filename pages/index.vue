<script lang="ts" setup>
import { useField, useForm } from 'vee-validate'

definePageMeta({
  layout: 'default',
})

const { handleSubmit, handleReset } = useForm({
  validationSchema: {
    email(value: string) {
      if (/^[a-z.-]+@[a-z.-]+\.[a-z]+$/i.test(value)) return true
      return 'Must be a valid e-mail.'
    },
    password(value: string) {
      if (value?.length >= 6) return true
      return 'Name needs to be at least 8 characters.'
    },
  },
})
const email = useField('email')
const password = useField('password')

const submit = handleSubmit(values => {
  alert(JSON.stringify(values, null, 2))
})
</script>

<template>
  <div class="w-100 h-screen d-flex">
    <div class="bg-primary h-screen w-50"></div>
    <div class="h-screen w-50 d-flex align-center">
      <div class="w-50 mx-auto">
        <h2 class="mb-2">Log in</h2>
        <p class="mb-2">Fill in the form below to login to your account</p>
        <form @submit.prevent="submit">
          <v-text-field
            class="mb-1"
            variant="outlined"
            density="compact"
            v-model="email.value.value"
            :error-messages="email.errorMessage.value"
            label="E-mail"
          />
          <v-text-field
            type="password"
            class="mb-2"
            variant="outlined"
            density="compact"
            v-model="password.value.value"
            :error-messages="password.errorMessage.value"
            label="Password"
          />
          <div>
            <v-btn class="me-4 text-caption" type="submit" :flat="true">
              Submit and Login
            </v-btn>
            <v-btn
              @click="navigateTo('/register')"
              class="me-4 text-caption"
              color="secondary"
              type="button"
              :flat="true"
            >
              Register new account
            </v-btn>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
