
local item_brick = util.table.deepcopy(data.raw.item["stone-brick"])
local item_stone= util.table.deepcopy(data.raw.item["stone"])

local icons_stone = {
      {
        icon = item_stone.icon,
        icon_size = item_stone.icon_size,
        icon_mipmaps = item_stone.icon_mipmaps,
      },
      {
        icon = item_brick.icon,
        icon_size = item_brick.icon_size,
        icon_mipmaps = item_brick.icon_mipmaps,
        scale = 16 / item_brick.icon_size,
        shift = {-8, 8}
      }
}

data:extend({
    -- stone-brick
    {
        --recipe
        type = "recipe",
        name = "ritn-stone",
        energy_required = 16,
        enabled = false,
        subgroup = "ritn-miner",
        category= "ritn-crushing",
        icons = icons_stone,
        ingredients =
        {
          {"stone-brick", 25},
        },
        result = "stone",
        result_count = 5,
        order = "a1"
    }

})