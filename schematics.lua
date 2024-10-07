-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- <>==============================================================<> --
local mycelium1	= modname.. ":mycelium_1"
local mycelium2	= modname.. ":mycelium_2"
local mushstem	= modname.. ":mushroom_stalk"
local mushcap	= modname.. ":mushroom_cap"
local mushgills	= modname.. ":mushroom_gills"

local root = {
	".......",
	"..rrr..",
	".rrRrr.",
	".rRRRr.",
	".rrRrr.",
	"..rrr..",
	".......",
}
local stem = {
	".......",
	".......",
	".......",
	"...t...",
	".......",
	".......",
	".......",
}
local caplow = {
	"..ccc..",
	".cgggc.",
	"cgggggc",
	"cggtggc",
	"cgggggc",
	".cgggc.",
	"..ccc..",
}
local capmid = {
	".......",
	"..ccc..",
	".ccccc.",
	".ccccc.",
	".ccccc.",
	"..ccc..",
	".......",
}
local caphi = {
	".......",
	".......",
	"..ccc..",
	"..ccc..",
	"..ccc..",
	".......",
	".......",
}
nodecore.bigmushroom_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		R = {name = mycelium2, prob = 255, force_place = true},
		r = {name = mycelium1, prob = 100, force_place = true},
		t = {name = mushstem, prob = 255, force_place = true},
		c = {name = mushcap, prob = 255},
		g = {name = mushgills, prob = 255},
	},
	{
		root,
		root,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		caplow,
		capmid,
		caphi
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 255},
			{ypos = 3, prob = 255},
			{ypos = 4, prob = 100},
			{ypos = 5, prob = 100},
			{ypos = 6, prob = 100},
			{ypos = 7, prob = 100},
			{ypos = 8, prob = 100},
			{ypos = 9, prob = 100},
			{ypos = 10, prob = 255},
			{ypos = 11, prob = 255},
			{ypos = 12, prob = 255},
			{ypos = 13, prob = 255},
		}
	}
)
-- <>==============================================================<> --

local glowmushstem	= "wc_fungi:mushroom_stalk_glow"
local glowmushcap	= "wc_fungi:mushroom_cap_glow"
local glowmushgills	= "wc_fungi:mushroom_gills_glow"

local glowroot = {
	".......",
	"..rrr..",
	".rrRrr.",
	".rRRRr.",
	".rrRrr.",
	"..rrr..",
	".......",
}
local glowstem = {
	".......",
	".......",
	".......",
	"...t...",
	".......",
	".......",
	".......",
}
local glowcapbot = {
	".......",
	"..ggg..",
	".ggggg.",
	".ggtgg.",
	".ggggg.",
	"..ggg..",
	".......",
}
local glowcaplow = {
	"..ccc..",
	".cGGGc.",
	"cGGGGGc",
	"cGGtGGc",
	"cGGGGGc",
	".cGGGc.",
	"..ccc..",
}
local glowcaptop = {
	".......",
	"..ccc..",
	".ccccc.",
	".ccccc.",
	".ccccc.",
	"..ccc..",
	".......",
}
nodecore.bigmushroom_glow_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		R = {name = mycelium2, prob = 255, force_place = true},
		r = {name = mycelium1, prob = 100, force_place = true},
		t = {name = glowmushstem, prob = 255, force_place = true},
		c = {name = glowmushcap, prob = 255},
		G = {name = glowmushgills, prob = 255},
		g = {name = glowmushgills, prob = 100},
	},
	{
		glowroot,
		glowroot,
		glowstem,
		glowstem,
		glowstem,
		glowstem,
		glowstem,
		glowstem,
		glowstem,
		glowstem,
		glowcapbot,
		glowcaplow,
		glowcaptop
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 255},
			{ypos = 3, prob = 255},
			{ypos = 4, prob = 160},
			{ypos = 5, prob = 160},
			{ypos = 6, prob = 160},
			{ypos = 7, prob = 160},
			{ypos = 8, prob = 160},
			{ypos = 9, prob = 160},
			{ypos = 10, prob = 255},
			{ypos = 11, prob = 255},
			{ypos = 12, prob = 255},
			{ypos = 13, prob = 255},
		}
	}
)

