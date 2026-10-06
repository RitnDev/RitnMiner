
local RitnProtoItem = require(ritnlib.defines.class.prototype.item)

local icons_stone = RitnProtoItem("stone"):getIconLayers()
for _, layer in pairs(RitnProtoItem("stone-brick"):getIconLayers(0.25, {-8, 8})) do
  table.insert(icons_stone, layer)
end

data:extend({
    -- stone-brick
    {
        --recipe
        type = "recipe",
        name = "ritn-stone",
        energy_required = 16,
        enabled = false,
        subgroup = "ritn-miner",
        categories = {"ritn-crushing"},
        icons = icons_stone,
        ingredients =
        {
          {type="item", name="stone-brick", amount=25},
        },
        results = {{type="item", name="stone", amount=5}},
        order = "a1"
    }

})