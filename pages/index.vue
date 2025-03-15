<script setup>
definePageMeta({
  layout: "common",
  middleware: "auth"
});
</script>

<template>
  <ion-page>
    <ion-content>
      <CommonMain />
      <CommonHero />
    </ion-content>
  </ion-page>
</template>
