// author: dangerchris
// License: MIT
uniform bool opening; // = true
uniform vec4 borderColor;// = vec4(1,1,1,1)
uniform float thickness; // = 0.05

const vec2 center = vec2(0.5, 0.5);
const float PI = 3.1415926534;
const float TAU = PI*2.0;

vec4 color_ring(vec2 uv, float dist, float t, float thickness, vec4 from, vec4 to) {
  
    float angle = atan(uv.y - 0.5, uv.x - 0.5) - 0.5 * PI*1.*t;
    float normalized = (angle + 1. * PI) * (7.0 * PI);
    float step1 = t-thickness;
    float step2 = t;
    float step3 = t+thickness;
    
    vec2 position = uv;
    
    float d = dist-(sin(normalized*2.))*0.01*dist/5.;
    
    vec2 pos = center-uv;
    vec4 color = mix(to, borderColor, smoothstep(step1, step2, d));
    color = mix(color, from, smoothstep(step2,step3,d));
   
    return vec4(vec3(color), 1);
}

float easeOutCubic(float t) {
  return 1. - pow(1. - t, 3.);
}

vec4 transition (vec2 uv) {
  
  float t = opening ? progress : 1.-progress;
  
  if(t == 1.) {
    return getToColor(uv);
  }
  
  if(t == 0.) {
    return getFromColor(uv);
  }
  
  t = easeOutCubic(t);
  
  float dist = distance(center,uv);
  
  return color_ring(uv, dist, t, thickness, getFromColor(uv), getToColor(uv)); 
  
}
