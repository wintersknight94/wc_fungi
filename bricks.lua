-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local shroom_sound = "nc_tree_woody"
------------------------------------------------------------------------
local brickgap = "nc_stonework_bricks.png^[opacity:200"
local brckmask = "wc_lib_resources_mask_bricks.png"
-- ================================================================== --
local function mushroom_bricks(desc, capcolor, stalkcolor, suff, light)
 local mycota = modname .. "_mushroom_cap.png^[colorize:" ..capcolor
 local hyphae = modname .. "_mushroom_cap.png^[colorize:" ..stalkcolor
 local fbrick = mycota.. "^[mask:" ..brckmask
 local name = desc:lower()
------------------------------------------------------------------------
	minetest.register_node(modname .. ":bricks" ..suff, {
		description = (desc.. " Bricks"),
		tiles = {mycota.. "^(" ..brickgap.. ")"},
		groups = {
			choppy = 2,
			shroom_bricks = 1,
			lux_absorb = 42,
			flammable = 32,
			bouncy = 32,
			fall_damage_add_percent = -32
		},
--		light_source = light,
		glow = light,
		crush_damage = 1,
		sounds = nodecore.sounds(shroom_sound)
	})
------------------------------------------------------------------------
	minetest.register_node(modname .. ":bricks" ..suff.. "_bonded", {
		description = "Bonded " .. desc .. " Bricks",
		tiles = {"(" ..hyphae.. ")^(" ..fbrick.. ")"},
		groups = {
			choppy = 3,
			shroom_bricks = 2,
			shroom_bonded = 1,
			lux_absorb = 48,
			flammable = 38,
			bouncy = 24,
			fall_damage_add_percent = -24
		},
		light_source = light,
		glow = light,
		crush_damage = 1,
		drop_in_place = modname .. ":bricks" ..suff,
		sounds = nodecore.sounds(shroom_sound),		
	})
------------------------------------------------------------------------
	minetest.register_abm({
		label = "Mushroom Brick Bonding",
		nodenames = {modname .. ":bricks" ..suff},
		neighbors = {"group:moist", "group:mycelium", "group:shroom_bonded"},
		interval = 120, --120
		chance = 20, --20
		action = function(pos)
			local light = nodecore.get_node_light(pos)
			if (not light) or light >= 6 then
--				minetest.chat_send_all("wrong light")
				return
			end
			return nodecore.set_loud(pos, {name = modname .. ":bricks" ..suff.. "_bonded"})
		end
	})
------------------------------------------------------------------------
	nodecore.register_craft({
		label = "Chisel " ..desc.. " Bricks",
		action = "pummel",
		duration = 2,
		toolgroups = {thumpy = 2},
		normal = {y = 1},
		indexkeys = {"group:chisel"},
		nodes = {
			{
			match = {
				lode_temper_cool = true,
				groups = {chisel = true}
				},
			dig = true
			},
			{
				y = -1,
				match = modname .. ":mushroom_cap" ..suff,
				replace = modname .. ":bricks" ..suff
			}
		}
	})
------------------------------------------------------------------------
end
-- ================================================================== --
mushroom_bricks("Mushroom",		"#cb410b:180",	"#e3dac9:100",	"",			nil)
mushroom_bricks("Honeycap",		"#daa520:180",	"#faebd7:100",	"_honey",	nil)
mushroom_bricks("Glowshroom",	"#0892d0:120",	"WHITE:140",	"_glow",	1)	
mushroom_bricks("Luxaeterna",	"#664c28:180",	"#009e60:140",	"_lux",		1)

if minetest.settings:get_bool(modname .. ".extrashrooms", true) then
	mushroom_bricks("Gloomshroom",		"#2f4f4f:160",	"#4682b4:160",	"_gloom",	1)
	mushroom_bricks("Violet liar",		"#9932cc:180",	"#9370db:160",	"_liar",	nil)
	mushroom_bricks("Devil's bulb",		"#fff8dc:160",	"#800000:200",	"_satan",	nil)
	mushroom_bricks("Azure Pinkgill",	"#0000cd:160",	"#4682b4:200",	"_azure",	nil)
	mushroom_bricks("Astralcap",		"#5f9ea0:180",	"#009e60:140",	"_star",	1)
	mushroom_bricks("Mushwort",			"#664c28:180",	"#008080:140",	"_wart",	nil)
	mushroom_bricks("Stonecap",			"#2f4f4f:180",	"#5f9ea0:100",	"_stone",	nil)
end