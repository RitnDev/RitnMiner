

if data.raw["map-gen-presets"]["default"]["ritn"] == nil then

data.raw["map-gen-presets"]["default"]["ritn"] =
    {
        order = "a1",
        basic_settings = {
            autoplace_controls =
            {
            ["stone"] = 
                {
                    frequency = 3,
                    size = 2,
                    richness = 1
                },
            ["enemy-base"] = 
                {
                    frequency = 0.5,
                    size = 0.75,
                    richness = 1
                }
            },
            terrain_segmentation = 0.5,
            water = 0.33333334326744,
            starting_area = 2,
            cliff_settings = {richness = 0},
            property_expression_names = {
                ["control-setting:aux:bias"] = "0.35",
                ["control-setting:aux:frequency:multiplier"] = "0.5",
                ["control-setting:moisture:bias"] = "0.1",
                ["control-setting:moisture:frequency:multiplier"] = "0.5",
            }
        },
        advanced_settings =
        {
            difficulty_settings =
            {
                research_queue_setting = "always"
            },
            enemy_expansion = { enabled = false },
            enemy_evolution = 
            {
                time_factor = 0.0000010,
                destroy_factor = 0.004,
                pollution_factor = 0.00000050,
            },
            pollution = {
                enabled = true,
                diffusion_ratio = 0.01,
                ageing = 2,
                min_pollution_to_damage_trees = 500,
                pollution_restored_per_tree_damage = 20,
                enemy_attack_pollution_consumption_modifier = 3
            }
        }
    }
else

    data.raw["map-gen-presets"]["default"]["ritn"].basic_settings.autoplace_controls["stone"] = 
    {
        frequency = 3,
        size = 2,
        richness = 1
    }

end
