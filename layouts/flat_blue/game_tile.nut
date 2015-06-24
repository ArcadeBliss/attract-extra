///////////////////////////////////////////////////
class GameTile extends Final_Renderer
{
    surf = null;
    icon = null;
    bgi = null;
    title = null;
    refHeight = null;
    refWidth = null;
    refArt = null;
    offset = null;
    //////////////////////////
    constructor(idi, orientationi, aspecti, rez, artFile, gameTileCount, gameOffset)
    {
        descriptor = "GameTile";
        id = idi;
        offset = gameOffset;
        orientation = orientationi;  // Should e labels only
        aspect = aspecti;            // and used to determine 
        /////////////////////////////////////////////////////
        // Find linked background to use as display res coords.
        foreach (obj in objectList) {
            if (obj.descriptor == "BG_Surface") {
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    displaySurface = obj;
                    break;
                }
            }
        }
        visible = false;
        ////////////////////////
        // Set up the surface //
        ////////////////////////
        refArt = fe.add_image( artFile, displaySurface.surf.x - displaySurface.surf.width, 0, 1, 1);
        refArt.alpha = 0;
        refHeight = (displaySurface.surf.height / gameTileCount);
        refWidth = refHeight * (refArt.texture_width.tofloat() / refArt.texture_height.tofloat());
        
        surf = displaySurface.surf.add_surface(refWidth, refHeight);
        icon = surf.add_artwork( gameTileArt, 0, 0, surf.height, surf.height);
        icon.index_offset = gameOffset;
        icon.video_flags = Vid.ImagesOnly;
        icon.shader = tile_artwork_shader;
        bgi = surf.add_image( artFile, 0, 0, surf.width, surf.height);
        // 
        local tx = surf.x + (icon.width * 1.0);
        local endspace = (displaySurface.surf.width / (rez[0] * 0.1) / 2.0);
        title = surf.add_text( "[Title]", tx, 0, (surf.width-tx-endspace), (surf.height) );
        title.charsize = surf.height / 6;
        title.word_wrap = true;
        title.align= Align.Left;
        title.index_offset = gameOffset;
    }
    //////////////////////////
    function update()
    {
        // Base_Image, Sel_Offset, Art, Text
        surf.x = displaySurface.surf.x;
        if (title.index_offset == 0) {
            surf.y = displaySurface.surf.y + (displaySurface.surf.height / 2) - (surf.height /2);
        } else {
            foreach (obj in objectList) {
                if (obj.orientation == orientation && obj.aspect == aspect){
                    if (obj.descriptor == "GameTile" && obj.title.index_offset == 0) {
                        surf.y = obj.surf.y + (obj.surf.height * (title.index_offset) );
                    }
                }
            }
        }
    }
    //////////////////////////
    function setVisible(flag)
    { 
        if (flag == true) {
            surf.shader = game_tile_shader;
            surf.alpha = 255;
        } else if (flag == false) {
            surf.shader = noShader;
            surf.alpha = 0; 
        }
    }
}