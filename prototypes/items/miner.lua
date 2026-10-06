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
            enabled = false,
            energy_required = 3,
            ingredients = 
            {
              {type="item", name="iron-plate", amount=5},
              {type="item", name="iron-gear-wheel", amount=2},
              {type="item", name="burner-mining-drill", amount=2},
            },
            results = {{type="item", name="miner_mk1", amount=1}},
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
          enabled = false,
          energy_required = 3,
          ingredients = 
          {
            {type="item", name="iron-plate", amount=5},
            {type="item", name="steel-plate", amount=3},
            {type="item", name="iron-gear-wheel", amount=2},
            {type="item", name="electronic-circuit", amount=1},
            {type="item", name="miner_mk1", amount=1}
          },
          results = {{type="item", name="miner_mk2", amount=1}},
          order = "a-a2",
          always_show_made_in = true,
          allow_decomposition = false,
      }

})



