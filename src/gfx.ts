import AFRAME from 'aframe'

import { createNoise2D } from 'simplex-noise' 

import bfVs from './shaders/bf.vs'
import bfFs from './shaders/bf.fs'
import { Vector3 } from 'three'

const noise2D = createNoise2D()

const THREE = AFRAME.THREE

const sY = 0.37
const bfGeometry = new THREE.BufferGeometry()
const wingVertices = [
  0,  1,  0,
  1,  1,  0,
]
const bfVertices = new Float32Array([
  // body
  0,  0,  0,
  1,  0,  0,
  1,  sY,0,  
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
  0, -0.4,
  sY, -0.5,   
  0, 0.4,
  sY, 0.5,
]) 
bfGeometry.setAttribute( 'anim', new THREE.BufferAttribute( bfAnim, 2 ) ); 

const bfIndex = new Uint16Array([
  2, 1, 0, 

  0, 2, 3, 
  3, 2, 4,  

  5, 2, 0, 
  6, 2, 5
])
bfGeometry.setIndex(new THREE.BufferAttribute(bfIndex, 1))

export const bfMaterial = new THREE.ShaderMaterial( {
  uniforms: {
    phase: { value: 0.9 },
    tex: { value: 0 }, 
    seed: { value: 0 },
    xyzNoiseF: { value: new THREE.Vector3(1,1,1) }
  },
  side: THREE.DoubleSide, 
  vertexShader: bfVs, 
  fragmentShader: bfFs, 
  alphaToCoverage: true
} );

AFRAME.registerComponent('butterfly', {
  schema: {
    textureFile: {
      type: 'string', 
      default: '00000.png'
    }
  },
  init() {
    this.data.material = bfMaterial.clone()
    this.data.material.uniforms.xyzNoiseF.value = new THREE.Vector3(
      Math.random() * 0.2 + 0.9,
      Math.random() * 0.2 + 0.9, 
      Math.random() * 0.2 + 0.9, 
    )

    this.data.phaseOffset = Math.random()
    this.data.seed = Math.random() * 100

    console.log('creating element and loading', this.data.textureFile)

    new THREE.TextureLoader().load(this.data.textureFile, (texture) => {
      this.data.material.uniforms.tex.value = texture
      const mesh = new THREE.Mesh(bfGeometry, this.data.material)
      this.el.setObject3D('mesh', mesh)
    }, () => {}, (e) => {
      console.log('failed to load texture', e)
    }) 
  }, 
  tick: function(time: number, timeDelta: number) {
    const st = time * 0.0001

    function f(seed: number) {
      return (
        5/2 * noise2D(seed, st) + 
        5/4 * noise2D(seed, st*2) + 
        5/8 * noise2D(seed, st*4)
      ) 
    }
    this.el.object3D.position.x = f(this.data.seed + 0) - 0.5
    this.el.object3D.position.y = f(this.data.seed + 1000) - 0.5
    this.el.object3D.position.z = f(this.data.seed + 2000)

    const ft = time * 0.0015
    this.data.material.uniforms.phase.value = (ft + this.data.phaseOffset) % 1
    this.el.object3D.rotation.y += noise2D(this.data.seed + 100, ft * 0.1) * 0.001 * timeDelta

    //  ft + this.data.phaseOffset
  }
});

