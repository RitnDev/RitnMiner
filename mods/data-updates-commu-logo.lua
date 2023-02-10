if ritnmods.miner.commuLogo then

    -----------------------------------------------------------------
    local RitnProtoRecipe = require(ritnlib.defines.class.prototype.recipe)
    local RitnProtoTech = require(ritnlib.defines.class.prototype.tech)
    -----------------------------------------------------------------

    --Update recipe bigcommulogo
    RitnProtoRecipe("bigcommulogo"):changePrototype("ingredients", 
        {
            {"iron-plate",17},
            {"iron-gear-wheel",17},
            {"electronic-circuit",17},
            {"small-lamp",2},
        }
    )

    --Update technology commulogo-tech
    RitnProtoTech("commulogo-tech"):changePrototype("unit", 
        {
            count_formula = "100",
            ingredients =
            {
                {"automation-science-pack", 1},
                {"miner-science-pack", 1},
                {"logistic-science-pack", 1},
            },
            time = 15
        }
    )
    RitnProtoTech("commulogo-tech"):changePrototype("prerequisites", 
        {
            "automation-2",
            "Improved-iron-ore-extraction-2",
            "Improved-copper-ore-extraction-2",
            "optics",
        }
    )
    
end