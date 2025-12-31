#pragma header

uniform vec2 size;
uniform vec4 color;

void main()
{
    vec4 gay = flixel_texture2D(bitmap, openfl_TextureCoordv);
    if (gay.a == 0.) {
        float w = size.x / openfl_TextureSize.x;
        float h = size.y / openfl_TextureSize.y;

        if (flixel_texture2D(bitmap, vec2(openfl_TextureCoordv.x + w, openfl_TextureCoordv.y)).a != 0.
        || flixel_texture2D(bitmap, vec2(openfl_TextureCoordv.x - w, openfl_TextureCoordv.y)).a != 0.
        || flixel_texture2D(bitmap, vec2(openfl_TextureCoordv.x, openfl_TextureCoordv.y + h)).a != 0.
        || flixel_texture2D(bitmap, vec2(openfl_TextureCoordv.x, openfl_TextureCoordv.y - h)).a != 0.)
            gay = color;
    }
    gl_FragColor = gay;
}