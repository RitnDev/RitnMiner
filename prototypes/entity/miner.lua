----------------------------------------------------
-- data 
local tint = { r = 0.60, g = 0.60, b = 0.60, a = 1}

local icons_mk1 = {{
  icon = "__RitnMiner__/graphics/icons/stone_crusher.png",  -- Image de Bio Industries
  icon_size = 78,
}}
local icons_mk2 = table.deepcopy(icons_mk1)
icons_mk2[1].tint = tint

local animation = {
  filename = "__RitnMiner__/graphics/entity/stone-crusher/stone_crusher_anim.png",  -- Image de Bio Industries
  priority = "high",
  width = 65,
  height = 78,
  frame_count = 11,
  animation_speed = 0.5,
  shift = {0.0, -0.1}
}

local working_visualisations = {
  filename = "__RitnMiner__/graphics/entity/stone-crusher/stone-crusher-anim.png",  -- Image de Bio Industries
  priority = "high",
  width = 65,
  height = 78,
  frame_count = 11,
  animation_speed = 0.18 / 2.5,
  shift = {0.0, -0.1}
}



-- MINER 1
local miner1 = {
  type = "assembling-machine",
  name = "miner_mk1",
  icons = icons_mk1,
  flags = {"placeable-neutral","player-creation"},
  minable = {hardness = 0.2,mining_time = 0.5, result = "miner_mk1"},
  max_health = 100,
  dying_explosion = "medium-explosion",
  fast_replaceable_group = "assembling-machine",
  next_upgrade = "miner_mk2",
  working_sound = {
    sound = {
              filename = "__base__/sound/assembling-machine-t1-1.ogg",
              volume = 0.7
            },
    apparent_volume = 1.5
  },
  collision_box = {{-0.8,-0.8},{0.8,0.8}},
  selection_box = {{-1.0,-1.0},{1.0,1.0}},
  animation = animation,
  working_visualisations = working_visualisations,
  drawing_box = {{-1.5, -1.7}, {1.5, 1.5}},
  scale_entity_info_icon = true,
  allowed_effects = {"consumption", "speed", "productivity", "pollution"},
  crafting_speed = 0.5,
  has_backer_name = true,
  crafting_categories = {"ritn-crushing"},
  resistances = {{type = "fire",percent = 70}},
  energy_source =
  {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = 6
  },
  energy_usage = "170kW"
}

data:extend({miner1})

-- MINER 2
local miner2 = table.deepcopy(miner1)

miner2.name = "miner_mk2"
miner2.icons = icons_mk2
miner2.minable.result = "miner_mk2"
miner2.module_specification = {module_slots = 2}
miner2.animation.tint = tint
miner2.working_visualisations.tint = tint
miner2.crafting_speed = 1
miner2.energy_usage = "52kW"



-- add data
data:extend({miner2})
