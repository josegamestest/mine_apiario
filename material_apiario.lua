minetest.register_craftitem("mine_apiario:nectar", {description ="nectar", inventory_image = "nectar.png",
    groups={not_in_creative_inventory=1},
})

minetest.register_craftitem("mine_apiario:honey", {description ="honey",
    inventory_image = "honey.png",
    groups={food_apple= 1, not_in_creative_inventory=1},
on_use = minetest.item_eat(2),
sounds = default.node_sound_leaves_defaults(),
})


minetest.register_craft({
   output = "mine_apiario:honey",
    recipe = {
              {"mine_apiario:nectar", "mine_apiario:nectar", "mine_apiario:nectar",},
              {"mine_apiario:nectar",  "mine_apiario:nectar", "mine_apiario:nectar",},
              {"mine_apiario:nectar",  "mine_apiario:nectar", "mine_apiario:nectar",},},
})
