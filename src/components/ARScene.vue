<script setup lang="ts">
import AFRAME from 'aframe'
const THREE = AFRAME.THREE

// const flapping = new Float32Array([0,1,1,]); 

const bfGeometry = new THREE.BufferGeometry()

const wingVertices = [
  0,  1,  0,
  1,  1,  0,
]
const vertices = new Float32Array([
  // body
  0,  0,  0,
  1,  0,  0,
  1,  0.2,0,  
  // wing
  ...wingVertices, 
  ...wingVertices,
]) 
bfGeometry.setAttribute( 'position', new THREE.BufferAttribute( vertices, 3 ) );
function makeSideIndizes(side: number) {
  return [
  ]
}

bfGeometry.index = new THREE.BufferAttribute(new Uint16Array([
  2, 1, 0, 

  0, 2, 4, 
  0, 4, 3,  


  0, 1, 2, 
  6, 2, 0, 
  5, 6, 0
]), 1) 

AFRAME.registerComponent('butterfly', {
  schema: {
  },

  init: function () {
    console.log('creating!')
   // const material = new THREE.ShaderMaterial( {

   //   uniforms: {

   //     time: { value: 1.0 },
   //     resolution: { value: new THREE.Vector2() }

   //   },

   //   vertexShader: "",

   //   fragmentShader: "" // document.getElementById( 'fragmentShader' ).textContent

   // } );
    const material = new THREE.MeshBasicMaterial( { color: 0xff0000 } );
    const mesh = new THREE.Mesh(bfGeometry, material );
    this.el.setObject3D('mesh', mesh)
  }, 
});

</script>

<template>
  <div>
    <a-scene>
      <a-entity position="0 1.6 -2" rotation="0 -30 0">
        <a-entity butterfly position="-0.5 -0.5 0">
        </a-entity>
      </a-entity>
    </a-scene>
  </div>
</template>
