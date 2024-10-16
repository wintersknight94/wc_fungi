-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
------------------------------------------------------------------------
nodecore.register_craft({
	label = "grind giant mushrooms to compost",
	action = "pummel",
	toolgroups = {crumbly = 2},
	indexkeys = {"group:mushblock"},
	nodes = {
		{match = {groups = {mushblock = true}, replace = "air"}},
		{y = -1, match = "group:dirt", replace = modname.. ":mycelium_1_loose"},
	}
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "grind small fungi to compost",
	action = "pummel",
	toolgroups = {crumbly = 2},
	indexkeys = {"group:fungi"},
	nodes = {
		{
			match = {groups = {fungi = true}, count = 8},
			replace = {name = modname.. ":mycelium_1_loose"}
		}
	}
})
------------------------------------------------------------------------
------------------------------------------------------------------------
nodecore.register_craft({
	label = "grind detritus to compost",
	action = "pummel",
	toolgroups = {crumbly = 3},
	nodes = {
		{
			match = {groups = {detritus = true}},
			replace =  {name = modname.. ":mycelium_1_loose"}
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
------------------------------------------------------------------------