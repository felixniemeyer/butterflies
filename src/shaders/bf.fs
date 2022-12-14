uniform sampler2D tex; 
in vec2 texUv; 
void main() {
  pc_fragColor = texture(tex, texUv); //vec4(0.,0.5,0.,1.); 
}
