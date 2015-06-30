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
        print("Artwork searching for BG_Surface\n");
        print("ID :"+id+" Orientation :"+orientation+" Aspect :"+aspect+"\n");
        foreach (obj in objectList) {
            if (obj.descriptor == "BG_Surface") {
                print("Found BG_Surface at :"+obj+"\n");
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    print("Linked to BG_Surface at address :"+obj+" with properties\n");
                    print("ID :"+obj.id+" Orientation :"+obj.orientation+" Aspect :"+obj.aspect+"\n");
                    displaySurface = obj;
                    break;
                }
            }
        }
        print("Artwork searching for BG_Wallpaper\n");
        foreach (obj in objectList) {
            if (obj.descriptor == "BG_Wallpaper") {
                print("Found BG_Wallpaper at :"+obj+"\n");
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    print("Linked to BG_Wallpaper at address :"+obj+" with properties\n");
                    print("ID :"+obj.id+" Orientation :"+obj.orientation+" Aspect :"+obj.aspect+"\n");
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
        
        if (screenType.orientation == "horizontal"){
            if (gameInfo == "0" || gameInfo == "180"){
                if (screenType.aspect == "4:3"){
                    art.height = displayRef.art.height;
                    art.width = displayRef.art.width;
                    art.x = displayRef.art.x + (displayRef.art.width*1.0 / 2) - (art.width*1.0 / 2);
                } 
                else {
                    art.height = displayRef.art.height;
                    art.width = displayRef.art.width;
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
