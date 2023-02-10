local RitnProtoTech = require(ritnlib.defines.class.prototype.tech)
--------------------------------------------------------------------
--Update Bio Industries
require("mods.data-updates-bioIndustries")
--Update commuLogo
require("mods.data-updates-commu-logo")
--Update Dectorio
require("mods.data-updates-dectorio")
--------------------------------------------------------------------
--Update RitnWaterfill
if ritnmods.waterfill then
    local techWaterfill = RitnProtoTech("waterfill")
    techWaterfill:removePack("automation-science-pack")
    techWaterfill:removePack("logistic-science-pack")
    techWaterfill:addPack("miner-science-pack")
    techWaterfill:setCount(200)

    techWaterfill = RitnProtoTech("waterfill-dark")
    techWaterfill:removePack("automation-science-pack")
    techWaterfill:removePack("logistic-science-pack")
    techWaterfill:addPack("miner-science-pack")
    techWaterfill:setCount(300)
end