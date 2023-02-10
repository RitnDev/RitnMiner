data:extend({
    {
        --miner-science-pack
          type = "technology",
          name = "miner-science-pack",
          icon = "__core__/graphics/icons/category/resource-editor.png",
          icon_size = 128, icon_mipmaps = 2,
          enabled = false,
          effects = {
            {type = "unlock-recipe", recipe = "iron-ore-extraction-0"},
            {type = "unlock-recipe", recipe = "copper-ore-extraction-0"},
          },
          prerequisites = {},
          unit = {
            count = 10,
            ingredients = {{"miner-science-pack", 1}},
            time = 5
          }
    }
})