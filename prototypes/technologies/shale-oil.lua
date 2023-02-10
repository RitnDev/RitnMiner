data:extend({
    {
      --shale-oil
        type = "technology",
        name = "shale-oil",
        icon = "__RitnMiner__/graphics/technology/shale-oil.png",
        icon_size = 256, icon_mipmaps = 1,
        effects = {
          {type = "unlock-recipe", recipe = "shale-oil"},
        },
        prerequisites = {"oil-processing"},
        unit = {
          count = 200,
          ingredients = {{"automation-science-pack", 1},{"miner-science-pack", 1},{"logistic-science-pack", 1}},
          time = 30
        }
    }
})