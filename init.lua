 -- LUALOCALS < ---------------------------------------------------------
local include, minetest, nodecore
    = include, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
--<>-----<> ================================================ <>-----<>--

include("mycelium")

include("mushrooms")

include("detritus")

if minetest.settings:get_bool(modname .. ".mushroom_bricks", true) then
	include("bricks")
end

include("crafting")

include("growth")

--include("schematics")

--include("decor")

include("decay")

--include("network")

--include("myconids")

include("conversion")