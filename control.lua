require("__RitnLib__/defines")
require(ritnlib.defines.setup)

-- gvv
if script.active_mods["gvv"] then require(ritnlib.defines.gvv)() end

-- Chargement des modules :

---@type table<string, RitnLibEventLib>
local modules = {}
modules.miner =         require("modules.miner")
modules.discoScience =  require("modules.disco-science")

-- envoie des modules à l'event listener :
local event_listener = require(ritnlib.defines.event).add_libraries(modules)
