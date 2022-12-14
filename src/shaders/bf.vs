// uniform float phase; 
uniform float phase; 
attribute vec2 anim;

out vec2 texUv; 

void main() {
  vec3 p = position; 
  float zPush = anim[1]; 
  if(zPush != 0.) {
    float wingpos = 1. - abs(mod(phase + position.x * 0.1, 1.) * 2. - 1.);
    float dy = anim[0];
    float r = position.y - dy; 
    p.y = dy; 
    vec3 d = vec3(
      0, 
      -(wingpos * 2. - 1.) * r, 
      sqrt(wingpos) * zPush * r
    ); 
    p += normalize(d) * r; 
  }
  p.y -= cos(mod(phase + 0.85, 1.) * 2. * 3.14) * 0.3;

  texUv = position.xy; 

  gl_Position = projectionMatrix * modelViewMatrix * vec4( p, 1.0 );
}
