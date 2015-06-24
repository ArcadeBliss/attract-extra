class UserConfig {
	</ label="Game Tile Artwork", help="The artwork used for the tiles", options="snap,title,video,movie" />
	game_tile_art="snap";

	</ label="Shaders Enabled", help="Enable Shaders on Artwork (requires shader support)", options="Yes,No" />
	enable_shaders="Yes";
	
	</ label="Game Tile Shader", help="Choose a shader for the tiles", options="Scanlines,Bloom,None" />
	game_tile_shader_choice="None";
        
        </ label="Tile Artwork Shader", help="Choose a shader for the tile icon", options="Pixel,Scanlines,Bloom,Phosphor,None" />
	tile_artwork_shader_choice="Bloom";
        
        </ label="Infobox Shader", help="Choose a shader for the information box", options="Scanlines,Bloom,None" />
	infobox_shader_choice="None";
        
        </ label="Video Shader", help="Choose a shader for the video/snaps", options="Pixel,Scanlines,Bloom,Phosphor,Curvature,Lottes,Halation,Halation_Complex,None" />
	video_shader_choice="Phosphor";
        
        </ label="First Screen Shader", help="First full screen shader", options="Pixel,Scanlines,Bloom,Phosphor,Curvature,Lottes,Halation,Halation_Complex,None" />
	fullscreen_shader_choice="Halation";
        
        </ label="Final Screen Shader", help="Final screen shader", options="Pixel,Scanlines,Bloom,Phosphor,Curvature,Lottes,Halation,Halation_Complex,None" />
	finalscreen_shader_choice="Bloom";
}
layoutSettings <- fe.get_config();

print("\n");
print("///////////////////////////////////////////\n");
print("//                                       //\n");
print("//     Attract Mode - Flat Blue Theme    //\n");
print("//                                       //\n");
print("//  Artwork by CLAN LOGO DESIGN          //\n");
print("//       http://www.ClanLogoDesign.com   //\n");
print("//  Code by Garage Arcades               //\n");
print("//       http://www.garagearcades.co.nz  //\n");
print("///////////////////////////////////////////\n");
print("\n");

///////////////////////////////////////////////////////////////////
// TESTING
// fe.layout.width = 1600;
// fe.layout.height = 1200;
// screenType <- { orientation = "horizontal", aspect = "4:3" }
// screenType <- { orientation = "horizontal", aspect = "16:10" }
// screenType <- { orientation = "horizontal", aspect = "16:9" }
///////////////////////////////////////////////////////////////////

local ratio = fe.layout.width * 1.0 / fe.layout.height;
print("Ratio = "+ratio+"\n");
if (ratio > 1.32 && ratio < 1.34){
    screenType <- { orientation = "horizontal", aspect = "4:3" }
    print("Setting screenType to : "+screenType+"\n");
}
else if (ratio > 1.59 && ratio < 1.68){
    screenType <- { orientation = "horizontal", aspect = "16:10" }
    print("Setting screenType to : "+screenType+"\n");
}
else if (ratio > 1.76 && ratio < 1.79){
    screenType <- { orientation = "horizontal", aspect = "16:9" }
    print("Setting screenType to : "+screenType+"\n");
}
else if (ratio > 0.74 && ratio < 0.76){
    screenType <- { orientation = "vertical", aspect = "4:3" }
    print("Setting screenType to : "+screenType+"\n");
}
else if (ratio > 0.61 && ratio < 0.63){
    screenType <- { orientation = "vertical", aspect = "16:10" }
    print("Setting screenType to : "+screenType+"\n");
}
else if (ratio > 0.55 && ratio < 0.57){
    screenType <- { orientation = "vertical", aspect = "16:9" }
    print("Setting screenType to : "+screenType+"\n");
}

// Globals
objectList <- [];
orig_width <- fe.layout.width;
orig_height <- fe.layout.height;
gameTileArt <- (layoutSettings["game_tile_art"]);

