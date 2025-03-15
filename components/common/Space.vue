<template>
  <div class="space-container">
    <div class="space-loading">
      Loading...
      <CommonLoading :isLoading="true" />
    </div>
    <iframe class="space-iframe" src="https://sixthkind.com" />
  </div>
</template>

<script setup>

</script>

<style scoped>
  .space-container {
    height: 100vh;
    width: 100vw;
    padding: 100px 20px 20px 20px;
    position: relative;
  }

  .space-iframe {
    height: 100%;
    width: 100%;
    border-radius: 20px;
    z-index: 10;
  }

  .space-loading {
    position: absolute;
    top: 20px;
    left: 20px;
    z-index: 1;
  }
</style>