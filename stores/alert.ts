import type { Alert } from '~/types/alert'

export const useAlert = defineStore('alert', () => {
  const alerts = reactive<Alert[]>([])

  function addAlert(alert: Alert) {
    alerts.push(alert)
  }

  function removeAlert(alert: Alert) {
    const index = alerts.indexOf(alert)
    alerts.splice(index, 1)
  }

  return {
    alerts,
    addAlert,
    removeAlert,
  }
})
