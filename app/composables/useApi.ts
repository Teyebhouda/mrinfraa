export const useApi = () => {
  const config = useRuntimeConfig()

  const apiFetch = $fetch.create({
    baseURL: config.public.apiBase,
    headers: {
      Accept: 'application/json'
    }
  })

  return {
    apiFetch
  }
}
