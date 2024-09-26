-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- <>==============================================================<> --
local myc1 = modname.. ":mycelium_1"
local myc2 = modname.. ":mycelium_2"
local myc3 = modname.. ":mycelium_3"
local myc4 = modname.. ":mycelium_4"
-- <>==============================================================<> --
local function reg_shroom_schem(id)
------------------------------------------------------------------------
  local mushstem	= modname.. ":mushroom_stalk"
  local mushcap	= modname.. ":mushroom_cap"
  local mushgills	= modname.. ":mushroom_gills"
 ------------------------------------------------------------------------
	local root = {
		".......",
		"..rrr..",
		".rrRrr.",
		".rRRRr.",
		".rrRrr.",
		"..rrr..",
		".......",
	}
	local stalk = {
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
			R = {name = mycelium, prob = 255, force_place = true},
			r = {name = mycelium, prob = 100, force_place = true},
			t = {name = mushstalk, prob = 255, force_place = true},
			c = {name = mushcap, prob = 255},
			g = {name = mushgills, prob = 255},
		},
		{
			root,
			root,
			stalk,
			stalk,
			stalk,
			stalk,
			stalk,
			stalk,
			stalk,
			stalk,
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
end
-- <>==============================================================<> --


