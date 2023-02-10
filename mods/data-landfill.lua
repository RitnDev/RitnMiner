local RitnProtoTech = require(ritnlib.defines.class.prototype.tech)
local RitnProtoItem = require(ritnlib.defines.class.prototype.item)
local RitnProtoRecipe = require(ritnlib.defines.class.prototype.recipe)

--active les options dectorio ou alien biomes
if ritnmods.miner.dectorio or ritnmods.miner.alienBiomes then
    RitnProtoTech("landfill"):disable()
    RitnProtoItem("landfill"):changeSubgroup("terrain")
end
  
--active les options pour spaceblock
if ritnmods.miner.spaceblock then
    RitnProtoTech("landfill"):disable(true)
    RitnProtoRecipe("spaceblock-matter-refinery"):disable()
end