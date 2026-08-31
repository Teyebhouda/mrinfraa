import type { Settings } from '~/types/settings'

export const useSettings = () => {
  const { apiFetch } = useApi()

  return useAsyncData<{ data: Settings }>('settings', () =>
    apiFetch('/front/settings')
  )
}
