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
			mycelium = i,
			moist = 1		--this is only here so that is automatically boosts most plantlife, including modded
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
		interval = 300,
		chance = 100,
		action = function(pos)
		 local n = i+1
			if n == 5 then return end
			if #nodecore.find_nodes_around(pos, modname.. ":mycelium_" ..i, 1) >= 8 then
				nodecore.set_loud(pos, {name = modname.. ":mycelium_" ..n})
			end
		end
	})
end
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

-- ================================================================== --
nodecore.register_abm({
	label = "Mycelium 1 Growth",
	nodenames = {"group:dirt", "group:mud"},
	neighbors = {modname.. ":mycelium_1"},
	neighbors_invert = true,
	interval = 300,
	chance = 100,
	action = function(pos)
		nodecore.set_loud(pos, {name = modname.. ":mycelium_1"})
	end
})

