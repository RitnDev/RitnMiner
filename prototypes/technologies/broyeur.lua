data:extend({
    {
        -- Miner MK1
        type = "technology",
        name = "ritn-tech-miner-mk1",
        icon = "__RitnMiner__/graphics/technology/Miner.png",
        icon_size = 100,
        enabled = true,
        effects = {
          {type = "unlock-recipe", recipe = "iron-ore-extraction-0"},
          {type = "unlock-recipe", recipe = "copper-ore-extraction-0"},
          {type = "unlock-recipe", recipe = "miner_mk1"},
        },
          unit = {
          count = 20,
          ingredients = {{"miner-science-pack", 1}},
          time = 10, 
        },
        order = "a-b"
    },
    
    {
        -- Miner MK2
        type = "technology",
        name = "ritn-tech-miner-mk2",
        icon = "__RitnMiner__/graphics/technology/Miner.png",
        icon_size = 100,
        effects = {
          {type = "unlock-recipe", recipe = "miner_mk2"},
        },
        prerequisites = {"automation-2","Improved-iron-ore-extraction-2","Improved-copper-ore-extraction-2"},
        unit = {
          count = 100,
          ingredients = {{"automation-science-pack", 1},{"miner-science-pack", 1},{"logistic-science-pack", 1}},
          time = 30
        },
        order = "a-b"
      },
})