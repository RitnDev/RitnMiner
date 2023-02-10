----------------------------------------------------
-- data 
local tint = { r = 0.60, g = 0.60, b = 0.60, a = 1}

local icons_mk1 = {{
  icon = "__RitnMiner__/graphics/icons/stone_crusher.png",  -- Image de Bio Industries
  icon_size = 78,
}}
local icons_mk2 = table.deepcopy(icons_mk1)
icons_mk2[1].tint = tint


data:extend({


        --Miner MK1
        {
            --item
            type = "item",
            name = "miner_mk1",
            icons = icons_mk1,
            subgroup = "extraction-machine",
            order = "a-a1",
            place_result = "miner_mk1",
            stack_size = 10
        },

        {
            -- Recipe
            type = "recipe",
            name = "miner_mk1",
            normal =
            {
                enabled = false,
                energy_required = 3,
                ingredients = 
                {
                  {"iron-plate",5},
                  {"iron-gear-wheel",2},
                  {"burner-mining-drill",2},
                },
              result = "miner_mk1",
              result_count = 1,
            },
            expensive =
            {
                enabled = false,
                energy_required = 5,
                ingredients = 
                {
                  {"iron-plate",12},
                  {"iron-gear-wheel",8},
                },
              result = "miner_mk1",
              result_count = 1,
            },
            order = "a-a1",
            always_show_made_in = true,
            allow_decomposition = false,
        },


        --Miner MK2
        {
          --item
          type = "item",
          name = "miner_mk2",
          icons = icons_mk2,
          subgroup = "extraction-machine",
          order = "a-a2",
          place_result = "miner_mk2",
          stack_size = 10
      },

      {
          -- Recipe
          type = "recipe",
          name = "miner_mk2",
          normal =
          {
              enabled = false,
              energy_required = 3,
              ingredients = 
              {
                {"iron-plate",5},
                {"steel-plate",3},
                {"iron-gear-wheel",2},
                {"electronic-circuit",1},
                {"miner_mk1",1}
              },
            result = "miner_mk2",
            result_count = 1,
          },
          expensive =
          {
              enabled = false,
              energy_required = 5,
              ingredients = 
              {
                {"iron-plate",12},
                {"iron-gear-wheel",8},
              },
            result = "miner_mk2",
            result_count = 1,
          },
          order = "a-a2",
          always_show_made_in = true,
          allow_decomposition = false,
      }

})



