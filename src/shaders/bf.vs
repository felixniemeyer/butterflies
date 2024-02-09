// uniform float phase; 
uniform float phase; 
attribute vec2 anim;

out vec2 texUv; 

void main() {
  vec3 p = position; 
  float zPush = anim[1]; 
  if(zPush != 0.) {
    float vPhase = 0.5 - 0.43 * cos(3.1416 * (phase + position.x * 0.066)) ; 
    
    float dy = anim[0];
    float r = position.y - dy; 
    p.y = dy; 
    vec3 d = vec3(
      0, 
      cos(2. * 3.1416 * vPhase) * r, 
      sqrt(0.5 - 0.5 * cos(2. * 3.1416 * vPhase)) * zPush * r * (1. + 2. * abs(vPhase * 2. - 1.)) * 1.5
      //sin(2. * 2.141 * vPhase) * r *(1. - abs(vPhase * 2. - 1.)) * zPush
    ); 
    p += normalize(d) * r; 
  }
  p.y -= cos(mod(phase + 0.85, 1.) * 2. * 3.14) * 0.2;

  texUv = position.xy; 

  gl_Position = projectionMatrix * modelViewMatrix * vec4( p, 1.0 );
}
