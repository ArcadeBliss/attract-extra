///////////////////////////////////////////////////
// Use id to link to BGArt by using the BGArt name.
///////////////////////////////////////////////////
// Use to create objects for each res/aspect
// by passing in required x,y,w,d and a
// reference for resolution such as art/surface.
class GametileBacker extends Final_Renderer
{
    refWidth = null;
    constructor( idi, orientationi, aspecti, imagefile)
    {
        descriptor = "GametileBacker";
        id = idi;
        orientation = orientationi;  // Should be labels only
        aspect = aspecti;            // and used to determine 
        // Find linked background to use as display res coords.
        foreach (obj in objectList) {
            if (obj.descriptor == "BG_Surface") {
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    displaySurface = obj;
                    break;
                }
            }
        }
        art = displaySurface.surf.add_image( imagefile, 0, 0);
        visible = false;
    }
    /////////////////
    function update()
    {
        if (refWidth == null || refWidth == 0) {
            foreach (obj in objectList) {
                if (obj.descriptor == "GameTile" && obj.id == id && obj.offset != 0 &&
                    obj.orientation == orientation && obj.aspect == aspect ) {
                    refWidth = obj.surf.width;
                    break;
                }
            }
        }
        art.x = displaySurface.surf.x;
        art.y = displaySurface.surf.y;
        art.width = refWidth;
        art.height = displaySurface.surf.height;
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
