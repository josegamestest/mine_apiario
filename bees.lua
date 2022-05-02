if mobs.mod and mobs.mod == "redo" then
mobs:register_mob("mine_apiario:bee", {
    type = "npc",	attack_type = "dogfight",	
	group_attack = true,	passive = true,	attack_monsters = false,	gotten = false,
	attack_players = false,	pushable=false,	jump = false,	makes_footstep_sound = true,
	knock_back =false,
	fear_height = 1,	floats = 1,
	--jump_height = 0,
	view_range = 5,	damage = 4,
	reach = 3,			suffocation = 5,
    hp_min = 5, hp_max = 5,	armor = 200,
    walk_chance =50,  stand_chance=50, run_velocity = 1,
    blood_amount = 0,
	lava_damage = 5,
	visual = "mesh",
    mesh = "bee.b3d",
    collisionbox = {-0.3,-0.00,-0.30, 0.3,0.5,0.3},	
    collisionbox = {-0.3, 0.00, -0.3, 0.3, 0.5,0.3},
    --visual_size = {x = 4.50,y =4.50},
	textures = {"bee.png"},
	replace_rate=1,
    tame=true,
	nectar="0",
	animation = {
		speed_normal = 20, 	speed_run = 30,
		stand1_start = 0,  	stand1_end = 20,
        stand2_start = 20,  stand2_end = 40,
		walk_start = 0,  	walk_end = 20,
        run_start = 0,   	run_end = 20,
		punch_start = 189,	punch_end = 198,
        die_start = 20,  	die_end = 40,
        die_loop = false, },
        
    replace_what = {{"mine_apiario:girassol", "mine_apiario:girassol_sem_nectar", 0},
                    {"mine_apiario:flor_azul", "mine_apiario:flor_azul_sem_nectar", 0},
                    {"mine_apiario:flor_vermelha", "mine_apiario:flor_vermelha_sem_nectar", 0},},

do_punch = function(self, hitter)
        if hitter then return false end end,

on_rightclick = function(self, clicker,rot,jogador,pos)
		local ent = self.object:get_luaentity()
        jogador=clicker:get_player_name()
		
		if jogador == self.owner then
			local inv = clicker:get_inventory()
			local tool = clicker:get_wielded_item()
			local item = tool:get_name()
			
			if ent.nectar >=2 then
				ent.nectar=ent.nectar -1  
				self.nametag=ent.nectar.." de nectar"
				inv:add_item("main", "mine_apiario:nectar")
				minetest.sound_play("bee_1", {pos = pos, gain = 0.5, max_hear_distance = 3, loop = false })
			else
				--minetest.chat_send_all("nao tenho mel soficiente "..ent.nectar.."")
				minetest.sound_play("bee_2", {pos = pos, gain = 0.5, max_hear_distance = 3, loop = false })
			end
		else
				minetest.sound_play("bee_3", {pos = pos, gain = 0.5, max_hear_distance = 3, loop = false })
    end 
    if mobs:capture_mob(self, clicker, nil, nil, 100, false, nil) then return end
    

end,

do_custom = function(self, dtime)
		local ent = self.object:get_luaentity()
		if ent.nectar== nil then ent.nectar=1 end
        if ent.nectar < 100 then  self.replace_rate = 1 end
		if ent.nectar >= 100 then self.replace_rate = 100 end
	   end,
--after_activate = function(self, staticdata, def, dtime) ent.nectar=1 end,
on_replace = function(self, pos, oldnode, newnode)
		local ent = self.object:get_luaentity()
        nome=self.owner
        self.nectar=ent.nectar+1
        
end,

minetest.register_on_joinplayer(function(player)
         local inv = player:get_inventory()
        inv:set_size("mine_apiario:mine_apiario", 8*4)
        --player:get_inventory():add_item("mine_apiario:mine_apiario", "mine_apiario:bee")
    end)

})

mobs:register_egg("mine_apiario:bee", "bee", "bee_icon.png",0)
end
