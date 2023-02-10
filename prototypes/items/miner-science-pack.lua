
data:extend(
    {
        --Miner Science Pack
        {
            --item (tool)
            type = "tool",
            name = "miner-science-pack",
            icon = "__RitnMiner__/graphics/icons/miner-science-pack.png",
            icon_size = 64, icon_mipmaps = 4,
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
            enabled = true, --false,
            ingredients =
            {
              {"stone-brick", 4},
              {"burner-mining-drill", 1}
            },
            result = "miner-science-pack",
            result_count = 2,
            crafting_machine_tint = 
            {
                primary = {r = 0.592, g = 0.565, b = 0.808, a = 1.000},
                secondary = {r = 0.116, g = 0.116, b = 0.116, a = 1.000},
                tertiary = {r = 0.322, g = 0.369, b = 0.514, a = 1.000},
                quaternary = {r = 0.17, g = 0.17, b = 0.17, a = 1.000},
            },
        }
})

local recipes = {"miner-science-pack"}
local limitation1 = data.raw.module["productivity-module"].limitation
local limitation2 = data.raw.module["productivity-module-2"].limitation
local limitation3 = data.raw.module["productivity-module-3"].limitation
    
for _,recipe in pairs(recipes) do
    table.insert(limitation1, recipe)
    table.insert(limitation2, recipe)
    table.insert(limitation3, recipe)
end
