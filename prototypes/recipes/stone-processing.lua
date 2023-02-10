data:extend(
{

  -- Stone Processing

  {
    --recipe
    type = "recipe",
    name = "stone-processing",
    category = "crafting",
    subgroup = "ritn-miner",
    energy_required = 1.5,
    enabled = true,
    ingredients =
    {
      {"stone", 5}
    },
    results=
    {
      {type="item", name="iron-ore", amount=1},
      {type="item", name="copper-ore", amount=1},
      {type="item", name="stone", amount=2}
    },
    icon = "__RitnMiner__/graphics/icons/stone-processing.png",
    icon_size = 128,
    order = "a"
  }


}
)