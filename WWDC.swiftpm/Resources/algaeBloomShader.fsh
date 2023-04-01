//
// Simple example shader, removes red and blue channels to leave
// our texture green-tinted. Demo shader for related blog post:
// http://sound-of-silence.com
// For LICENSE information please see AppDelegate.swift.
//

void main() {
    
    float speed = u_time * 0.35;
    float offset = 0.0;
    
    vec2 coord = v_tex_coord;
    
    // Modify (offset slightly) using a sine wave
    coord.x += cos((coord.x + speed) * frequency) * intensity;
    coord.y += sin((coord.y + speed) * frequency) * intensity;
    
    // Rather than the original pixel color, using the offset target pixel
    vec4 targetPixelColor = texture2D(u_texture, coord);
    
    // Finish up by setting the actual color on gl_FragColor
    gl_FragColor = targetPixelColor;
}

