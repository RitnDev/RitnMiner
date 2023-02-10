
local data_ores = {"iron-ore", "copper-ore"}

local crafting_machine_tint = {
    ["iron-ore"] = {
        primary = {r = 0.262, g = 0.607, b = 0.798, a = 1.000}, 
        secondary = {r = 0.438, g = 0.657, b = 0.778, a = 1.000}, 
        tertiary = {r = 0.728, g = 0.818, b = 0.443, a = 1.000},
        quaternary = {r = 0.939, g = 0.763, b = 0.191, a = 1.000},
    },
    ["copper-ore"] = {
      primary = {r = 0.965, g = 0.482, b = 0.338, a = 1.000}, 
      secondary = {r = 0.831, g = 0.560, b = 0.222, a = 1.000}, 
      tertiary = {r = 0.728, g = 0.818, b = 0.443, a = 1.000}, 
      quaternary = {r = 0.939, g = 0.763, b = 0.191, a = 1.000}, 
    }
}


for i, data_ore in pairs(data_ores) do 
    ritnmods.miner.data.add_data_ore(data_ore)
    ritnmods.miner.data.create_recipe_extraction(data_ore, crafting_machine_tint[data_ore])
end

for _,ore in pairs(ritnmods.miner.data.ores) do
    for tech_value = 1, ore.value do
        data:extend({ritnmods.miner.data.create_tech_improved_ore_extraction(ore.name, tech_value)})
    end
end