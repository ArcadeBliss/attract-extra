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
    created = 0;

    constructor( idi, orientationi, aspecti, bgwallpaper)
    {
        id = idi;
        descriptor = "BG_Wallpaper"
        orientation = orientationi;
        aspect = aspecti;
        print("BG_Wallpaper searching for BG_Surface\n");
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
        art = displaySurface.surf.add_image( bgwallpaper, 0, 0);
        visible = false;
    }
    /////////////////
    function update()
    {
        if (spacer == 0) {
            print("Update : BG_Wallpaper searching for GametileBacker\n");
            print("ID :"+id+" Orientation :"+orientation+" Aspect :"+aspect+"\n");
            foreach (obj in objectList) {
                if (obj.descriptor == "GametileBacker") {
                    print("Found GametileBacker at :"+obj+"\n");
                    if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                        print("Linked to GametileBacker at address :"+obj+"\n");
                        spacer = obj;
                        break;
                    }
                }
            }
        }
        if (created == 0){
            if (spacer != 0) {
                art.width = displaySurface.surf.width - spacer.art.width;
                // Always centers the artwork on the screen.
                art.x = displaySurface.surf.x + spacer.art.width;
                created = 1;
            }
            art.height = displaySurface.surf.height;
            art.y = (displaySurface.surf.height / 2) - (art.height / 2);
        }
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

