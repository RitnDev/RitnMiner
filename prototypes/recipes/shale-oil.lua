data:extend({

  -- Shale Oil
  -- Pétrole de Schiste

  {
    --recipe
    type = "recipe",
    name = "shale-oil",
    category = "oil-processing",
    subgroup = "fluid-recipes",
    energy_required = 5,
    enabled = false,
    ingredients =
    {
        {type="item", name="stone", amount=10},
        {type="fluid", name="water", amount=25},
        {type="fluid", name="steam", amount=50}
    },
    results=
    {
      {type="fluid", name="heavy-oil", amount=20},
      {type="fluid", name="light-oil", amount=90},
      {type="fluid", name="petroleum-gas", amount=10}
    },
    icon = "__RitnMiner__/graphics/icons/shale-oil.png",
    icon_size = 64,
    icon_mipmaps = 1,
    order = "a-b[sulfuric-acid]",
    allowed_effects = {productivity}
  }


})

local limitation1 = data.raw.module["productivity-module"].limitation
local limitation2 = data.raw.module["productivity-module-2"].limitation
local limitation3 = data.raw.module["productivity-module-3"].limitation

table.insert(limitation1,"shale-oil")
table.insert(limitation2,"shale-oil")
table.insert(limitation3,"shale-oil")