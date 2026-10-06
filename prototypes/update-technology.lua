local RitnProtoTech = require(ritnlib.defines.class.prototype.tech)


-- disable technology
RitnProtoTech("advanced-oil-processing"):disable(true)

-- replace prerequisite
RitnProtoTech("sulfur-processing"):replacePrerequisite("oil-processing", "shale-oil")
RitnProtoTech("plastics"):replacePrerequisite("oil-processing", "shale-oil")

-- add Science pack
RitnProtoTech("steel-processing"):addPack("miner-science-pack")
RitnProtoTech("advanced-material-processing"):addPack("miner-science-pack")
RitnProtoTech("advanced-material-processing-2"):addPack("miner-science-pack")
RitnProtoTech("concrete"):addPack("miner-science-pack")
RitnProtoTech("production-science-pack"):addPack("miner-science-pack")
RitnProtoTech("mining-productivity-1"):addPack("miner-science-pack")
RitnProtoTech("mining-productivity-2"):addPack("miner-science-pack")
RitnProtoTech("mining-productivity-3"):addPack("miner-science-pack")
RitnProtoTech("mining-productivity-4"):addPack("miner-science-pack")
RitnProtoTech("coal-liquefaction"):addPack("miner-science-pack")
RitnProtoTech("rocket-silo"):addPack("miner-science-pack")
RitnProtoTech("artillery-shell-range-1"):addPack("miner-science-pack")
RitnProtoTech("artillery-shell-speed-1"):addPack("miner-science-pack")
RitnProtoTech("kovarex-enrichment-process"):addPack("miner-science-pack")
RitnProtoTech("nuclear-power"):addPack("miner-science-pack")
RitnProtoTech("nuclear-fuel-reprocessing"):addPack("miner-science-pack")
RitnProtoTech("research-speed-1"):addPack("miner-science-pack")
RitnProtoTech("research-speed-2"):addPack("miner-science-pack")
RitnProtoTech("research-speed-3"):addPack("miner-science-pack")
RitnProtoTech("research-speed-4"):addPack("miner-science-pack")
RitnProtoTech("research-speed-5"):addPack("miner-science-pack")
RitnProtoTech("research-speed-6"):addPack("miner-science-pack")

-- replace pack
RitnProtoTech("cliff-explosives"):replacePack("automation-science-pack", "miner-science-pack")

-- add prerequisite
RitnProtoTech("electronics"):addPrerequisite("miner-science-pack")
RitnProtoTech("steam-power"):addPrerequisite("miner-science-pack")
RitnProtoTech("lubricant"):addPrerequisite("chemical-science-pack")
--RitnProtoTech("coal-processing"):addPrerequisite("chemical-science-pack")
RitnProtoTech("rocket-fuel"):addPrerequisite("chemical-science-pack")


-- Landfill
local protoTechLandFill = RitnProtoTech("landfill")
protoTechLandFill:removePrerequisite("logistic-science-pack")
protoTechLandFill:addPrerequisite("miner-science-pack")
protoTechLandFill:addPack("miner-science-pack")
protoTechLandFill:removePack("automation-science-pack")
protoTechLandFill:removePack("logistic-science-pack")
protoTechLandFill:multipliedPack(2)

-- chemical-science-pack
local chemicalSciencePack = RitnProtoTech("chemical-science-pack")
chemicalSciencePack:addRecipe("solid-fuel-from-heavy-oil")
chemicalSciencePack:addRecipe("solid-fuel-from-light-oil")
chemicalSciencePack:addRecipe("solid-fuel-from-petroleum-gas")

-- shale-oil
local shaleOil = RitnProtoTech("shale-oil")
shaleOil:addRecipe("heavy-oil-cracking")
shaleOil:addRecipe("light-oil-cracking")

-- oil-processing
-- Factorio 2.x : la tech se debloque en minant du crude-oil (supprime par RitnMiner)
-- -> retour a un cout en packs (cout 1.x) et sans la tech oil-gathering (pumpjack)
local oilProcess = RitnProtoTech("oil-processing")
oilProcess:setUnit({
    count = 100,
    ingredients = {
        {"automation-science-pack", 1},
        {"miner-science-pack", 1},
        {"logistic-science-pack", 1}
    },
    time = 30
})
oilProcess:replacePrerequisite("oil-gathering", "fluid-handling")
oilProcess:removeRecipe("basic-oil-processing")
oilProcess:removeRecipe("solid-fuel-from-petroleum-gas")

RitnProtoTech("oil-gathering"):disable(true)




-- Dectorio : update technologies (Voir code dans RitnLumberjack)
RitnProtoTech("dect-earthworks"):disable()

local techDectorio = RitnProtoTech("dect-wood-floor")
techDectorio:setCount(500):setTime(30)

techDectorio = RitnProtoTech("dect-landscaping")
techDectorio:removePack("automation-science-pack")
techDectorio:addPack("miner-science-pack")
techDectorio:setCount(500):setTime(30)

techDectorio = RitnProtoTech("dect-lawnmower")
techDectorio:removePack("logistic-science-pack")
techDectorio:addPack("miner-science-pack")
techDectorio:setCount(500):setTime(60)

techDectorio = RitnProtoTech("dect-concrete-paint")
techDectorio:removePack("logistic-science-pack")
techDectorio:addPack("miner-science-pack")
techDectorio:setCount(500):setTime(60)