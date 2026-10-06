local tech = require("modules.update-recipes")
----------------------------------------------------------------

  -- Quand une recherche se termine...

---**EN**
---
---Description: `on_research_finished` handler. When the researched technology is listed in `modules/update-recipes.lua`, calls `RitnLibTechnology:updateRecipe`: disables the lower-tier recipes for the force and switches the force's assembling machines that use them to the new recipe (all surfaces). Other technologies are ignored.
---
---──────────────────────────────
---
---**FR**
---
---Description: Handler de `on_research_finished`. Si la technologie terminée est listée dans `modules/update-recipes.lua`, appelle `RitnLibTechnology:updateRecipe` : désactive les recettes des paliers inférieurs pour la force et bascule sur la nouvelle recette les machines d'assemblage de la force qui les utilisent (toutes surfaces). Les autres technologies sont ignorées.
---@param e EventData.on_research_finished
local function on_research_finished(e)
    local RitnTech = RitnLibEvent(e):getTechnology()
    local iTech = tech[RitnTech.name]
    if iTech then
        RitnTech:updateRecipe(iTech.name, iTech.disableTabRecipes, iTech.setRecipeName)
    end
end


----------------------------------------------------------------

---**EN**
---
---Description: Runtime module registered in `control.lua` through `event_handler.add_libraries` (`__core__/lualib/event_handler`). Listens to `on_research_finished` only.
---
---──────────────────────────────
---
---**FR**
---
---Description: Module runtime enregistré dans `control.lua` via `event_handler.add_libraries` (`__core__/lualib/event_handler`). N'écoute que `on_research_finished`.
---@type RitnLibEventLib
local module = { events = {} }
module.events[defines.events.on_research_finished] = on_research_finished
----------------------------------------------------------------
return module
