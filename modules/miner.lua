local tech = require("modules.update-recipes")
----------------------------------------------------------------

  -- Quand une recherche se termine...
local function on_research_finished(e)
    local RitnTech = RitnLibEvent(e):getTechnology()
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