fe.do_nut("shader_setup.nut");

/////////////////////////////
fe.do_nut("render_surface.nut");
fe.do_nut("artwork.nut");
fe.do_nut("game_tile_backer.nut");
fe.do_nut("game_tile_shadow.nut");
fe.do_nut("infobox.nut");
fe.do_nut("bg_wallpaper.nut");
fe.do_nut("game_tile.nut");
fe.do_nut("layout_builder.nut");
/////////////////////////////
// build_layout(id , orientation, aspect, rez, tilecount)
/////////////////////////////
if (screenType.aspect == "4:3"){
    build_layout("BG_Vert_4:3",   "horizontal", "4:3",   [1600.0, 1200.0], 11.0);
    build_layout("BG_Vert_4:3",   "vertical",   "4:3",   [1200.0, 1600.0], 13.0);
} else if (screenType.aspect == "16:10"){
    build_layout("BG_Horz_16:10", "horizontal", "16:10", [1920.0, 1080.0], 11.0);
    build_layout("BG_Vert_16:10", "vertical",   "16:10", [1080.0, 1920.0], 15.0);
} else if (screenType.aspect == "16:9"){
    build_layout("BG_Horz_16:9",  "horizontal", "16:9",  [1920.0, 1080.0], 9.0);
    build_layout("BG_Vert_16:9",  "vertical",   "16:9",  [1080.0, 1920.0], 15.0);
}
/////////////////////////
// Generic Update Loop //
/////////////////////////
local callTime = 0;
local transTime = 0;
local last_rotation = null;
function updateAll()
{
    local actual_rotation = (fe.layout.base_rotation + fe.layout.toggle_rotation)%4;
    if (( actual_rotation == RotateScreen.Left ) || ( actual_rotation == RotateScreen.Right ))
    {
        screenType.orientation = "vertical"
        // Swapping res dimensions is required to maintain correct display dimensions.
        fe.layout.width = orig_height;
        fe.layout.height = orig_width;
    }
    else
    { 
        screenType.orientation = "horizontal"
        fe.layout.width = orig_width;
        fe.layout.height = orig_height;
    }
    // Update the objects related to the current display.
    foreach (obj in objectList)
    {
        if (obj.orientation == screenType.orientation && obj.aspect == screenType.aspect)
        {
            if (obj.visible != true){
            obj.update();
            obj.setVisible(true);}
        }
        else 
        {
            // Skip update and set invisible if not in use.
            obj.setVisible(false);
        }
    }
    last_rotation = actual_rotation;
    return false;
}
//////////////////////////////////////////////
// Only calls updateAll if rotation changes //
//////////////////////////////////////////////
function updateCallback(ttime)
{
    local actual_rotation = (fe.layout.base_rotation + fe.layout.toggle_rotation)%4;
    if (callTime == 0) callTime = ttime;
    if (ttime - callTime > 60 && last_rotation != actual_rotation) {
        updateAll();
        callTime = 0;
    }
    return false;
}
//////////////////////////////////////////////
// To initialise all objects on layout load //
//////////////////////////////////////////////
function updateTransition(ttype,var,ttime)
{
    if (transTime == 0) transTime = ttime;
    if (ttype == Transition.StartLayout || ttype == Transition.ToNewList) {
        updateAll();
    }
    else if (ttype == Transition.ToNewSelection || ttype == Transition.FromOldSelection) {
        foreach (obj in objectList)
        {
            if (obj.orientation == screenType.orientation && obj.aspect == screenType.aspect
                && obj.descriptor == "Artwork")
            {
                obj.update();
            }
        }
    }
    return false;
}
//////////////////////////////////////////////
// The object design relies on updates      //
// being called to get everything in order. //
//////////////////////////////////////////////
// This works well because all objects need to
// be initialsed once with updates, then
// re-updated to collect inter-object links.
fe.add_ticks_callback( "updateCallback" );
fe.add_transition_callback( "updateTransition" );