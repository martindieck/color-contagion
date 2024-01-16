shader_type canvas_item;

uniform vec2 bullet_hit;

void fragment() {
    // Calculate distance to the bullet hit
    float dist = distance(bullet_hit, SCREEN_UV);

    // Adjust the range and intensity based on your preferences
    float range = 0.05;
    float intensity = 0.7;

    // Apply red color gradually along the trace
    COLOR.rgb += vec3(1.0, 0.0, 0.0) * smoothstep(range, 0.0, dist) * intensity;
}