
data:extend(
    {
        --Miner Science Pack
        {
            --item (tool)
            type = "tool",
            name = "miner-science-pack",
            icon = "__RitnMiner__/graphics/icons/miner-science-pack.png",
            icon_size = 64,
            subgroup = "science-pack",
            order = "a-a-b",
            stack_size = 200,
            durability = 1
        },
        {
            --recipe
            type = "recipe",
            name = "miner-science-pack",
            energy_required = 8,
            enabled = false,
            ingredients =
            {
              {type="item", name="stone-brick", amount=4},
              {type="item", name="burner-mining-drill", amount=1}
            },
            results = {{type="item", name="miner-science-pack", amount=2}},
            allow_productivity = true,
            crafting_machine_tint = 
            {
                primary = {r = 0.592, g = 0.565, b = 0.808, a = 1.000},
                secondary = {r = 0.116, g = 0.116, b = 0.116, a = 1.000},
                tertiary = {r = 0.322, g = 0.369, b = 0.514, a = 1.000},
                quaternary = {r = 0.17, g = 0.17, b = 0.17, a = 1.000},
            },
        }
})
