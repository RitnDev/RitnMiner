local tech = require("modules.update-recipes")
----------------------------------------------------------------
local RitnEvent = require(ritnlib.defines.class.luaClass.event)
----------------------------------------------------------------

  -- Quand une recherche se termine...
local function on_research_finished(e)
    local RitnTech = RitnEvent(e):getTechnology()
    local iTech = tech[RitnTech.name]
    if iTech then
        RitnTech:updateRecipe(iTech.name, iTech.disableTabRecipes, iTech.setRecipeName)
    end
end


----------------------------------------------------------------
local module = { events = {} }
module.events[defines.events.on_research_finished] = on_research_finished
----------------------------------------------------------------
return module
