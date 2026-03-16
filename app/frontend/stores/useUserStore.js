import { defineStore } from 'pinia';
import { ref } from 'vue';
import AuthAPI from 'api/auth';

const useUserStore = defineStore('user', () => {
  const user = ref(null);
  const uiFlags = ref({
   isFetching: false
  })

  const fetchUser = async (username, password) => {
    uiFlags.value.isFetching = true;
    try {
      const response = await AuthAPI.login(username, password);
      user.value = response.data;
    } catch(err) {
      throw new Error(err.response.data.error);
    } finally {
      uiFlags.value.isFetching = false;
    }
  }
  
  return { user, uiFlags, fetchUser };
})

export default useUserStore;
