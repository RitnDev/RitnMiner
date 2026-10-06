if ritnmods.miner.commuLogo then

    -----------------------------------------------------------------
    local RitnProtoRecipe = require(ritnlib.defines.class.prototype.recipe)
    local RitnProtoTech = require(ritnlib.defines.class.prototype.tech)
    -----------------------------------------------------------------

    --Update recipe bigcommulogo
    RitnProtoRecipe("bigcommulogo"):changePrototype("ingredients", 
        {
            {type="item", name="iron-plate", amount=17},
            {type="item", name="iron-gear-wheel", amount=17},
            {type="item", name="electronic-circuit", amount=17},
            {type="item", name="small-lamp", amount=2},
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
            "lamp",
        }
    )
    
end