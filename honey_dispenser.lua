local nectar = "mine_apiario:nectar"
local honey = "mine_apiario:honey"
local furnace_inactive_formspec ="formspec_version[5] size[14,10]"..

	"label[5,0.6;use:"..nectar.."]"..	
	"label[5.5,2.1;input]"..
	"list[current_name;nectar;5.4,2.6;1,1;0]"..
	"label[7.9,2.1;honey]"..
	"list[current_name;honey;7.7,2.6;1,1;0]"..
	"list[current_player;main;2.2,8.3;8,1;1]"..
	"list[current_player;main;2.2,4.3;8,3;0]"
	
minetest.register_node("mine_apiario:honey_dispenser", {
	description = "honey_dispenser",
	visual_size = {x = 1,y = 1},
	drawtype = "mesh",
	mesh = "honey_dispenser.obj",
    tiles = {"honey_dispenser.png"},
	legacy_facedir_simple = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {	snappy=1, choppy=2, flammable=3, oddly_breakable_by_hand=2, not_in_creative_inventory=0},

	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", furnace_inactive_formspec)
		meta:set_string("infotext", "mine_apiario")
		local inv = meta:get_inventory()
		inv:set_size("nectar", 1)

		local inv2 = meta:get_inventory()
		inv2:set_size("honey", 1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		local inv2 = meta:get_inventory()
		if not inv:is_empty("nectar") then return false end
		if not inv2:is_empty("honey") then return false end
		return true end,
})

minetest.register_node("mine_apiario:honey_dispenser_active", {
	description = "honey_dispenser_active",
	visual_size = {x = 1,y = 1},
    drawtype = "mesh",
	mesh = "honey_dispenser.obj",
    tiles = {"honey_dispenser.png"},
	--legacy_facedir_simple = true,
	paramtype = "light",

	paramtype2 = "facedir",
	light_source = 13,
	drop = "mine_apiario:honey_dispenser",
	groups = {	snappy=1, choppy=2, flammable=3, oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	--legacy_facedir_simple = true,
	--sounds = default.node_sound_stone_defaults(),

	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		meta:set_string("formspec", furnace_inactive_formspec)
		meta:set_string("infotext", "honey dispenser active")
		local inv = meta:get_inventory()
		inv:set_size("nectar", 1)
		local inv2 = meta:get_inventory()
		inv2:set_size("honey", 1)
	end,

	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory()
		local inv2 = meta:get_inventory()
		if not inv:is_empty("nectar") then return false end
		if not inv2:is_empty("honey") then return false end
		return true end,
})

function hacky_swap_node(pos,name)
	local node = minetest.env:get_node(pos)
	local meta = minetest.env:get_meta(pos)
	local meta0 = meta:to_table()
	if node.name == name then
		return
	end
	node.name = name
	local meta0 = meta:to_table()
	minetest.env:set_node(pos,node)
	meta = minetest.env:get_meta(pos)
	meta:from_table(meta0)
end

minetest.register_abm({
	nodenames = {"mine_apiario:honey_dispenser","mine_apiario:honey_dispenser_active"},
	interval =1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack("nectar",1)
		if stack:get_name() == nectar then
			inv:remove_item("nectar",ItemStack(nectar))
			inv:add_item("honey",ItemStack(honey))
			meta:set_int("Total",meta:get_int("Total")+1)
			meta:set_string("formspec", furnace_inactive_formspec.."label[4.5,1.5;Total: "..meta:get_int("Total"))
		end
	end,
})
