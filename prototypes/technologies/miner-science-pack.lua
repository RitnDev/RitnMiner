data:extend({
  {
    --miner-science-pack
    type = "technology",
    name = "miner-science-pack",
    icon = "__RitnMiner__/graphics/technology/miner-science-pack.png",
    icon_size = 128,
    effects = {
      { type = "unlock-recipe", recipe = "miner-science-pack" },
      { type = "unlock-recipe", recipe = "stone-processing" },
      { type = "unlock-recipe", recipe = "iron-plate" },
      { type = "unlock-recipe", recipe = "copper-plate" },
      { type = "unlock-recipe", recipe = "iron-gear-wheel" },
      { type = "unlock-recipe", recipe = "burner-inserter" },
      { type = "unlock-recipe", recipe = "transport-belt" },
      { type = "unlock-recipe", recipe = "burner-mining-drill" },
      { type = "unlock-recipe", recipe = "iron-chest" },
    },
    research_trigger = {
      type = "craft-item",
      item = "stone-brick",
      count = 100
    },
    order = "a-a"
  }
})
