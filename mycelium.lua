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
			moist = 1
		},
		alternate_loose = {
			tiles = {"(" ..mycelium.. ")^nc_api_loose.png"},
			groups = {
				crumbly = 1,
				soil = i+2,
				fungal = 1,
				mycelium = i-1,
				dirt_loose = 2,
				falling_repose = 2,
			}
		},
		sounds = nodecore.sounds("nc_terrain_chompy")
	})
end
-- ================================================================== --
