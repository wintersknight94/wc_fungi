-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local shroom_sound = modname.. "_squishy"
local form = "nc_tree_tree_side.png^[mask:nc_api_storebox_frame.png"
-- ================================================================== --
local function register_shroom(suff, desc, caplight, stalklight, gillight, capcolor, stalkcolor, gillcolor)
  local shroom = "(" ..modname.. "_mask_cap.png^[colorize:" ..capcolor.. ")^(" ..modname.. "_mask_stalk.png^[colorize:" ..stalkcolor.. ")^(" ..modname.. "_mask_gills.png^[colorize:" ..gillcolor.. ")"
  local tallshroom =  "(" ..modname.. "_mask_tallcap.png^[colorize:" ..capcolor.. ")^(" ..modname.. "_mask_tallstalk.png^[colorize:" ..stalkcolor.. ")^(" ..modname.. "_mask_tallgills.png^[colorize:" ..gillcolor.. ")"
  local capmat = modname.. "_mushroom_cap.png^[colorize:" ..capcolor
  local stalkmat = modname.. "_mushroom_cap.png^[colorize:" ..stalkcolor
  local hyphae = stalkmat.. "^[mask:nc_concrete_pattern_vermy.png" 
--local form = stalkmat.. "^[mask:nc_api_storebox_frame.png"
--local shelf = "(" ..capmat.. ")^(" ..form.. ")"
  local shelf = "((" ..capmat.. ")^(" ..hyphae.. "))^(" ..form.. ")"
  local smask = modname.. "_mask_shelf_inv.png"
  local shminv = capmat.. "^[mask:" ..smask
	minetest.register_node(modname.. ":mushroom" ..suff, {
			description = desc,
			drawtype = 'plantlike',
--			waving = 1,
			tiles = {shroom},
			inventory_image = shroom,
			wield_image = shroom,
			sunlight_propagates = true,
			paramtype = 'light',
			paramtype2 = "meshoptions",
			place_param2 = 10,
			light_source = stalklight,
			walkable = false,
			groups = {
				snappy = 1,
				fungi = 2,
				flammable = 1,
				attached_node = 1,
				mushroom_agaric = 1,
			},
			sounds = nodecore.sounds(shroom_sound),
			selection_box = {
				type = "fixed",
				fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
			},
--			[modname .. "_spread_max_light"] = growlit
		})
------------------------------------------------------------------------
	minetest.register_node(modname.. ":mushroom_tall" ..suff, {
		description = desc,
		drawtype = 'plantlike',
--		waving = 1,
		tiles = {tallshroom},
		visual_scale = 1.75,
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "meshoptions",
		place_param2 = 10,
		light_source = stalklight,
		walkable = false,
		groups = {
			snappy = 1,
			fungi = 2,
			flammable = 1,
			attached_node = 1,
			mushroom_tall = 1,

		},
		sounds = nodecore.sounds(shroom_sound),
		on_dig = function(pos)
			local yield = math.random(0,4)
			minetest.set_node(pos, {name = "air"})
			nodecore.item_eject(pos, {name = modname.. ":mushroom" ..suff}, 1, yield)
		end
	})
------------------------------------------------------------------------
	minetest.register_node(modname.. ":mushroom_shelf" ..suff, {
			description = desc,
			drawtype = 'nodebox',
			tiles = {modname .. "_mushroom_cap.png^[colorize:" ..capcolor},
			inventory_image = shminv,
			wield_image = shminv,
			sunlight_propagates = true,
			paramtype = 'light',
			paramtype2 = "wallmounted",
			light_source = stalklight,
			walkable = false,
			climbable = true,
			groups = {
				snappy = 1,
				fungi = 2,
				flammable = 1,
				attached_node = 1,
				mushroom_shelf = 1,
			},
			node_box = {
				type = "fixed",
				fixed = {
					{-0.3125, -0.5, 0.25, 0.0625, -0.375, 0.3125}, -- NodeBox6
					{-0.1875, -0.5, -0.0625, 0.3125, -0.25, 0}, -- NodeBox7
					{-0.3125, -0.5, -0.375, 0.3125, -0.1875, -0.3125}, -- NodeBox8
					{-0.375, -0.5, -0.375, 0.375, -0.3125, -0.3125}, -- NodeBox9
					{-0.1875, -0.5, -0.375, 0.1875, -0.125, -0.3125}, -- NodeBox10
					{-0.375, -0.5, 0.25, 0.125, -0.4375, 0.3125}, -- NodeBox11
					{-0.25, -0.5, 0.25, 0, -0.3125, 0.3125}, -- NodeBox12
					{-0.25, -0.5, -0.0625, 0.375, -0.375, 0}, -- NodeBox13
					{-0.0625, -0.5, -0.0625, 0.1875, -0.1875, 0}, -- NodeBox14
				}
			},
			selection_box = nodecore.fixedbox(-6/16, -1/2, -6/16, 6/16, -1/8, 6/16),
			sounds = nodecore.sounds(shroom_sound),
--			[modname .. "_spread_max_light"] = growlit
		})