-- <>==============================================================<> --

local luxmushstem	= "wc_fungi:mushroom_stalk_lux"
local luxmushcap	= "wc_fungi:mushroom_cap_lux"
local luxmushgills	= "wc_fungi:mushroom_gills_lux"

local luxroot = {
	".......",
	"..rrr..",
	".rrRrr.",
	".rRRRr.",
	".rrRrr.",
	"..rrr..",
	".......",
}
local luxstem = {
	".......",
	".......",
	".......",
	"...t...",
	".......",
	".......",
	".......",
}
local luxcapbot = {
	".......",
	"..GGG..",
	".GGGGG.",
	".GGtGG.",
	".GGGGG.",
	"..GGG..",
	".......",
}
local luxcaplow = {
	"..ccc..",
	".cgggc.",
	"cgggggc",
	"cggtggc",
	"cgggggc",
	".cgggc.",
	"..ccc..",
}
local luxcaptop = {
	".......",
	"..ccc..",
	".ccccc.",
	".ccccc.",
	".ccccc.",
	"..ccc..",
	".......",
}
nodecore.bigmushroom_lux_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		R = {name = mycelium2, prob = 255, force_place = true},
		r = {name = mycelium1, prob = 100, force_place = true},
		t = {name = luxmushstem, prob = 255, force_place = true},
		c = {name = luxmushcap, prob = 255},
		g = {name = luxmushgills, prob = 255},
		G = {name = luxmushgills, prob = 100},
	},
	{
		luxroot,
		luxroot,
		luxstem,
		luxstem,
		luxstem,
		luxstem,
		luxstem,
		luxstem,
		luxstem,
		luxstem,
		luxcapbot,
		luxcaplow,
		luxcaptop
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 255},
			{ypos = 3, prob = 255},
			{ypos = 4, prob = 160},
			{ypos = 5, prob = 160},
			{ypos = 6, prob = 160},
			{ypos = 7, prob = 160},
			{ypos = 8, prob = 100},
			{ypos = 9, prob = 100},
			{ypos = 10, prob = 255},
			{ypos = 11, prob = 255},
			{ypos = 12, prob = 255},
			{ypos = 13, prob = 255},
		}
	}
)

-- <>==============================================================<> --

local honeystem	= modname.. ":mushroom_stalk_honey"
local honeycap	= modname.. ":mushroom_cap_honey"
local honeygills	= modname.. ":mushroom_gills_honey"

local root = {
	".......",
	"..rrr..",
	".rrRrr.",
	".rRRRr.",
	".rrRrr.",
	"..rrr..",
	".......",
}
local stem = {
	".......",
	".......",
	".......",
	"...t...",
	".......",
	".......",
	".......",
}
local caplow = {
	"..ccc..",
	".cgggc.",
	"cgggggc",
	"cggtggc",
	"cgggggc",
	".cgggc.",
	"..ccc..",
}
local capmid = {
	".......",
	"..ccc..",
	".ccccc.",
	".ccccc.",
	".ccccc.",
	"..ccc..",
	".......",
}
local caphi = {
	".......",
	".......",
	"..ccc..",
	"..ccc..",
	"..ccc..",
	".......",
	".......",
}
nodecore.bigmushroom_honey_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		R = {name = mycelium2, prob = 255, force_place = true},
		r = {name = mycelium1, prob = 100, force_place = true},
		t = {name = honeystem, prob = 255, force_place = true},
		c = {name = honeycap, prob = 255},
		g = {name = honeygills, prob = 255},
	},
	{
		root,
		root,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		caplow,
		capmid,
		caphi
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 255},
			{ypos = 3, prob = 255},
			{ypos = 4, prob = 100},
			{ypos = 5, prob = 100},
			{ypos = 6, prob = 100},
			{ypos = 7, prob = 100},
			{ypos = 8, prob = 100},
			{ypos = 9, prob = 100},
			{ypos = 10, prob = 255},
			{ypos = 11, prob = 255},
			{ypos = 12, prob = 255},
			{ypos = 13, prob = 255},
		}
	}
)
-- <>==============================================================<> --