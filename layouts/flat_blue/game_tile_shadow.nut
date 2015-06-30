///////////////////////////////////////////////////
// Use id to link to BGArt by using the BGArt name.
///////////////////////////////////////////////////
// Use to create objects for each res/aspect
// by passing in required x,y,w,d and a
// reference for resolution such as art/surface.
class GametileShadow extends Final_Renderer
{
    refX = null;
    art2 = null;
    created = 0;
    constructor( idi, orientationi, aspecti, rezi, imagefile)
    {
        descriptor = "GametileShadow";
        id = idi;
        orientation = orientationi;  // Should be labels only
        aspect = aspecti;            // and used to determine 
        rez = rezi; // reference res that element was set up with
        // Find linked background to use as display res coords.
        print("GametileShadow searching for BG_Surface\n");
        print("ID :"+id+" Orientation :"+orientation+" Aspect :"+aspect+"\n");
        foreach (obj in objectList) {
            if (obj.descriptor == "BG_Surface" && obj.id == id &&
                obj.orientation == orientation && obj.aspect == aspect) {
                print("Linked to BG_Surface at address :"+obj+" with properties\n");
            print("ID :"+obj.id+" Orientation :"+obj.orientation+" Aspect :"+obj.aspect+"\n");
                displaySurface = obj;
                break;
            }
        }
        art = displaySurface.surf.add_image( imagefile, 0, 0);
        art2 = displaySurface.surf.add_image( imagefile, 0, 0);
        visible = false;
    }
    /////////////////
    function update()
    {
        if (refX == null)
        {
            print("Update : GametileShadow searching for GametileBacker\n");
            print("ID :"+id+" Orientation :"+orientation+" Aspect :"+aspect+"\n");
            foreach (obj in objectList) {
                if ( refX == null && obj.descriptor == "GametileBacker" && obj.id == id && 
                    obj.orientation == orientation && obj.aspect == aspect ) {
                    print("GametileShadow setting width to "+obj.art.width+" from GametileBacker at "+obj+"\n");
                    refX = obj.art.x + obj.art.width;
                    break;
                }
            }
        }
        if (created == 0){
            art.x = refX;
            art.y = displaySurface.surf.y;
            art.height = displaySurface.surf.height;
            art.width = art.height * (art.texture_width / art.texture_height) * 2.0;
            art2.width = art.width;
            art2.height = art.height;
            art2.rotation = 180;
            art2.x = displaySurface.surf.width - art2.width;
            art2.y = art.height;
            created = 1;
        }
    }
    function setVisible(flag)
    { 
        if (flag == true) { 
            art.alpha = 255; 
        } else if (flag == false) { 
            art.alpha = 0; 
        }
    }
}
