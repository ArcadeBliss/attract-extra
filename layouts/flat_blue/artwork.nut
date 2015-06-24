///////////////////////////////////
// Class for the Videos/Snaps BG //
///////////////////////////////////
class Artwork extends Final_Renderer
{
    x = 0;
    displayRef = 0;
    constructor( idi, orientationi, aspecti, refResi, type, xi)
    {
        descriptor = "Artwork";
        id = idi;
        orientation = orientationi;
        aspect = aspecti;
        // Find linked background to use as display res coords.
        foreach (obj in objectList) {
            if (obj.descriptor == "BG_Surface") {
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    displaySurface = obj;
                    break;
                }
            }
        }
        foreach (obj in objectList) {
            if (obj.descriptor == "BG_Wallpaper") {
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    displayRef = obj;
                    break;
                }
            }
        }
        art = displaySurface.surf.add_artwork( type, 0, 0);
        visible = false;
    }
    //////////////////////////
    function update()
    {
        local gameInfo = fe.game_info(Info.Rotation);
        if (x == null || x == 0) {
            foreach (obj in objectList) {
                if (obj.descriptor == "GametileBacker") {
                    if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                        x = obj.art.width;
                        break;
                    }
                }
            }
        }
        
        if (screenType.orientation == "horizontal"){
            if (gameInfo == "0" || gameInfo == "180"){
                if (screenType.aspect == "4:3"){
                    art.height = displayRef.art.height;
                    art.width = displayRef.art.width;
                    art.x = displayRef.art.x + (displayRef.art.width*1.0 / 2) - (art.width*1.0 / 2);
                } 
                else {
                    art.height = displayRef.art.height;
                    art.width = displayRef.art.width - x;
                    art.x = displayRef.art.x + (displayRef.art.width*1.0 / 2) - (art.width*1.0 / 2);
                }
            } 
            else if (gameInfo == "90" || gameInfo == "270"){
                if (screenType.aspect == "4:3"){
                    art.height = displayRef.art.height;
                    art.width = (art.height * (art.texture_width * 1.0 / art.texture_height));
                    art.x = displayRef.art.x + (displayRef.art.width*1.0 / 2) - (art.width*1.0 / 2);
                } 
                else {
                    art.height = displayRef.art.height;
                    art.width = (art.height * (art.texture_width * 1.0 / art.texture_height));
                    art.x = displayRef.art.x + (displayRef.art.width*1.0 / 2) - (art.width*1.0 / 2);
                }
            }
        }
        else if (screenType.orientation == "vertical"){
            if (gameInfo == "90" || gameInfo == "270"){
                art.height = displaySurface.surf.height;
                art.width = displaySurface.surf.width;
            } 
            else {
                art.x = displaySurface.surf.x;
                art.width = displaySurface.surf.width;
                art.height = (art.width * (art.texture_width * 1.0 / art.texture_height));
            }
        }
        art.y = ((displayRef.art.height / 2.0) - (art.height / 2.0));
        art.shader = video_shader;
    }
    /////////////////////////
    function setVisible(flag) { 
        if (flag == true) {
            if (art.video_playing == false){
                art.shader = video_shader;
                video_shader.set_param( "color_texture_sz", art.width/2.5, art.height/2.5 );
                video_shader.set_param( "color_texture_pow2_sz", art.width/2.5, art.height/2.5 );
                art.video_playing == true;
            }
            art.alpha = 255;
        } else if (flag == false) {
            art.shader = noShader;
            art.video_playing == false;
            art.alpha = 0;
        }
    }
}
