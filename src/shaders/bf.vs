// uniform float phase; 
uniform float phase; 
attribute vec2 anim;
void main() {
  vec3 p = position; 
  float zPush = anim[1]; 
  if(zPush != 0.) {
    float wingpos = (1. - abs(mod(phase + position.x * 0.05, 1.) * 2. - 1.)) * (0.8 + 0.2 * position.x); 
    float dy = anim[0];
    float r = position.y - dy; 
    p.y = dy; 
    vec3 d = vec3(
      0, 
      -(wingpos* r * 2. - 1.), 
      sqrt(wingpos) * zPush * r
    ); 
    p += normalize(d) * r; 
  }
  p.y += pow((1. - cos(mod(phase - 0.05, 1.) * 2. * 3.14)) * 0.5, 2.);

  gl_Position = projectionMatrix * modelViewMatrix * vec4( p, 1.0 );
}
