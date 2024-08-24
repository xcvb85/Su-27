// -*- mode: C; -*-
#version 120

varying vec3 normal;

uniform sampler2D base_color_tex;

uniform vec3 emissive_color;
uniform float emissive_factor;
uniform float emissive_offset;

void main()
{
	vec3 color = texture2D(base_color_tex, gl_TexCoord[0].xy).rgb;
	vec3 emissive = emissive_factor * emissive_color * (color + vec3(emissive_offset));

	vec3 lightDir = normalize(gl_LightSource[0].position.xyz);
	float NdotL = dot(normal, lightDir);

	color *= NdotL;
	color = max(color, emissive);

	gl_FragColor = vec4(color, 1.0);
}
