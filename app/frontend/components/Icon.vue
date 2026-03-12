<script setup>
import { Icon as Iconify } from '@iconify/vue'

defineProps({
  name: {
    type: String,
    required: true
  }
})
</script>

<template>
  <Iconify :icon="`lucide:${name}`" />
</template>
