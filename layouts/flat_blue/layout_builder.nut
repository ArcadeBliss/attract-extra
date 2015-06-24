// Tilecount must be an uneven number.

function build_layout(id , orientation, aspect, rez, tilecount)
{
    local m = tilecount % 2;
    local tileRange = tilecount - m;
    tileRange /= 2;

    objectList.append(Final_Renderer(   id, orientation, aspect, rez));
    objectList.append(First_Renderer(   id, orientation, aspect, rez));
    objectList.append(Wallpaper(        id, orientation, aspect, "art/fb_bg1.jpg"));
    objectList.append(Artwork(          id, orientation, aspect, rez, "video", "snapMenu" ));
    objectList.append(GametileBacker(   id, orientation, aspect, "art/underlay.png" ));
    objectList.append(GametileShadow(   id, orientation, aspect, rez, "art/sidebar_shadow.png" ));
    
    objectList.append(GameTile(     id, orientation, aspect, rez, "art/sidebar_selected.png", tilecount, 0));
    for (local x = -tileRange; x<= tileRange; x+=1)
    {
        if (x != 0){
        objectList.append(GameTile(     id, orientation, aspect, rez, "art/sidebar_offset.png", tilecount, x));
        }
    }
    objectList.append(Infobox(          id, orientation, aspect, rez, "art/infoBox.png", "snapRight", "snapBottom"));
}