------------------------------------------------------------------------
	minetest.register_node(modname.. ":mushroom_cap" ..suff, {
		description = desc,
		tiles = {capmat},
		groups = {
			choppy = 1,
			flammable = 2,
			fire_fuel = 4,
			mushblock = 1,
			bouncy = 20,
			fall_damage_add_percent = -20,
		},
		sounds = nodecore.sounds(shroom_sound),
		light_source = caplight
	})
------------------------------------------------------------------------
	minetest.register_node(modname.. ":mushroom_stalk" ..suff, {
		description = desc,
		tiles = {
			modname .. "_mushroom_stem_top.png^[colorize:" ..stalkcolor,
			modname .. "_mushroom_stem_top.png^[colorize:" ..stalkcolor,
			modname .. "_mushroom_stem.png^[colorize:" ..stalkcolor
		},
		groups = {
			choppy = 1,
			flammable = 2,
			fire_fuel = 4,
			mushblock = 1,
			bouncy = 10,
			fall_damage_add_percent = -10,
		},
		paramtype2 = "facedir",
		on_place = minetest.rotate_node,
		sounds = nodecore.sounds(shroom_sound),
		light_source = stalklight
	})
------------------------------------------------------------------------
	minetest.register_node(modname.. ":mushroom_gills" ..suff, {
		description = desc,
		tiles = {modname .. "_mushroom_gills.png^[colorize:" ..gillcolor},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		groups = {
			snappy = 1,
			flammable = 2,
			fire_fuel = 4,
			attached_node = 1,
			mushgills = 1
		},
		waving = 1,
		walkable = false,
		sounds = nodecore.sounds("nc_terrain_swishy"),
		light_source = gillight
	})
------------------------------------------------------------------------
------------------------------------------------------------------------
	if minetest.settings:get_bool(modname .. ".shroomshelves", true) then
		minetest.register_node(modname.. ":shelf" ..suff, {
			description = desc.. " Shelf",
			tiles = {form, shelf},
			selection_box = nodecore.fixedbox(),
			collision_box = nodecore.fixedbox(),
			groups = {
				choppy = 2,
				visinv = 1,
				flammable = 2,
				fire_fuel = 4,
				storebox = 1,
				totable = 1,
				scaling_time = 50
			},
			paramtype = "light",
			sounds = nodecore.sounds(shroom_sound),
			light_source = caplight,
			storebox_access = function(pt) return pt.above.y == pt.under.y end,
			on_ignite = function(pos)
				if minetest.get_node(pos).name == modname .. ":shelf" ..suff then
					return nodecore.stack_get(pos)
				end
			end
		})
		nodecore.register_craft({
			label = "assemble " ..desc.. " shelf",
			action = "stackapply",
			indexkeys = {"nc_woodwork:form"},
			wield = {name = modname.. ":mushroom_shelf" ..suff},
			consumewield = 1,
			nodes = {
				{
					match = {name = "nc_woodwork:form", empty = true},
					replace = modname .. ":shelf" ..suff
				},
			}
		})
	end
------------------------------------------------------------------------
------------------------------------------------------------------------
end
-- ===================================================================================================================== --
-- register_shroom(suff, desc, caplight, stalklight, gillight, capcolor, stalkcolor, gillcolor)
-- ===================================================================================================================== --
register_shroom("", 			"Mushroom",		nil,	nil,	nil,	"#cb410b:180",	"#e3dac9:100",	"WHITE:100")
register_shroom("_glow",		"Glowshroom",	2,		2,		3,		"#0892d0:120",	"WHITE:140",	"#f0f8ff:100")	
register_shroom("_lux",			"Luxaeterna",	1,		4,		5,		"#664c28:180",	"#009e60:140",	"#b2ec5d:100")
---------------------------------------------------------------------------------------------------------------------------
if minetest.settings:get_bool(modname .. ".extrashrooms", true) then
	register_shroom("_gloom",	"Gloomshroom",		1,		1,		6,		"#2f4f4f:160",	"#4682b4:160",	"#b2ec5d:160")
	register_shroom("_liar",	"Violet Liar",		nil,	nil,	nil,	"#9932cc:180",	"#9370db:160",	"#9370db:100")
	register_shroom("_satan", 	"Devil's Bulb",		nil,	nil,	nil,	"#fff8dc:160",	"#800000:200",	"#800000:128")
	register_shroom("_azure",	"Azure Pinkgill",	nil,	1,		2,		"#0000cd:160",	"#4682b4:200",	"#9932cc:100")
	register_shroom("_star",	"Astralcap",		3,		1,		2,		"#5f9ea0:180",	"#009e60:140",	"#9932cc:100")
	register_shroom("_wart",	"Mushwort",			nil,	nil,	nil,	"#664c28:180",	"#008080:140",	"#cb410b:180")
	register_shroom("_stone",	"Stonecap",			nil,	nil,	nil,	"#2f4f4f:180",	"#5f9ea0:100",	"#cb410b:180")
	register_shroom("_honey",	"Honeycap",			1,		nil,	nil,	"#daa520:180",	"#faebd7:100",	"#fafad2:180")
end
---------------------------------------------------------------------------------------------------------------------------
--lodespindle
--pumcradle
