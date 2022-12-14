
<script setup lang="ts">
import AFRAME from 'aframe'
import bfVs from '@/shaders/bf.vs'
import bfFs from '@/shaders/bf.fs'
import { ref } from 'vue';
const THREE = AFRAME.THREE


/* butterfly geo
The geometry is kept very simple: 
- each wing is a quad
- the body is a triangle
- stuff is rendered without culling
- wings meet on the up position but don't go down all the way at the bottom position
*/
const bfGeometry = new THREE.BufferGeometry()

const wingVertices = [
  0,  1,  0,
  1,  1,  0,
]
const bfVertices = new Float32Array([
  // body
  0,  0,  0,
  1,  0,  0,
  1,  0.2,0,  
  // wings
  ...wingVertices, 
  ...wingVertices,
]) 
bfGeometry.setAttribute( 'position', new THREE.BufferAttribute( bfVertices, 3 ) );

/* anim info 
- [0]: y position around which it rotates
- [1]: z, that determines the side of the rotation. no effect if z == 0
*/
const bfAnim = new Float32Array([
  // body
  0, 0,  
  0, 0,  
  0, 0, 
  // wings
  0, -0.2,
  0.2, -0.3,   
  0, 0.2,
  0.2, 0.3,
]) 
bfGeometry.setAttribute( 'anim', new THREE.BufferAttribute( bfAnim, 2 ) ); 

const bfIndex = new Uint16Array([
  2, 1, 0, 

  0, 2, 4, 
  0, 4, 3,  

  6, 2, 0, 
  5, 6, 0
])
bfGeometry.setIndex(new THREE.BufferAttribute(bfIndex, 1))

const bfMaterial = new THREE.ShaderMaterial( {
  uniforms: {
    phase: { value: 0.9 },
  },
  side: THREE.DoubleSide, 
  vertexShader: bfVs, 
  fragmentShader: bfFs
} );

AFRAME.registerComponent('butterfly', {
  schema: {
  },
  init: function () {
    console.log('creating!')
    //const material = new THREE.MeshBasicMaterial( { color: 0xff0000 } );
    const mesh = new THREE.Mesh(bfGeometry, bfMaterial );
    this.el.setObject3D('mesh', mesh)
  }, 
});


let r = 0
let phase = 0
const rSpeed = 10
const phaseSpeed = 0.3
const fps = 60
let rotation = ref(`0 ${r} 0`) 
setInterval(() => {
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
}, 1/fps) 

</script>

<template>
  <div>
    <a-scene vr-mode-ui="enabled: false">
      <a-entity position="0 1.6 -2" :rotation=rotation>
        <a-entity butterfly position="-0.5 -0.5 0">
        </a-entity>
      </a-entity>
    </a-scene>
  </div>
</template>
