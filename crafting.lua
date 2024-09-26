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
		{y = -1, match = "group:dirt", replace = modname.. ":mycelium_1"},
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
			replace = {name = modname.. ":mycelium_1"}
		}
	}
})
------------------------------------------------------------------------

------------------------------------------------------------------------