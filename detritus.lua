-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local logtop = "(nc_tree_tree_top.png^[colorize:black:75)"
local logside = "(nc_tree_tree_side.png^[colorize:black:75)"
local hollow = "(" ..modname.. "_hollow.png)"
------------------------------------------------------------------------
-- <>==============================================================<> --
minetest.register_node(modname .. ":decayed_log", {
	description = "Decayed Log",
	drawtype = "normal",
	tiles = {
		"(" ..logtop.. "^" ..hollow.. ")^(" ..modname.. "_mycelium.png^[opacity:75)",
		"(" ..logtop.. "^" ..hollow.. ")^(" ..modname.. "_mycelium.png^[opacity:75)",
		"(" ..logside.. ")^(" ..modname.. "_mycelium.png^[opacity:75)"
	},
	groups = {
		choppy = 2,
		flammable = 6,
		fire_fuel = 6,
		falling_repose = 2,
		detritus = 1,
	},
	crush_damage = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	drop = modname .. ":decayed_log"
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "grind decayed log to peat",
	action = "pummel",
	toolgroups = {crumbly = 4},
	nodes = {
		{
			match = {name = modname .. ":decayed_log"},
			replace = "nc_tree:peat"
		}
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "cut useable wood from decayed log",
	action = "pummel",
	toolgroups = {choppy = 1},
	nodes = {
		{
			match = {name = modname .. ":decayed_log"},
			replace = "nc_woodwork:plank"
		}
	}
})
------------------------------------------------------------------------
-- <>==============================================================<> --

