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

let r = 0
let phase = 0
const rSpeed = 10
const phaseSpeed = 0.5
const fps = 60
let rotation = ref(`0 ${r} 0`) 
let showDefaultBf = ref(false) 
function updateDefaultBf() {
  r += rSpeed / fps 
  while(r > 360) {
    r -= 360
  }
  rotation.value = `0 ${r} 0`
  
  phase += phaseSpeed / fps
  while(phase > 1) {
    phase -= 1
  }
  bfMaterial.uniforms.phase.value = phase
}

new THREE.TextureLoader().load('textures/bf/default.png', (texture) => {
  bfMaterial.uniforms.tex.value = texture
  showDefaultBf.value = true
  setInterval(updateDefaultBf, 1/fps) 
}) 

</script>

<template>
  <div>
    <a-scene stats vr-mode-ui="enabled: false">
      <a-entity position="0 1.6 -2" :rotation=rotation>
        <a-entity butterfly position="-0.5 -0.5 0">
        </a-entity>
      </a-entity>
    </a-scene>
  </div>
</template>
