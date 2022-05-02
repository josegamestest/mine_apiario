local flores={{"girassol"},
			{"flor_azul"},
			{"flor_vermelha"},
                  }
for i = 1, #flores, 1 do
minetest.register_node("mine_apiario:"..flores[i][1], {
		description = "mine_apiario:"..flores[i][1],
		drawtype = "plantlike",
		waving = 1,
		tiles = {flores[i][1]..".png"},
		inventory_image = flores[i][1]..".png",
		wield_image = flores[i][1]..".png",
        
		sunlight_propagates = true,
		paramtype = "light",
        sunlight_propagates = true, light_source = 2,
        use_texture_alpha ="clip",
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1,not_in_creative_inventory=0},
		--sounds = default.node_sound_leaves_defaults(),
		selection_box = { type = "fixed",fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},},
})

minetest.register_node("mine_apiario:"..flores[i][1].."_sem_nectar", {

		description = "mine_apiario:"..flores[i][1].."_sem_nectar",
		drawtype = "plantlike",
		waving = 1,
		tiles = {flores[i][1]..".png^[colorize:#FFFFFF70"},
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, flammable = 1, not_in_creative_inventory=1},
		selection_box = { type = "fixed",fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -5 / 16, 6 / 16},},

minetest.register_abm({ nodenames = {"mine_apiario:"..flores[i][1].."_sem_nectar"}, interval = 2, chance = 100,
	action = function(pos) pos.x = pos.x
    minetest.add_particlespawner({
					amount = 10,
					time = 1,
					minpos = {x = pos.x - 0.25, y = pos.y + 0.1, z = pos.z - 0.25},
					maxpos = {x = pos.x + 0.25, y = pos.y + 0.3, z = pos.z + 0.25},
					minvel = {x = -0.5, y = 0, z = -0.5},
					maxvel = {x = 0.5, y = 0.1, z = 0.5},
					minacc = {x = 0, y = 0, z = 5},
					maxacc = {x = 0, y = 5, z = 0},
					minexptime = 1,
					maxexptime = 2,
					minsize = 3,
					maxsize = 2,
					vertical = false,
					collisiondetection = false,
					texture ="nectar.png",
					glow = 5,
				})
			
    minetest.add_node(pos, {name="mine_apiario:"..flores[i][1]})
end,})
})
end
 
