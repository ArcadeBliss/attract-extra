///////////////////////////////////////////////////
// Use id to link to BGArt by using the BGArt name.
///////////////////////////////////////////////////
// Use to create objects for each res/aspect
// by passing in required x,y,w,d and a
// reference for resolution such as art/surface.
class GametileBacker extends Final_Renderer
{
    refWidth = null;
    created = 0;
    constructor( idi, orientationi, aspecti, imagefile)
    {
        descriptor = "GametileBacker";
        id = idi;
        orientation = orientationi;  // Should be labels only
        aspect = aspecti;            // and used to determine 
        // Find linked background to use as display res coords.
        print("GametileBacker searching for BG_Surface\n");
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
        art = displaySurface.surf.add_image( imagefile, 0, 0);
        visible = false;
    }
    /////////////////
    function update()
    {
        if (refWidth == null || refWidth == 0) {
            print("Update : GametileBacker searching for GameTile\n");
            print("ID :"+id+" Orientation :"+orientation+" Aspect :"+aspect+"\n");
            foreach (obj in objectList) {
                if (obj.descriptor == "GameTile" && obj.id == id && obj.offset != 0 &&
                    obj.orientation == orientation && obj.aspect == aspect ) {
                    print("Setting refWidth to "+obj.surf.width+" from GameTile "+obj+"\n");
                    art.width = refWidth = obj.surf.width;
                    break;
                }
            }
        }
        if (created == 0){
            art.x = displaySurface.surf.x;
            art.y = displaySurface.surf.y;
            art.height = displaySurface.surf.height;
            created = 1;
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
