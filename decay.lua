-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================== --

minetest.register_abm({
	label = "log decay",
	interval = 300,
	chance = 20,
	nodenames = {"nc_tree:log"},
	neighbors = {"group:water","group:fungal"},
	action = function(pos, node)
		return minetest.set_node(pos, {name = modname .. ":decayed_log", param2 = node.param2})
	end
})

minetest.register_abm({
	label = "detritus overcome",
	interval = 3600,
	chance = 100,
	nodenames = {"group:detritus"},
	neighbors = {"group:mycelium"},
	action = function(pos, node)
		return minetest.set_node(pos, {name = modname .. ":mycelium_3"})
	end
})