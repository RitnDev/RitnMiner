local RitnProtoTech = require(ritnlib.defines.class.prototype.tech)

-- RitnLumberjack NON ACTIF
if ritnmods.miner.lumberjack == false then  

    -- activation des recette de désassemblage
    require("prototypes.recipes.disassembler")

    RitnProtoTech("advanced-material-processing"):addRecipe("recipe_steel_furnace_disassemble")

    -- automation-2
    local automation2 = RitnProtoTech("automation-2")
    automation2:addRecipe("recipe_burner_mining_drill_disassemble")
    automation2:addRecipe("recipe_stone_furnace_disassemble")
    automation2:addRecipe("recipe_burner_inserter_disassemble")
    automation2:addRecipe("recipe_long_handed_inserter_disassemble")

end
  