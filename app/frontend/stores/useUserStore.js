import { defineStore } from 'pinia';
import { ref } from 'vue';
import AuthAPI from 'api/auth';
import UserAPI from 'api/user';

const useUserStore = defineStore('user', () => {
  const user = ref(null);
  const uiFlags = ref({
   isAuthenticating: false
  })

  const getCurrentUser = async() => {
    try {
      const response = await UserAPI.me();
      user.value = response.data;
    } catch(err) {
      user.value = null;
    }
  };

  const authenticateUser = async (username, password) => {
    uiFlags.value.isAuthenticating = true;
    try {
      const response = await AuthAPI.login(username, password);
      user.value = response.data;
    } catch(err) {
      throw new Error(err.response.data.error);
    } finally {
      uiFlags.value.isAuthenticating = false;
    }
  }
  
  const logout = async () => {
    await AuthAPI.logout();
    user.value = null;
  };

  return { user, uiFlags, getCurrentUser, authenticateUser, logout };
})

export default useUserStore;
