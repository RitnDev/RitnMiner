
local icons = 
{
	inserter = {},
	mining = {},
	furnace = {},
	long_inserter = {},
	steel_furnace = {},

}

local disassembler = 
{ 
	icon = "__RitnMiner__/graphics/icons/recyclage.png",
	icon_size = 64,
	scale = 20 / 64,
    shift = {8, 8}
}

local item = util.table.deepcopy(data.raw.item["burner-inserter"])
icons.inserter = {
	{
	icon = item.icon,
    icon_size = item.icon_size,
	icon_mipmaps = item.icon_mipmaps,
	}
}
table.insert(icons.inserter,disassembler)

local item = util.table.deepcopy(data.raw.item["burner-mining-drill"])
icons.mining = {
	{
	icon = item.icon,
    icon_size = item.icon_size,
	icon_mipmaps = item.icon_mipmaps,
	}
}
table.insert(icons.mining,disassembler)

local item = util.table.deepcopy(data.raw.item["stone-furnace"])
icons.furnace = {
	{
	icon = item.icon,
    icon_size = item.icon_size,
	icon_mipmaps = item.icon_mipmaps,
	}
}
table.insert(icons.furnace,disassembler)

local item = util.table.deepcopy(data.raw.item["long-handed-inserter"])
icons.long_inserter = {
	{
	icon = item.icon,
    icon_size = item.icon_size,
	icon_mipmaps = item.icon_mipmaps,
	}
}
table.insert(icons.long_inserter,disassembler)

local item = util.table.deepcopy(data.raw.item["steel-furnace"])
icons.steel_furnace = {
	{
	icon = item.icon,
    icon_size = item.icon_size,
	icon_mipmaps = item.icon_mipmaps,
	}
}
table.insert(icons.steel_furnace,disassembler)




data:extend({

		{
			type = "recipe",
			name = "recipe_burner_mining_drill_disassemble",
			icons = icons.mining,
			subgroup = "ritn-disassemble",
			category = "advanced-crafting",
			order = "a[Disassemble]-a[recipe_burner_mining_drill_disassemble]",
			enabled = false,
			allow_as_intermediate = false,
			always_show_made_in = true,
			allow_decomposition = false,
			energy_required = 2,
			ingredients =
				{
				  {type="item", name="burner-mining-drill", amount=1},   	  
				},
			results =
				{
					{"stone", 4},
					{"iron-plate", 4}
				},

		},

	  
		{
			type = "recipe",
			name = "recipe_stone_furnace_disassemble",
			icons = icons.furnace,
			subgroup = "ritn-disassemble",
			category = "advanced-crafting",
			order = "a[Disassemble]-b[recipe_stone_furnace_disassemble]",
			enabled = false,
			allow_as_intermediate = false,
			always_show_made_in = true,
			allow_decomposition = false,
			energy_required = 2,
			ingredients =
				{
				  {type="item", name="stone-furnace", amount=1},   	  
				},
			results =		
				{
				  {"stone", 3},
				},
				
	  },
	  
	   
		
		{
			type = "recipe",
			name = "recipe_burner_inserter_disassemble",
			icons = icons.inserter,
			subgroup = "ritn-disassemble",
			category = "advanced-crafting",
			order = "a[Disassemble]-c[recipe_burner_inserter_disassemble]",
			enabled = false,
			allow_as_intermediate = false,
			always_show_made_in = true,
			allow_decomposition = false,
			energy_required = 2,
			ingredients =
				{
				  {type="item", name="burner-inserter", amount=1},   	  
				},
			results =		
				{
				  {"iron-plate", 2},
				},
				
	  },


	  
		{
			type = "recipe",
			name = "recipe_long_handed_inserter_disassemble",
			icons = icons.long_inserter,
			subgroup = "ritn-disassemble",
			category = "advanced-crafting",
			order = "a[Disassemble]-e[recipe_long_handed_inserter_disassemble]",
			enabled = false,
			allow_as_intermediate = false,
			always_show_made_in = true,
			allow_decomposition = false,
			energy_required = 2,
			ingredients =
				{
				  {type="item", name="long-handed-inserter", amount=1},   	  
				},
			results =		
				{
				  {"iron-gear-wheel", 1},
				  {"iron-plate", 1},
				  {"electronic-circuit", 1},
				},
				
	  },



		{
			type = "recipe",
			name = "recipe_steel_furnace_disassemble",
			icons = icons.steel_furnace,
			subgroup = "ritn-disassemble",
			category = "advanced-crafting",
			order = "a[Disassemble]-f[recipe_steel_furnace_disassemble]",
			enabled = false,
			allow_as_intermediate = false,
			always_show_made_in = true,
			allow_decomposition = false,
			energy_required = 2,
			ingredients =
				{
				  {type="item", name="steel-furnace", amount=1},   	  
				},
			results =		
				{
				  {"steel-plate", 4},
				  {"stone-brick", 4}
				},
				
	  }

	  
	  
})