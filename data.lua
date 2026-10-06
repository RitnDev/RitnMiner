-- INITIALIZE
-----------------------------------------------------------------
if not ritnlib then require("__RitnLib__/defines") end
local RitnProtoOre = require(ritnlib.defines.class.prototype.ore)
local RitnProtoItem = require(ritnlib.defines.class.prototype.item)
local RitnProtoRecipe = require(ritnlib.defines.class.prototype.recipe)
local RitnProtoTech = require(ritnlib.defines.class.prototype.tech)
-----------------------------------------------------------------
if not ritnmods then ritnmods = {} end
---**EN**
---
---Description: RitnMiner's data-stage shared table (`ritnmods.miner`). Holds the third-party mod detection flags read by RitnMiner and by the other Ritn mods (cross compatibility), plus the extraction generator `data` (the mod's only extension point). Exists at data stage only (not persisted, not available at runtime).
---
---⚠ Created only `if not ritnmods.miner`: if another mod created it first, these fields are not initialized here. The detection flags are set right after creation (`mods[...]`, `ritnmods.lumberjack.enabled`).
---
---──────────────────────────────
---
---**FR**
---
---Description: Table partagée data stage de RitnMiner (`ritnmods.miner`). Contient les drapeaux de détection des mods tiers, lus par RitnMiner et par les autres mods Ritn (compatibilité croisée), ainsi que le générateur d'extraction `data` (seul point d'extension du mod). N'existe qu'au data stage (non persistée, absente au runtime).
---
---⚠ Créée seulement `if not ritnmods.miner` : si un autre mod l'a créée avant, ces champs ne sont pas initialisés ici. Les drapeaux de détection sont posés juste après la création (`mods[...]`, `ritnmods.lumberjack.enabled`).
---@class RitnMinerGlobal
---@field lumberjack boolean    `true` when `ritnmods.lumberjack.enabled` (RitnLumberjack, which includes Bio Industries)
---@field dectorio boolean      `mods["Dectorio"]`
---@field alienBiomes boolean   `mods["alien-biomes"]`
---@field spaceblock boolean    `mods["spaceblock"]`
---@field commuLogo boolean     `mods["CommuLogo"]`
---@field data RitnMinerData    Extraction generator (`modules/data.lua`)
if not ritnmods.miner then ritnmods.miner = {
    lumberjack = false,
    dectorio = false,
    alienBiomes = false,
    spaceblock = false,
    commuLogo = false,
    data = require("modules.data")
} end
-----------------------------------------------------------------
-- active options
if mods["Dectorio"] then ritnmods.miner.dectorio = true end
if mods["alien-biomes"] then ritnmods.miner.alienBiomes = true end
if mods["spaceblock"] then ritnmods.miner.spaceblock = true end
if mods["CommuLogo"] then ritnmods.miner.commuLogo = true end

-- RitnLumberjack present (inclut Bio Industries)
if ritnmods.lumberjack then 
  if ritnmods.lumberjack.enabled then ritnmods.miner.lumberjack = true end 
end
-----------------------------------------------------------------
-- remove ore
RitnProtoOre("iron-ore"):remove()
RitnProtoOre("copper-ore"):remove()
-----------------------------------------------------------------
-- change item
RitnProtoItem("stone"):changePrototype("stack_size", 200)
RitnProtoItem("iron-ore"):changePrototype("stack_size", 100)
RitnProtoItem("copper-ore"):changePrototype("stack_size", 100)
RitnProtoItem("military-science-pack"):changePrototype("icon", "__RitnMiner__/graphics/icons/military-science-pack.png")
-----------------------------------------------------------------
-- disable recipe (debloquees par la technologie miner-science-pack)
RitnProtoRecipe("iron-plate"):setEnabled(false)
RitnProtoRecipe("copper-plate"):setEnabled(false)
RitnProtoRecipe("iron-chest"):setEnabled(false)
RitnProtoRecipe("iron-gear-wheel"):setEnabled(false)
RitnProtoRecipe("burner-inserter"):setEnabled(false)
RitnProtoRecipe("transport-belt"):setEnabled(false)
RitnProtoRecipe("burner-mining-drill"):setEnabled(false)
-----------------------------------------------------------------
--Require
require("prototypes.category")
require("prototypes.item")
require("prototypes.recipes")
require("prototypes.technology")
require("prototypes.ore-extraction")
require("prototypes.map-gen-presets")
-----------------------------------------------------------------
-- change subgroup
RitnProtoItem("offshore-pump"):changeSubgroup("energy", "a-[offshore-pump]")
-----------------------------------------------------------------
-- update technology (requis : ritnlib.tech)
require("prototypes.update-technology")
-----------------------------------------------------------------
-- require - options mods :
require("mods.data-landfill")
require("mods.data-ritn-lumberjack")

--Ajoute la recherche : Miner-science-pack
if ritnmods.miner.lumberjack then
    RitnProtoTech:addPackLab("miner-science-pack", 2)
else
    RitnProtoTech:addPackLab("miner-science-pack")
end


if ritnmods.glass ~= nil then 
  if ritnmods.glass.enabled then 
    if ritnmods.miner.lumberjack then 
      -- ajout des recettes de gestion de la pierre broyée
      require("prototypes.recipes.stone-brick")

      -- changement dans la recette : bi-stone-brick (fabrication de brique à partir de cendre)
      local biStoneBrickRecipe = RitnProtoRecipe("bi-stone-brick")
      biStoneBrickRecipe:addNewIngredient({type="fluid", name="water", amount=10})
      biStoneBrickRecipe:setCategories("ritn-glass-chemistry")
      biStoneBrickRecipe:changePrototype("energy_required", 16)

      require("prototypes.recipes.stone")
    end
  end
end

