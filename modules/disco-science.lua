
----------------------------------------------------------------

---**EN**
---
---Description: Sets the DiscoScience lab color of `miner-science-pack` (`RitnLibEvent.setIngredientColor`). No-op when DiscoScience is absent (the remote interface is checked by RitnLib).
---
---──────────────────────────────
---
---**FR**
---
---Description: Définit la couleur de `miner-science-pack` dans les labos DiscoScience (`RitnLibEvent.setIngredientColor`). Sans effet si DiscoScience est absent (l'interface remote est vérifiée par RitnLib).
local function updateDiscoScience()
    RitnLibEvent.setIngredientColor("miner-science-pack", {r = 0.592, g = 0.565, b = 0.808})
end
----------------------------------------------------------------
-- module pour l'event_handler (ne pas appeler script.on_init directement :
-- cela écraserait l'on_init de __core__/lualib/event_handler)

---**EN**
---
---Description: Runtime module registered in `control.lua` through `event_handler.add_libraries`. Applies the DiscoScience color on `on_init` and `on_configuration_changed`.
---
---──────────────────────────────
---
---**FR**
---
---Description: Module runtime enregistré dans `control.lua` via `event_handler.add_libraries`. Applique la couleur DiscoScience sur `on_init` et `on_configuration_changed`.
---@type RitnLibEventLib
local module = {}
module.on_init = updateDiscoScience
module.on_configuration_changed = updateDiscoScience
----------------------------------------------------------------
return module
