-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
-- ================================================================== --
-- Here is where we make small mushrooms grow into tall ones --
------------------------------------------------------------------------
local function shroomgrowth(id, maxlight)
	minetest.register_abm({
		label = "Tallshroom growth",
		nodenames = {modname.. ":mushroom" ..id},
		neighbors = {"group:mycelium"},
		interval = 300,	--300
		chance = 100,		--100
		action = function(pos)
		  local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		  local anode = minetest.get_node(above)
		  local light = nodecore.get_node_light(above)
			if light >= maxlight then return
			end
				if anode.name == "air" then
					nodecore.set_loud(pos, {name = modname.. ":mushroom_tall" ..id})
					nodecore.witness(pos, "tallshroom growth")
				end
		end
	})
end
-- ================================================================== --
shroomgrowth("",		8)
shroomgrowth("_glow",	6)
shroomgrowth("_lux",	4)
-- ================================================================== --

------------------------------------------------------------------------
minetest.register_abm({
	label = "Shroom Growth",
--	nodenames = {groups = {fungal = true}},
	nodenames = {"group:mycelium"},
	interval = 120, --120
	chance = 20, --20
	action = function(pos)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
--		minetest.chat_send_all("action works")
		if not nodecore.buildable_to(above) then
--			minetest.chat_send_all("blocked above")
			return
		end
		local light = nodecore.get_node_light(above)
		if (not light) or light >= 8 then
--			minetest.chat_send_all("wrong light")
			return
		end
		if light >= 4 then
			return nodecore.set_loud(above, {name = modname .. ":mushroom"})
		end
		if #nodecore.find_nodes_around(pos, "group:lux_emit", 2) > 0 then
			return nodecore.set_loud(above, {name = modname .. ":mushroom_lux"})
		end
		return nodecore.set_loud(above, {name = modname .. ":mushroom_glow"})
	end
})

-- Mushroom Growth Humus
minetest.register_abm({
	label = "Mushroom Growth",
	nodenames = {"nc_tree:humus"},
	neighbors = {"group:moist"},
	interval = 900, --900
	chance = 100, --100
	action = function(pos)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
--		minetest.chat_send_all("action works")
		if not nodecore.buildable_to(above) then
--			minetest.chat_send_all("blocked above")
			return
		end
		local light = nodecore.get_node_light(above)
		if (not light) or light >= 6 then
--			minetest.chat_send_all("wrong light")
			return
		end
		return nodecore.set_loud(above, {name = modname .. ":mushroom"})
	end
})
-- ================================================================== --

-- ================================================================== --
--[[local function giantgrowth(id)
	minetest.register_abm({
		label = "Giant growth",
		nodenames = {modname.. ":mushroom_tall" ..id},
		neighbors = {modname.. ":mycelium_4"},
		interval = 6,	--600
		chance = 1,		--100
		action = function(pos)
		  for i = 1, 7 do
			local above = {x = pos.x, y = pos.y + i, z = pos.z}
			local anode = minetest.get_node(above)
				if anode.name == "air" then
					minetest.place_schematic(pos, {"nodecore.bigmushroom" ..id.. "_schematic"}, "place_center_x, place_center_z", "random")
				end
		  end		
		end
	})
end
-- ================================================================== --
giantgrowth("",		)
giantgrowth("_glow",	)
giantgrowth("_lux",	)]]