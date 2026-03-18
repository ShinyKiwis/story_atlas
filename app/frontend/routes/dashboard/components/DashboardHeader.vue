<script setup>
import AppTitle from 'components/AppTitle.vue';
import { storeToRefs } from 'pinia';
import useUserStore from 'stores/useUserStore';

const userStore = useUserStore();
const { user } = storeToRefs(userStore);

</script>
<template>
  <div class="flex items-center justify-between">
    <AppTitle />
    <div class="flex items-center gap-2 text-white">
      <span class="font-bold text-md">
        {{ user?.username }}
      </span>
    </div>
  </div>
</template>
