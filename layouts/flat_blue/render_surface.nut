///////////////////////////////////////////////////
class Final_Renderer
{
    id = null;
    descriptor = null;
    orientation = null;
    aspect = null;
    art = null;
    rez = null;
    visible = null;
    displaySurface = null;
    surf = null;
    //////////////////////////
    constructor(idi, orientationi, aspecti, rezi)
    {
        descriptor = "Final_Render";
        id = idi;
        orientation = orientationi;  // Should be labels only
        aspect = aspecti;            // and used to determine 
        rez = rezi; // reference res that element was set up with
        // Find linked background to use as display res coords.

        surf = fe.add_surface(rezi[0], rezi[1]);
        surf.x = (fe.layout.width / 2) - (surf.width / 2);
        surf.y = (fe.layout.height / 2) - (surf.height / 2);
        visible = false;
        print("Created Final Surface:"+surf+" -id: "+id+" -Aspect: "+aspect+" -Orientation: "+orientation+"\n");
        print("Properties :X:"+surf.x+":Y:"+surf.y+" :W:"+surf.width+":H:"+surf.height+"\n\n");
        surf.shader = final_shader;
    }
    //////////////////////////
    function update()
    {
        surf.width = fe.layout.width;
        surf.height = fe.layout.height;
        // Always centers on the screen.
        surf.x = (fe.layout.width / 2) - (surf.width / 2);
        surf.y = (fe.layout.height / 2) - (surf.height / 2);
    }
    /////////////////////////
    function setVisible(flag)
    { 
        if (flag == true) {
            surf.shader = final_shader;
            final_shader.set_param( "color_texture_sz", surf.width/2.5, surf.height/2.5 );
            final_shader.set_param( "color_texture_pow2_sz", surf.width/2.5, surf.height/2.5 );
            surf.alpha = 255; 
        } else if (flag == false) { 
            surf.shader = noShader;
            surf.alpha = 0; 
        }
    } 
}
///////////////////////////////////////////////////
class First_Renderer extends Final_Renderer
{
    //////////////////////////
    constructor(idi, orientationi, aspecti, rezi)
    {
        descriptor = "BG_Surface";
        id = idi;
        orientation = orientationi;  // Should be labels only
        aspect = aspecti;
        foreach (obj in objectList) {
            if (obj.descriptor == "Final_Render") {
                print("Found final render surface = "+obj+"\n");
                if ( obj.id == id && obj.orientation == orientation && obj.aspect == aspect) {
                    print("Linked to object at address :"+obj+"\n");
                    displaySurface = obj;
                    break;
                }
            }
        }
        // Find linked background to use as display res coords.

        surf = displaySurface.surf.add_surface(displaySurface.surf.width, displaySurface.surf.height);
        surf.x = (fe.layout.width / 2) - (surf.width / 2);
        surf.y = (fe.layout.height / 2) - (surf.height / 2);
        visible = false;
        print("Created First Surface:"+surf+" -id: "+id+" -Aspect: "+aspect+" -Orientation: "+orientation+"\n");
        print("Properties :X:"+surf.x+":Y:"+surf.y+" :W:"+surf.width+":H:"+surf.height+"\n\n");
        surf.shader = fullscreen_shader;
    }
        /////////////////////////
    function setVisible(flag)
    { 
        if (flag == true) {
            surf.shader = fullscreen_shader;
            fullscreen_shader.set_param( "color_texture_sz", surf.width/2.5, surf.height/2.5 );
            fullscreen_shader.set_param( "color_texture_pow2_sz", surf.width/2.5, surf.height/2.5 );
            surf.alpha = 255; 
        } else if (flag == false) { 
            surf.shader = noShader;
            surf.alpha = 0; 
        }
    } 
}