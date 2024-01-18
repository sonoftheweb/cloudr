<script lang="ts" setup>
import { useAlert } from '~/stores/alert'
import type { Alert } from '~/types/alert'

const alerts = useAlert()
const currentAlert = ref<Alert | null>(null)
const intervalId = ref<number | undefined>(undefined)

onMounted(() => {
  intervalId.value = setInterval(() => {
    if (alerts.alerts.length > 0) {
      currentAlert.value = alerts.alerts[0]
      alerts.removeAlert(alerts.alerts[0])
    }
  }, 2000) as unknown as number
})

onUnmounted(() => {
  if (intervalId) clearInterval(intervalId.value)
})
</script>

<template>
  <v-alert
    v-if="currentAlert"
    :title="currentAlert.title"
    :text="currentAlert.message"
    class="mr-3 mt-3 text-caption"
    position="fixed"
    location="top right"
    max-width="50%"
    min-width="300px"
    variant="tonal"
  ></v-alert>
</template>
