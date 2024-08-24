// -*- mode: C; -*-
#version 120

varying vec3 normal;

void main()
{
    gl_Position = ftransform();
    gl_TexCoord[0] = gl_TextureMatrix[0] * gl_MultiTexCoord0;
    gl_TexCoord[2] = gl_TextureMatrix[2] * gl_MultiTexCoord2;
    normal = gl_NormalMatrix * gl_Normal;
}
