///////////////////////////////////////////////////
noShader <- fe.add_shader( Shader.Empty );
video_shader <- noShader;
game_tile_shader <- noShader;
tile_artwork_shader <- noShader;
infobox_shader <- noShader;
fullscreen_shader <- noShader;
final_shader <- noShader;

pixel_shader <- fe.add_shader( Shader.Fragment, "shaders/Pixel.frag" );
                pixel_shader.set_param("pixelDark", 1.2);
                
scanline_shader <- fe.add_shader( Shader.Fragment, "shaders/Scanlines.frag" )
                scanline_shader.set_param("scannerDarkly", 1.4);
                
bloom_shader <- fe.add_shader( Shader.Fragment, "shaders/Bloom_shader.frag" );

phosphor_shader <- fe.add_shader( Shader.VertexAndFragment, 
                "shaders/phosphor.vsh","shaders/phosphor_rgb32_dir.fsh" );
                phosphor_shader.set_param( "color_texture_sz", 640, 480 );
                phosphor_shader.set_texture_param( "mpass_texture" );

curvature_shader <- fe.add_shader( Shader.VertexAndFragment, 
                "shaders/curvature_simple.vsh","shaders/curvature_simple_rgb32_dir.fsh" );
                curvature_shader.set_param( "color_texture_sz", 640, 480 );
                curvature_shader.set_param( "color_texture_pow2_sz", 640, 480 );
                curvature_shader.set_texture_param( "mpass_texture" );
                
lottes_shader <- fe.add_shader( Shader.VertexAndFragment, 
                "shaders/curvature_simple.vsh","shaders/curvature_simple_rgb32_dir.fsh" );
                lottes_shader.set_param( "color_texture_sz", 640, 480 );
                lottes_shader.set_param( "color_texture_pow2_sz", 640, 480 );
                lottes_shader.set_texture_param( "mpass_texture" );
                
halation_shader <- fe.add_shader( Shader.VertexAndFragment, 
                "shaders/CRT_SIMPLE-halation.vsh","shaders/CRT_SIMPLE-halation_rgb32_dir.fsh" );
                halation_shader.set_param( "color_texture_sz", 640, 480 );
                halation_shader.set_param( "color_texture_pow2_sz", 640, 480 );
                halation_shader.set_texture_param( "mpass_texture" );
                
halation_complex_shader <- fe.add_shader( Shader.VertexAndFragment, 
                "shaders/CRT_COMPLEX-halation.vsh","shaders/CRT_COMPLEX-halation_rgb32_dir.fsh" );
                halation_complex_shader.set_param( "color_texture_sz", 640, 480 );
                halation_complex_shader.set_param( "color_texture_pow2_sz", 640, 480 );
                halation_complex_shader.set_texture_param( "mpass_texture" );
                
if ( layoutSettings["enable_shaders"] == "Yes" )
{
    switch (layoutSettings["game_tile_shader_choice"]){
            case "Pixel": game_tile_shader = pixel_shader;
                break;
            case "Scanlines": game_tile_shader = scanline_shader;
                break;
            case "Bloom": game_tile_shader = bloom_shader;
                break;
            case "Phosphor": game_tile_shader = phosphor_shader;
                break;
            case "None": game_tile_shader = noShader;
                break;
    }
    switch (layoutSettings["tile_artwork_shader_choice"]){
            case "Pixel": tile_artwork_shader = pixel_shader;
                break;
            case "Scanlines": tile_artwork_shader = scanline_shader;
                break;
            case "Bloom": tile_artwork_shader = bloom_shader;
                break;
            case "Phosphor": tile_artwork_shader = phosphor_shader;
                break;
            case "None": tile_artwork_shader = noShader;
                break;
    }
    switch (layoutSettings["infobox_shader_choice"]){
            case "Pixel": infobox_shader = pixel_shader;
                break;
            case "Scanlines": infobox_shader = scanline_shader;
                break;
            case "Bloom": infobox_shader = bloom_shader;
                break;
            case "Phosphor": infobox_shader = phosphor_shader;
                break;
            case "None": infobox_shader = noShader;
                break;
    }
    switch (layoutSettings["video_shader_choice"]){
            case "Pixel": video_shader = pixel_shader;
                break;
            case "Scanlines": video_shader = scanline_shader;
                break;
            case "Bloom": video_shader = bloom_shader;
                break;
            case "Phosphor": video_shader = phosphor_shader;
                break;
            case "Curvature": video_shader = curvature_shader;
                break;
            case "Lottes": video_shader = lottes_shader;
                break;
            case "Halation": video_shader = halation_shader;
                break;
            case "Halation_Complex": video_shader = halation_complex_shader;
                break; 
            case "None": video_shader = noShader;
                break;
    }
    switch (layoutSettings["fullscreen_shader_choice"]){
            case "Pixel": fullscreen_shader = pixel_shader;
                break;
            case "Scanlines": fullscreen_shader = scanline_shader;
                break;
            case "Bloom": fullscreen_shader = bloom_shader;
                break;
            case "Phosphor": fullscreen_shader = phosphor_shader;
                break;
            case "Curvature": fullscreen_shader = curvature_shader;
                break;
            case "Lottes": fullscreen_shader = lottes_shader;
                break;
            case "Halation": fullscreen_shader = halation_shader;
                break;
            case "Halation_Complex": fullscreen_shader = halation_complex_shader;
                break; 
            case "None": fullscreen_shader = noShader;
                break;
    }
    switch (layoutSettings["finalscreen_shader_choice"]){
            case "Pixel": final_shader = pixel_shader;
                break;
            case "Scanlines": final_shader = scanline_shader;
                break;
            case "Bloom": final_shader = bloom_shader;
                break;
            case "Phosphor": final_shader = phosphor_shader;
                break;
            case "Curvature": final_shader = curvature_shader;
                break;
            case "Lottes": final_shader = lottes_shader;
                break;
            case "Halation": final_shader = halation_shader;
                break;
            case "Halation_Complex": final_shader = halation_complex_shader;
                break; 
            case "None": final_shader = noShader;
                break;
    }
}
else 
{ 
    video_shader = noShader; game_tile_shader = noShader; 
    tile_artwork_shader = noShader; infobox_shader = noShader;
    fullscreen_shader = noShader; final_shader = noShader;
    
}
