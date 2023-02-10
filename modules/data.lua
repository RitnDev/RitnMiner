local flib = {
    ores = {}
}

local function icons(ore) 
    local ore_name = "default"
    if ore ~= nil then ore_name = ore end

    return {
        icon = "__RitnMiner__/graphics/technology/Improved-" .. ore_name .. "-extraction.png",
        icon_size = 206,
    }
end

local function prerequisites(ore) 
    return {
        [1] = {"ritn-tech-miner-mk1"},
        [2] = {"Improved-" .. ore .. "-extraction-1"},
        [3] = {"sulfur-processing","Improved-" .. ore .. "-extraction-2"},
        [4] = {"Improved-" .. ore .. "-extraction-3"},
        [5] = {"Improved-" .. ore .. "-extraction-4"},
        [6] = {"Improved-" .. ore .. "-extraction-5"},
        [7] = {"Improved-" .. ore .. "-extraction-6"},
        [8] = {"Improved-" .. ore .. "-extraction-7"},
        [9] = {"space-science-pack", "Improved-" .. ore .. "-extraction-8"},
    }
end


local ingredients = {
    [1] = {
        {"miner-science-pack", 1}
    },
    [2] = {
        {"miner-science-pack", 1}
    },
    [3] = {
        {"automation-science-pack", 1},
        {"miner-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
    },
    [4] = {
        {"automation-science-pack", 1},
        {"miner-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
    },
    [5] = {
        {"automation-science-pack", 1},
        {"miner-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
    },
    [6] = {
        {"automation-science-pack", 1},
        {"miner-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
    },
    [7] = {
        {"automation-science-pack", 1},
        {"miner-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
    },
    [8] = {
        {"automation-science-pack", 1},
        {"miner-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
    },
    [9] = {
        {"automation-science-pack", 1},
        {"miner-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"space-science-pack", 1}
    },
}

flib.units = {
    [1] = {count=50,  ingredients=ingredients[1], time=30},
    [2] = {count=100, ingredients=ingredients[2], time=30},
    [3] = {count=200, ingredients=ingredients[3], time=30},
    [4] = {count=300, ingredients=ingredients[4], time=30},
    [5] = {count=400, ingredients=ingredients[5], time=30},
    [6] = {count=500, ingredients=ingredients[6], time=30},
    [7] = {count=800, ingredients=ingredients[7], time=60},
    [8] = {count=1000,ingredients=ingredients[8], time=60},
    [9] = {count=2000,ingredients=ingredients[9], time=60},
}

-- creation de la technologie pour débloqué la recette d'extraction
function flib.create_tech_improved_ore_extraction(ore, tech_value)
    return {
        type = "technology",
        name = "Improved-" .. ore .. "-extraction-" .. tech_value,
        icon = ritnmods.miner.data.ores[ore].icons.icon, 
        icon_size = ritnmods.miner.data.ores[ore].icons.icon_size,
        effects = {
            {type = "unlock-recipe", recipe = ore .. "-extraction-" .. tech_value},
        },
        upgrade = true,
        prerequisites = ritnmods.miner.data.ores[ore].prerequisites[tech_value],
        unit = ritnmods.miner.data.units[tech_value],
        order = "a-b" .. tech_value .. "[".. ore .."]",
    }
end

-- ajout d'un minerai en data pour creation
function flib.add_data_ore(ore_name, icon_default, icons_ext)
    local iconsDefault = icons()
    local icons = icons(ore_name)
    if icon_default ~= nil and icon_default == true then icons = iconsDefault end
    if icons_ext ~= nil then icons = icons_ext end

    flib.ores[ore_name] = {
        name = ore_name,
        value = 9,
        icons = icons,
        prerequisites = prerequisites(ore_name),
    }
end

-- creation de la recette d'extraction
function flib.create_recipe_extraction(ore, crafting_machine_tint)

    local icon_ore = util.table.deepcopy(data.raw.item[ore])
    local acid = util.table.deepcopy(data.raw["fluid"]["sulfuric-acid"])
    local stone = util.table.deepcopy(data.raw.item.stone)
  
    local icons_stone = 
    {
      {
        icon = icon_ore.icon,
        icon_size = icon_ore.icon_size,
        icon_mipmaps = icon_ore.icon_mipmaps,
      },
      {
        icon = stone.icon,
        icon_size = stone.icon_size,
        icon_mipmaps = stone.icon_mipmaps,
        scale = 16 / stone.icon_size,
        shift = {8, 8}
      }
    }
  
    local icons_acid = 
    {
      {
        icon = icon_ore.icon,
        icon_size = icon_ore.icon_size,
        icon_mipmaps = icon_ore.icon_mipmaps,
      },
      {
        icon = acid.icon,
        icon_size = acid.icon_size,
        icon_mipmaps = acid.icon_mipmaps,
        scale = 16 / acid.icon_size,
        shift = {8, 8}
      }
    }
    
  
    data:extend({
  
      -- ORE :
      -- ##########
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-0",
        category = "ritn-crushing",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {"stone", 5}
        },
        results=
        {
          {type="item", name=ore, amount=1},
          {type="item", name=ore, amount=1, probability=0.01},
          {type="item", name=ore, amount=1, probability=0.01},
          {type="item", name=ore, amount=1, probability=0.01},
          {type="item", name="stone", amount=1}
        },
        icons = icons_stone,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-1",
        category = "ritn-crushing",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {"stone", 5}
        },
        results=
        {
          {type="item", name=ore, amount=1},
          {type="item", name=ore, amount=1, probability=0.10},
          {type="item", name=ore, amount=1, probability=0.05},
          {type="item", name=ore, amount=1, probability=0.01},
          {type="item", name="stone", amount=1}
        },
        icons = icons_stone,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-2",
        category = "ritn-crushing",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {"stone", 5}
        },
        results=
        {
          {type="item", name=ore, amount=1},
          {type="item", name=ore, amount=1, probability=0.20},
          {type="item", name=ore, amount=1, probability=0.10},
          {type="item", name=ore, amount=1, probability=0.05},
          {type="item", name="stone", amount=1}
        },
        icons = icons_stone,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-3",
        category = "chemistry",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {type="item", name="stone", amount=10},
          {type="fluid", name="sulfuric-acid", amount=10},
        },
        results=
        {
          {type="item", name=ore, amount=4},
        },
        icons = icons_acid,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-4",
        category = "chemistry",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {type="item", name="stone", amount=10},
          {type="fluid", name="sulfuric-acid", amount=10},
        },
        results=
        {
          {type="item", name=ore, amount=5},
        },
        icons = icons_acid,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-5",
        category = "chemistry",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {type="item", name="stone", amount=10},
          {type="fluid", name="sulfuric-acid", amount=10},
        },
        results=
        {
          {type="item", name=ore, amount=6},
        },
        icons = icons_acid,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-6",
        category = "chemistry",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {type="item", name="stone", amount=10},
          {type="fluid", name="sulfuric-acid", amount=10},
        },
        results=
        {
          {type="item", name=ore, amount=7},
        },
        icons = icons_acid,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-7",
        category = "chemistry",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {type="item", name="stone", amount=10},
          {type="fluid", name="sulfuric-acid", amount=10},
        },
        results=
        {
          {type="item", name=ore, amount=8},
        },
        icons = icons_acid,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-8",
        category = "chemistry",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {type="item", name="stone", amount=10},
          {type="fluid", name="sulfuric-acid", amount=10},
        },
        results=
        {
          {type="item", name=ore, amount=9},
        },
        icons = icons_acid,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      },
  
      {
        --recipe
        type = "recipe",
        name = ore .. "-extraction-9",
        category = "chemistry",
        subgroup = "ritn-miner",
        energy_required = 3.2,
        enabled = false,
        ingredients =
        {
          {type="item", name="stone", amount=10},
          {type="fluid", name="sulfuric-acid", amount=10},
        },
        results=
        {
          {type="item", name=ore, amount=10},
        },
        icons = icons_acid,
        order = "a[stone-processing]-a",
        crafting_machine_tint = crafting_machine_tint
      }
  
    })
  
  
    local recipes = {
      ore .. "-extraction-3",
      ore .. "-extraction-4",
      ore .. "-extraction-5",
      ore .. "-extraction-6",
      ore .. "-extraction-7",
      ore .. "-extraction-8",
      ore .. "-extraction-9"
    }
  
    local limitation1 = data.raw.module["productivity-module"].limitation
    local limitation2 = data.raw.module["productivity-module-2"].limitation
    local limitation3 = data.raw.module["productivity-module-3"].limitation
  
    for _,recipe in pairs(recipes) do
      table.insert(limitation1, recipe)
      table.insert(limitation2, recipe)
      table.insert(limitation3, recipe)
    end
  end

return flib