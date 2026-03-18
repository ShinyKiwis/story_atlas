<script setup>
import { onBeforeMount } from 'vue';
import useUserStore from 'stores/useUserStore';

const userStore = useUserStore();
const { getCurrentUser } = userStore;
onBeforeMount(() => {
  getCurrentUser();
});
</script>

<template>
  <main class="h-screen bg-grid bg-base">
    <RouterView />
  </main>
</template>
