///////////////////////////////////////////////////
// Is closely linked to the size of the game tiles.
///////////////////////////////////////////////////

class Wallpaper
{
    id = null;
    descriptor = null;
    orientation = null;
    aspect = null;
    art = null;
    visible = null;
    displaySurface = null;
    spacer = 0;

    constructor( idi, orientationi, aspecti, bgwallpaper)
    {
        id = idi;
        descriptor = "BG_Wallpaper"
        orientation = orientationi;  // Should be labels only
        aspect = aspecti;            // and used to determine 
        foreach (obj in objectList) {
            if (obj.descriptor == "BG_Surface") {
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    displaySurface = obj;
                    break;
                }
            }
        }
        art = displaySurface.surf.add_image( bgwallpaper, 0, 0);
        visible = false;
    }
    /////////////////
    function update()
    {
        if (spacer == 0) {
            foreach (obj in objectList) {
                if (obj.descriptor == "GametileBacker") {
                    if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                        spacer = obj;
                        break;
                    }
                }
            }
        }
        else if (spacer != 0) {
            art.width = displaySurface.surf.width - spacer.art.width;
            // Always centers the artwork on the screen.
            art.x = displaySurface.surf.x + spacer.art.width;
        }
        art.height = displaySurface.surf.height;
        art.y = (displaySurface.surf.height / 2) - (art.height / 2);
    }
    /////////////////////////
    function setVisible(flag)
    { 
        if (flag == true) { 
            art.alpha = 255; 
        } else if (flag == false) { 
            art.alpha = 0; 
        }
    }    
}

