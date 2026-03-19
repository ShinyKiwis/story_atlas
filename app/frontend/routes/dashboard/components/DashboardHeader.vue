<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { storeToRefs } from 'pinia';
import AppTitle from 'components/AppTitle.vue';
import Icon from 'components/Icon.vue';
import useUserStore from 'stores/useUserStore';

const userStore = useUserStore();
const { user } = storeToRefs(userStore);
const { logout } = userStore;

const router = useRouter();
const isOpen = ref(false);
const triggerHovered = ref(false);

const handleLogout = async () => {
  await logout();
  router.push({ name: 'login' });
};
</script>

<template>
  <div class="flex items-center justify-between">
    <AppTitle />
    <div
      class="relative cursor-pointer select-none"
      @mouseenter="isOpen = true"
      @mouseleave="isOpen = false"
    >
      <div
        class="flex items-center gap-2 px-3 py-1.5"
        :class="isOpen && 'rounded-t-lg bg-sky-400'"
      >
        <span class="text-sm font-semibold text-white">{{ user?.username }}</span>
        <Icon name="chevron-down" class="w-3.5 h-3.5 text-white" />
      </div>

      <div
        v-if="isOpen"
        class="absolute right-0 w-full rounded-b-lg overflow-hidden"
      >
        <button
          class="flex w-full items-center gap-2 px-3 py-2 text-sm font-medium text-white bg-sky-400 hover:bg-sky-300 cursor-pointer"
          @click="handleLogout"
        >
          <Icon name="log-out" class="w-3.5 h-3.5" />
          Logout
        </button>
      </div>
    </div>
  </div>
</template>
