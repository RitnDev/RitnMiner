

local item_brick = util.table.deepcopy(data.raw.item["stone-brick"])
local item_stone_crushed = util.table.deepcopy(data.raw.item["stone-crushed"])
local item_sand = util.table.deepcopy(data.raw.item["silica-sand"])

local icons_stone_brick = {
      {
        icon = item_brick.icon,
        icon_size = item_brick.icon_size,
        icon_mipmaps = item_brick.icon_mipmaps,
      },
      {
        icon = item_stone_crushed.icon,
        icon_size = item_stone_crushed.icon_size,
        icon_mipmaps = item_stone_crushed.icon_mipmaps,
        scale = 16 / item_stone_crushed.icon_size,
        shift = {8, 8}
      },
      {
        icon = item_sand.icon,
        icon_size = item_sand.icon_size,
        icon_mipmaps = item_sand.icon_mipmaps,
        scale = 16 / item_sand.icon_size,
        shift = {-8, 8}
      }
}


data:extend({
        -- stone-brick
        {
            --recipe
            type = "recipe",
            name = "ritn-stone-brick",
            energy_required = 16,
            enabled = false,
            category= "ritn-glass-chemistry",
            icons = icons_stone_brick,
            ingredients =
            {
              {"stone-crushed", 5},
              {"silica-sand", 5},
              {type="fluid", name="water", amount=10}
            },
            result = "stone-brick",
            result_count = 1,
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


