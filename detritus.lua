-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local mushcap = modname.. "_mushroom_cap.png^[colorize:antiquewhite:160"
local mycelia = modname.. "_mycelium.png"
local logtop = "(nc_tree_tree_top.png^[colorize:black:75)"
local logside = "(nc_tree_tree_side.png^[colorize:black:75)"
local hollow = "(" ..modname.. "_hollow.png)"
local shroom_sound = modname.. "_squishy"
------------------------------------------------------------------------
-- <>==============================================================<> --
minetest.register_node(modname .. ":hyphae", {
	description = "Hyphae",
	drawtype = "normal",
	tiles = {"(" ..mushcap.. ")^(" ..mycelia.. ")"},
	groups = {
		choppy = 1,
		flammable = 2,
		fire_fuel = 4,
		hyphae = 1,
		bouncy = 20,
		fall_damage_add_percent = -20,
		falling_repose = 1,
		detritus = 1,
	},
	crush_damage = 1,
	sounds = nodecore.sounds(shroom_sound)
})
------------------------------------------------------------------------
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
-- <>==============================================================<> --

