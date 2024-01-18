import type { RegisterData } from '~/types/register'

export const useAuthentication = defineStore('authentication', () => {
  async function register(registerData: RegisterData) {
    const data = await useFetch('/api/register', {
      method: 'POST',
      body: { ...registerData },
    })

    console.log(data.data.value)
  }

  return {
    register,
  }
})
