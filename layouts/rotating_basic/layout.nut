///////////////////////////////////////
///
///     Feel free to use any part you like.
///        Various bits and pieces were flogged from other examples and twisted beyond recognition.
///    Luke Jones 4/6/14
///
///////////////////////////////////////

class UserConfig {
	</ label="Title Artwork", help="The artwork used for the title", options="marquee,box,wheel" />
	title_art="marquee";
}

local layoutSettings = fe.get_config();

// Globals
titleSize <- 42;
wheelArt <- (layoutSettings["title_art"]);
orig_width <- fe.layout.width;
orig_height <- fe.layout.height;

function setDimensions(x,y)
{
    fe.layout.width = x;
    fe.layout.height = y;
}

// Order of NUTS determines drawing order.
fe.do_nut("wheel.nut");
fe.do_nut("video.nut");
fe.do_nut("set_overlay.nut");
fe.do_nut("text.nut");
fe.do_nut("set_orientation.nut");