

local RitnProtoItem = require(ritnlib.defines.class.prototype.item)

local icons_stone_brick = RitnProtoItem("stone-brick"):getIconLayers()
for _, layer in pairs(RitnProtoItem("stone-crushed"):getIconLayers(0.25, {8, 8})) do
  table.insert(icons_stone_brick, layer)
end
for _, layer in pairs(RitnProtoItem("silica-sand"):getIconLayers(0.25, {-8, 8})) do
  table.insert(icons_stone_brick, layer)
end


data:extend({
        -- stone-brick
        {
            --recipe
            type = "recipe",
            name = "ritn-stone-brick",
            energy_required = 16,
            enabled = false,
            categories = {"ritn-glass-chemistry"},
            icons = icons_stone_brick,
            ingredients =
            {
              {type="item", name="stone-crushed", amount=5},
              {type="item", name="silica-sand", amount=5},
              {type="fluid", name="water", amount=10}
            },
            results = {{type="item", name="stone-brick", amount=1}},
            crafting_machine_tint = 
            {
                primary = {r = 0.682, g = 0.624, b = 0.486, a = 1.000},
                secondary = {r = 0.116, g = 0.116, b = 0.116, a = 1.000},
                tertiary = {r = 0.682, g = 0.624, b = 0.486, a = 1.000},
                quaternary = {r = 0.17, g = 0.17, b = 0.17, a = 1.000},
            },
            order = "a[stone-process]-a"
        }

})


