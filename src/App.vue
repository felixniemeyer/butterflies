<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class=nav>
    <RouterLink to='/'>info</RouterLink>
    <RouterLink to='/scene'>scene</RouterLink>
  </div>
  <div class=container>
    <RouterView />
  </div>
</template>

<style lang=less scoped>
.nav {
  z-index: 100; 
  position: absolute;
  top: 0; 
  display: block;
  margin: 1rem;
  a {
    margin: 0.5rem; 
    color: #aaf;
    &:visited {
      color: #e9e; 
    }
  }
}
</style>
