shader_type spatial;

uniform vec3 GLOW_COLOR = vec3(1.0, 0.0, 0.0); // Pure white
uniform float GLOW_STRENGTH = 5.0; // Adjust for desired intensity

void fragment() {
    // Access the base color (if needed)
    // vec3 base_color = TEXTURE(texture_albedo, UV).rgb; 

    // Calculate emission with maximum white and high intensity
    vec3 emission = GLOW_COLOR * GLOW_STRENGTH;

    // Apply the pure white glow
    ALBEDO = emission;
}
