require("__RitnLib__/defines")

-- gvv
if script.active_mods["gvv"] then require(ritnlib.defines.gvv)() end

-- Chargement des modules :
local modules = {}
modules.miner =         require("modules.miner")

-- envoie des modules à l'event listener :
local event_listener = require(ritnlib.defines.event).add_libraries(modules)
----------------------------------------------------------------------------
--DiscoScience doit être placé après event_listener :
require("modules.disco-science")