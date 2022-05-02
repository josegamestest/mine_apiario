minetest.register_node("mine_apiario:apiario_box", {
	description = "apiario_box",
	tiles = {"apiario_box_side.png","apiario_box.png","apiario_box_side.png",
             "apiario_box_side.png","apiario_box.png","apiario_box_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	on_construct = function(pos)

on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				default.gui_bg ..
				default.gui_bg_img ..
				default.gui_slots ..
				"list[current_player;mine_apiario:mine_apiario;0,0.35;8,4;]"..
				"list[current_player;main;0,4.85;8,1;]" ..
				"list[current_player;main;0,6.08;8,3;8]" ..
				"listring[current_player;mine_apiario:mine_apiario]" ..
				"listring[current_player;main]" ..
				default.get_hotbar_bg(0,4.85))
end,
minetest.register_on_joinplayer(function(player)
        local inv = player:get_inventory()
        inv:set_size("mine_apiario:mine_apiario", 8*4)
    end)

    })
