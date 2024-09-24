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
 
	minetest.register_node(modname .. ":bricks" ..suff, {
		description = (desc.. " Bricks"),
		tiles = {mycota.. "^(" ..brickgap.. ")"},
		groups = {
			choppy = 1,
			shroom_bricks = 1,
			lux_absorb = 42,
			flammable = 32,
			bouncy = 15,
			fall_damage_add_percent = -15
		},
--		light_source = light,
		glow = light,
		crush_damage = 1,
		sounds = nodecore.sounds(shroom_sound)
	})
	minetest.register_node(":" .. modname .. ":bricks" ..suff.. "_bonded", {
		description = "Bonded " .. desc .. " Bricks",
		tiles = {"(" ..hyphae.. ")^(" ..fbrick.. ")"},
		groups = {
			choppy = 2,
			shroom_bricks = 2,
			lux_absorb = 48,
			flammable = 38,
			bouncy = 16,
			fall_damage_add_percent = -16
		},
		light_source = light,
		glow = light,
		crush_damage = 1,
		sounds = nodecore.sounds(shroom_sound),
	})
end
-- ================================================================== --
mushroom_bricks("Mushroom",		"#cb410b:180",	"#e3dac9:100",	"",			nil)
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