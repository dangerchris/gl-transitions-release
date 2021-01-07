// author: dangerchris
// License: MIT
uniform bool opening; // = true
uniform vec4 borderColor;// = vec4(1,1,1,1)
uniform float thickness; // = 0.05

const vec2 center = vec2(0.5, 0.5);

vec4 color_ring(float dist, float t, float thickness, vec4 from, vec4 to) {
    
    float step1 = t-thickness;
    float step2 = t;
    float step3 = t+thickness;
    
    vec4 color = mix(to, borderColor, smoothstep(step1, step2, dist));
    color = mix(color, from, smoothstep(step2,step3,dist));
   
    return color;
}

vec4 transition (vec2 uv) {
  
  float t = opening ? progress : 1.-progress;
  
  if(t == 1.) {
    return getToColor(uv);
  }
  
  if(t == 0.) {
    return getFromColor(uv);
  }
  
  float dist = distance(center,uv);
  
  return color_ring(dist, t, thickness, getFromColor(uv), getToColor(uv)); 
  
}
