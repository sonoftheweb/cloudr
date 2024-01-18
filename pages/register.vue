<script lang="ts" setup>
import { useField, useForm } from 'vee-validate'
import { useAuthentication } from '~/stores/authentication'

definePageMeta({
  layout: 'default',
})

const { register } = useAuthentication()
const { addAlert } = useAlert()

const { handleSubmit, handleReset } = useForm({
  validationSchema: {
    name(value: string) {
      if (value?.length >= 2) return true
      return 'Name needs to be at least 2 characters.'
    },
    email(value: string) {
      if (/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i.test(value))
        return true
      return 'Must be a valid e-mail.'
    },
    password(value: string) {
      if (value?.length >= 6) return true
      return 'Password needs to be at least 8 characters.'
    },
    confirmPassword(value: string) {
      if (value === password.value.value) return true
      return 'Passwords do not match.'
    },
  },
})
const name = useField('name')
const email = useField('email')
const password = useField('password')
const confirmPassword = useField('confirmPassword')

const submit = handleSubmit(values => {
  register({
    name: values.name,
    email: values.email,
    password: values.password,
    confirmPassword: values.confirmPassword,
  })
    .then(() => {
      navigateTo('/')
    })
    .catch(() => {
      addAlert({
        id: Math.random(),
        message: 'Something went wrong.',
      })
    })
})
</script>

<template>
  <div
    class="w-100 h-screen overflow-x-hidden d-flex align-center justify-center"
  >
    <div class="w-25">
      <h2 class="mb-1">Register</h2>
      <p class="mb-5">Fill in the form below to register a new account.</p>
      <form @submit.prevent="submit">
        <v-text-field
          class="mb-1"
          variant="outlined"
          density="compact"
          v-model="name.value.value"
          :error-messages="name.errorMessage.value"
          label="Full name"
        />
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
          class="mb-1"
          variant="outlined"
          density="compact"
          v-model="password.value.value"
          :error-messages="password.errorMessage.value"
          label="Password"
        />
        <v-text-field
          type="password"
          class="mb-2"
          variant="outlined"
          density="compact"
          v-model="confirmPassword.value.value"
          :error-messages="confirmPassword.errorMessage.value"
          label="Confirm Password"
        />
        <div>
          <v-btn class="me-4 text-caption" type="submit" :flat="true">
            Submit and Register
          </v-btn>
          <v-btn
            @click="navigateTo('/login')"
            class="me-4 text-caption"
            color="secondary"
            :flat="true"
          >
            Have account? Login
          </v-btn>
        </div>
      </form>
    </div>
  </div>
</template>
