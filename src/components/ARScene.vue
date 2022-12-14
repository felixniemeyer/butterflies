<script setup lang="ts">
import { onBeforeMount, onBeforeUnmount, ref } from 'vue'
import AFRAME from 'aframe'

import { bfMaterial } from '@/gfx'

const THREE = AFRAME.THREE


/* butterfly geo
The geometry is kept very simple: 
- each wing is a quad
- the body is a triangle
- stuff is rendered without culling
- wings meet on the up position but don't go down all the way at the bottom position
*/

let textureId = 0
let bfTextureFiles = ref([] as string[]) 
function repeatedlyCheckForNewTextures() {
  let textureFile = 'textures/bf/' + ("00000" + textureId).slice(-5) + '.png'
  let r = new XMLHttpRequest()
  let handled = false
  r.onload = () => {
    if(r.status == 200) {
      console.log('loading', textureFile) 
      bfTextureFiles.value.push(textureFile) 
      textureId += 1
      setTimeout(repeatedlyCheckForNewTextures)
    } else {
      setTimeout(repeatedlyCheckForNewTextures, 10000) // check every second
      console.log('the above 404 error is normal, we\'re just scanning for new available textures') 
    }
  }
  r.open('head', textureFile, true);
  r.send();
}

repeatedlyCheckForNewTextures()


</script>

<template>
  <div>
    <a-scene vr-mode-ui="enabled: false">
      <a-entity v-for='bftf, i in bfTextureFiles' position="0 1.6 -4">
        <a-entity 
          :butterfly="{ textureFile: bftf }"
          :key=i 
          >
        </a-entity>
      </a-entity>
    </a-scene>
  </div>
</template>
