-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local dirt = "nc_terrain_dirt.png"
local humus = "nc_tree_humus.png"
local hyphae = modname.. "_mycelium.png"
-- ================================================================== --
for i = 1, 4 do
 local density = i*64
 local mycelium = humus .."^(" ..hyphae.."^[opacity:" ..density.. ")"
	minetest.register_node(modname .. ":mycelium_" ..i, {
		description = "Mycelium",
		tiles = {mycelium},
		groups = {
			crumbly = 1,
			soil = i+3,
			fungal = 1,
			mycelium = i
		},
		alternate_loose = {
			tiles = {"(" ..mycelium.. ")^nc_api_loose.png"},
			groups = {
				crumbly = 1,
				soil = i+2,		--mycelium is less beneficial when loose
				fungal = 1,
				mycelium = i-1,
				mycelium_loose = 1,
				falling_repose = 2,
			}
		},
		sounds = nodecore.sounds("nc_terrain_chompy")
	})
	nodecore.register_abm({
		label = "Mycelium Establishment",
		nodenames = {modname.. ":mycelium_" ..i},
		neighbors = {modname.. ":mycelium_" ..i},
		interval = 1200,
		chance = 100,
		action = function(pos)
		 local n = i+1
			if n == 5 then return end
			if #nodecore.find_nodes_around(pos, modname.. ":mycelium_" ..i, 1) >= 8 then
				minetest.set_node(pos, {name = modname.. ":mycelium_" ..n})
			end
		end
	})
	nodecore.register_aism({
		label = "mycelium stack dying",
		interval = 60,
		chance = 10,
		arealoaded = 2,
		itemnames = {modname.. ":mycelium_" ..i},
		action = function(stack, data)
			if data.toteslot then return end
			if i == 1 then return end
			if data.player and data.list then
				local inv = data.player:get_inventory()
				for i = 1, inv:get_size(data.list) do
					local item = inv:get_stack(data.list, i):get_name()
					if minetest.get_item_group(item, "moist") > 0 then return end
				end
			end
			if #nodecore.find_nodes_around(data.pos, "group:moist", 2) > 0 then return end
			nodecore.sound_play("nc_terrain_chompy", {pos = data.pos})
			local taken = stack:take_item(1)
			local n = i-1
			taken:set_name(modname.. ":mycelium_" ..n)
			if data.inv then taken = data.inv:add_item("main", taken) end
			if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
			return stack
		end
	})
end
-- ================================================================== --
nodecore.register_abm({
	label = "Mycelium Growth",
	nodenames = {"group:dirt", "group:mud"},
	neighbors = {"group:mycelium"},
	neighbors_invert = true,
	interval = 1200,
	chance = 100,
	action = function(pos)
	  local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if nodecore.is_full_sun(above) then return end
		minetest.set_node(pos, {name = modname.. ":mycelium_1"})
	end
})
-- ================================================================== --

-- Ok, so lets think about this. mycelium should slowly spread, and should get a boost when it is near a rotting thing or tree,
-- and trees and plants should get a boost from the mycelium, which should be automatically handled by the soil fertility api
-- through the 'mycelium' and 'fungal' groups. it should only die in the presence of extreme heat, though the less 
-- established mycelium can be overrun by grass, and its growth halted by too much light. Rotting things can become mycelium
-- unless they are exposed to extreme heat or light.
 
-- Mycelium should become more established if there are >=8 mycelium of its level around it.
-- Mycelium should become less establshed if there is no soil around it, or too much light or heat.

-- The different levels should behave differently, or else there is no point in them.
-- level 1 can only spread to dirt and mud, and only in the presence on moisture, and only in darkness
-- level 2 can spread in darkness without moisture, or in dim light with moisture
-- level 3 can spread to rotting things in dim light 
-- level 4 can spread to grass in the presence of stumps or rotting things
