-- LUALOCALS < ---------------------------------------------------------
local ipairs, math, minetest, nodecore, pairs, table, vector
    = ipairs, math, minetest, nodecore, pairs, table, vector
local math_random, table_shuffle
    = math.random, table.shuffle
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local hashpos = minetest.hash_node_position
local queue = {}
local qsize = 0
local qmax = 100
local dirs = {
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z = -1},
	{x = 0, y = 1, z = 0},
	{x = 0, y = -1, z = 0},
	{x = 1, y = 0, z = 0},
	{x = -1, y = 0, z = 0},
}
--<>----------------------------------------------------------------<>--
nodecore.register_shroom_drops, nodecore.registered_shroom_drops
= nodecore.mkreg()
--<>----------------------------------------------------------------<>--
nodecore.shroom_decay_forced = {}

function nodecore.shroom_decay(pos, node)
	node = node or minetest.get_node(pos)
	local def = minetest.registered_nodes[node.name]
	if def and def.shroom_decay_as then
		for k, v in pairs(def.shroom_decay_as) do
			node[k] = v
		end
	end

	local poskey = hashpos(pos)
	local forced = nodecore.shroom_decay_forced[poskey]
	or minetest.get_meta(pos):get_string("shroom_decay_forced")
	nodecore.shroom_decay_forced[poskey] = nil
	forced = forced and forced ~= "" and minetest.deserialize(forced, true) or nil

	local t = {}
	if forced then
		if not forced[1] then forced = {forced} end
		t = forced
	else
		for _, v in ipairs(nodecore.registered_shroom_drops) do
			t = v(pos, node, t) or t
		end
	end

	local p = nodecore.pickrand(t, function(x) return x.prob or 1 end)
	if not p then return end

	minetest.set_node(pos, p)
	if p.item then nodecore.item_eject(pos, p.item) end

	for i = 1, #dirs do
		local dp = vector.add(pos, dirs[i])
		qsize = qsize + 1
		if qsize > qmax then
			local n = math_random(1, qsize)
			if qsize <= qmax then
				queue[n] = dp
			end
		else
			queue[qsize] = dp
		end
	end

	return nodecore.fallcheck(pos)
end

local cache = {}

local shroom_decay_support = nodecore.group_expand("group:shroom_decay_support", true)
local shroom_decay_transmit = nodecore.group_expand("group:shroom_decay_transmit", true)
local function check_decay(pos, node)
	local hash = hashpos(pos)
	local found = cache[hash]
	if found and minetest.get_node(found).name == found.name then return true end
	return nodecore.scan_flood(pos, 5, function(p)
			local n = minetest.get_node(p).name
			if n == "ignore" or shroom_decay_support[n] then
				while p.prev do
					p.name = minetest.get_node(p).name
					cache[hashpos(p.prev)] = p
					p = p.prev
				end
				return true
			end
			if shroom_decay_transmit[n] then return end
			return false
		end
	) or nodecore.shroom_decay(pos, node)
end

local decaynames = {}
minetest.after(0, function()
		for k, v in pairs(minetest.registered_nodes) do
			if v.groups and v.groups.shroom_decay
			and v.groups.shroom_decay > 0 then
				decaynames[k] = true
			end
		end
	end)

minetest.register_globalstep(function()
		if qsize < 1 then return end
		local batch = queue
		queue = {}
		qsize = 0
		table_shuffle(batch)
		for i = 1, #batch do
			local pos = batch[i]
			local node = minetest.get_node(pos)
			if decaynames[node.name] then
				check_decay(pos, node)
			end
		end
	end)

minetest.register_abm({
		label = "shroomcap decay",
		interval = 2,
		chance = 5,
		nodenames = {"group:shroom_decay"},
		action = check_decay
	})
--<>----------------------------------------------------------------<>--
nodecore.register_shroom_drops(function(_, _, list)
		list[#list + 1] = {name = modname.. ":hyphae", prob = 0.5}
--		list[#list + 1] = {name = modname.. ":mushroom", prob = 0.5}
		list[#list + 1] = {name = "air"}
	end)
