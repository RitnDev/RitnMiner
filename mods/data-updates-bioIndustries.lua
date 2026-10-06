--Update Bio Industries (inclus dans RitnLumberjack)
if ritnmods.miner.lumberjack then 
    
    -----------------------------------------------------------------
    local RitnProtoItem = require(ritnlib.defines.class.prototype.item)
    local RitnProtoRecipe = require(ritnlib.defines.class.prototype.recipe)
    local RitnProtoTech = require(ritnlib.defines.class.prototype.tech)
    -----------------------------------------------------------------

    
    -- delete tile place
    RitnProtoItem("wood"):changePrototype("place_as_tile", nil)
    RitnProtoItem("seedling"):changePrototype("place_as_tile", nil)
    -- delete pictures variations
    RitnProtoItem("stone-crushed"):changePrototype("pictures", nil)

    -- change recipe category
    RitnProtoRecipe("bi-crushed-stone-1"):setCategories("ritn-crushing")
    RitnProtoRecipe("bi-crushed-stone-2"):setCategories("ritn-crushing")
    RitnProtoRecipe("bi-crushed-stone-3"):setCategories("ritn-crushing")
    RitnProtoRecipe("bi-crushed-stone-4"):setCategories("ritn-crushing")
    RitnProtoRecipe("bi-crushed-stone-5"):setCategories("ritn-crushing")

    ------------------------------------------------------------------
    -- TECHNOLOGY

    -- recipe remove 
    local rProtoTech = RitnProtoTech("steel-processing")
    rProtoTech:removeRecipe("bi-stone-crusher")
    rProtoTech:removeRecipe("bi-crushed-stone-1")

    rProtoTech = RitnProtoTech("advanced-material-processing-2")
    rProtoTech:removeRecipe("bi-crushed-stone-2")
    rProtoTech:removeRecipe("bi-crushed-stone-3")
    rProtoTech:removeRecipe("bi-crushed-stone-4")
    rProtoTech:removeRecipe("bi-crushed-stone-5")

    RitnProtoTech("logistics"):removeRecipe("bi-wooden-pole-big")
    RitnProtoTech("bi-tech-coal-processing-2"):removeRecipe("bi-basic-gas-processing")
    RitnProtoTech("bi-tech-fertilizer"):removeRecipe("bi-seed-bomb-basic")
    RitnProtoTech("bi-tech-fertilizer"):removeRecipe("bi-seed-bomb-standard")
    RitnProtoTech("bi-tech-advanced-biotechnology"):removeRecipe("bi-seed-bomb-advanced")
    RitnProtoTech("solar-energy"):removeRecipe("bi-solar-mat")

    -- recipe disassembler disable
    rProtoTech = RitnProtoTech("automation-2")
    rProtoTech:removeRecipe("bi-burner-mining-drill-disassemble")
    rProtoTech:removeRecipe("bi-burner-inserter-disassemble")
    rProtoTech:removeRecipe("bi-long-handed-inserter-disassemble")
    rProtoTech:removeRecipe("bi-stone-furnace-disassemble")

    RitnProtoTech("advanced-material-processing"):removeRecipe("bi-steel-furnace-disassemble")

    -- add recipe
    RitnProtoTech("ritn-tech-miner-mk1"):addRecipe("bi-crushed-stone-1")
    rProtoTech = RitnProtoTech("concrete")
    rProtoTech:addRecipe("bi-crushed-stone-2")
    rProtoTech:addRecipe("bi-crushed-stone-3")
    rProtoTech:addRecipe("bi-crushed-stone-4")
    rProtoTech:addRecipe("bi-crushed-stone-5")

    -- ajout de la couleur de fumée sur la recette bi-stone-brick
    RitnProtoRecipe("bi-stone-brick"):changePrototype("crafting_machine_tint", 
        {
            primary = {r = 0.682, g = 0.624, b = 0.486, a = 1.000},
            secondary = {r = 0.116, g = 0.116, b = 0.116, a = 1.000},
            tertiary = {r = 0.682, g = 0.624, b = 0.486, a = 1.000},
            quaternary = {r = 0.17, g = 0.17, b = 0.17, a = 1.000},
        }
    )


    -- RitnGlass Actif
    if ritnmods.glass ~= nil then 
        if ritnmods.glass.enabled then 
            rProtoTech = RitnProtoTech("ritn-tech-miner-mk1")
            rProtoTech:addRecipe("ritn-stone-brick")
            rProtoTech:addRecipe("ritn-stone")
        end
    end
end