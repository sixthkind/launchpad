<template>
  <div v-if="isLoading" class="flex justify-center items-center">
    <ion-spinner name="bubbles" class="text-primary" />
  </div>
</template>

<script setup>
  const props = defineProps(['isLoading']);
</script>