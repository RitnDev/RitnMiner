data:extend({

  -- Shale Oil
  -- Pétrole de Schiste

  {
    --recipe
    type = "recipe",
    name = "shale-oil",
    categories = {"oil-processing"},
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
    order = "a-b[sulfuric-acid]",
    allow_productivity = true
  }


})
