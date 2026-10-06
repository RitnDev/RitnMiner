
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

local RitnProtoItem = require(ritnlib.defines.class.prototype.item)

icons.inserter = RitnProtoItem("burner-inserter"):getIconLayers()
table.insert(icons.inserter,disassembler)

icons.mining = RitnProtoItem("burner-mining-drill"):getIconLayers()
table.insert(icons.mining,disassembler)

icons.furnace = RitnProtoItem("stone-furnace"):getIconLayers()
table.insert(icons.furnace,disassembler)

icons.long_inserter = RitnProtoItem("long-handed-inserter"):getIconLayers()
table.insert(icons.long_inserter,disassembler)

icons.steel_furnace = RitnProtoItem("steel-furnace"):getIconLayers()
table.insert(icons.steel_furnace,disassembler)




data:extend({

		{
			type = "recipe",
			name = "recipe_burner_mining_drill_disassemble",
			icons = icons.mining,
			subgroup = "ritn-disassemble",
			categories = {"advanced-crafting"},
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
					{type="item", name="stone", amount=4},
					{type="item", name="iron-plate", amount=4}
				},

		},

	  
		{
			type = "recipe",
			name = "recipe_stone_furnace_disassemble",
			icons = icons.furnace,
			subgroup = "ritn-disassemble",
			categories = {"advanced-crafting"},
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
				  {type="item", name="stone", amount=3},
				},
				
	  },
	  
	   
		
		{
			type = "recipe",
			name = "recipe_burner_inserter_disassemble",
			icons = icons.inserter,
			subgroup = "ritn-disassemble",
			categories = {"advanced-crafting"},
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
				  {type="item", name="iron-plate", amount=2},
				},
				
	  },


	  
		{
			type = "recipe",
			name = "recipe_long_handed_inserter_disassemble",
			icons = icons.long_inserter,
			subgroup = "ritn-disassemble",
			categories = {"advanced-crafting"},
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
				  {type="item", name="iron-gear-wheel", amount=1},
				  {type="item", name="iron-plate", amount=1},
				  {type="item", name="electronic-circuit", amount=1},
				},
				
	  },



		{
			type = "recipe",
			name = "recipe_steel_furnace_disassemble",
			icons = icons.steel_furnace,
			subgroup = "ritn-disassemble",
			categories = {"advanced-crafting"},
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
				  {type="item", name="steel-plate", amount=4},
				  {type="item", name="stone-brick", amount=4}
				},
				
	  }

	  
	  
})