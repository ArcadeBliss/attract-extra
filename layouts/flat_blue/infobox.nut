/////////////////////////////////////////////////////
// Is closely linked to the size of the Game Tiles //
/////////////////////////////////////////////////////
class Infobox extends Final_Renderer
{
    surf = null;
    artFile = null;
    refArt = null;
    refWidth = null;
    refHeight = null;
    showing = null;
    filter = null;
    year = null;
    manu = null;
    x = null;
    y = null;
    //////////////////////////
    constructor(idi, orientationi, aspecti, rezi, artFilei, xi, yi)
    {
        descriptor = "Infobox";
        id = idi;
        artFile = artFilei;
        orientation = orientationi;  // Should e labels only
        aspect = aspecti;            // and used to determine 
        x = xi;                      // which obj to update
        y = yi;
        rez = rezi; // reference res that element was set up with
        // Find linked background to use as display res coords.
        foreach (obj in objectList) { // Horrible coding style, only for convieniance.
            if (obj.descriptor == "BG_Surface") {
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    displaySurface = obj;
                    break;
        } } }
        visible = false;
        ////////////////////////
        // Set up the surface //
        ////////////////////////
        // Set Infobox height to match the game refHeight
        foreach (obj in objectList) {
            if (obj.descriptor == "GameTile" && obj.orientation == orientation && obj.aspect == aspect && obj.id == id) {
                refHeight = obj.surf.height * 2.0;
                break;
            }
        }
        refArt = fe.add_image( artFile, displaySurface.surf.x - displaySurface.surf.width, 0);
        refArt.alpha = 0;
        refWidth = refHeight * (refArt.texture_width.tofloat() / refArt.texture_height.tofloat());
        
        surf = displaySurface.surf.add_surface(refArt.texture_width, refArt.texture_height);
        surf.add_image( artFile, 0, 0, surf.width, surf.height);
        // 
        local x1 = 290;
        local y1 = 195;
        local x2 = 670;
        local y2 = 245;
        local w1 = 290;
        local h1 = 40;
        showing = surf.add_text("Showing:", x1, y1, w1, h1);
        showing.charsize = 36;
        showing.align = Align.Right;
        year = surf.add_text("[Year]", x2, y1, w1, h1);
        year.charsize = 36;
        year.align = Align.Right;
        filter = surf.add_text("[FilterName]", x1, y2, w1, h1);
        filter.charsize = 36;
        filter.align = Align.Right;
        manu = surf.add_text("[Manufacturer]", x2, y2, w1, h1);
        manu.charsize = 36;
        manu.align = Align.Right;
        surf.shader = infobox_shader;
    }
    //////////////////////////
    function update()
    {
        surf.height = refHeight;
        surf.width = refWidth;
        if (x == "snapLeft") {
            surf.x = (displaySurface.surf.x);
        } else if (x == "snapRight") {
            surf.x = (displaySurface.surf.x + (displaySurface.surf.width - surf.width));
        } else {
            surf.x = (displaySurface.surf.x + (displaySurface.surf.width / (rez[0] / x) ));
        }
        
        if (y == "snapTop") {
            surf.y = (displaySurface.surf.y);
        } else if (y == "snapBottom") {
            surf.y = (displaySurface.surf.y + (displaySurface.surf.height - surf.height));
        } else {
            surf.y = (displaySurface.surf.y + (displaySurface.surf.height / (rez[1] / y) ));
        }
    }
    //////////////////////////
    function setVisible(flag)
    { 
        if (flag == true) {
            surf.shader = infobox_shader;
            surf.alpha = 255; 
        } else if (flag == false) { 
            surf.shader = noShader;
            surf.alpha = 0; 
        }
    }
}