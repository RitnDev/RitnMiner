---@class RitnMinerIcon
---@field icon string         Icon path (`__RitnMiner__/graphics/technology/...`)
---@field icon_size integer   Icon size in px (206 for the mod's technology icons)

---@class RitnMinerOreData
---@field name string                              Ore item name (also the key in `RitnMinerData.ores`)
---@field value integer                            Number of technology tiers to generate (always 9)
---@field icons RitnMinerIcon                      Icon of the `Improved-<ore>-extraction-*` technologies
---@field prerequisites table<integer, string[]>   Prerequisites per tier (1..9)

---@class RitnMinerTechUnit
---@field count integer        Research units count
---@field ingredients table[]  Science packs, short format `{"<pack>", 1}`
---@field time number          Seconds per unit

---**EN**
---
---Description: Ore extraction generator, exposed at data stage as `ritnmods.miner.data`. For a given ore it registers the technology data (`add_data_ore`), creates the 10 recipes `<ore>-extraction-0..9` (`create_recipe_extraction`) and builds the 9 technologies `Improved-<ore>-extraction-1..9` (`create_tech_improved_ore_extraction`). Call order: `add_data_ore` before `create_tech_improved_ore_extraction`.
---
---⚠ The runtime recipe swap (`modules/update-recipes.lua`) is not generated: a new ore needs its entries added by hand there.
---
---──────────────────────────────
---
---**FR**
---
---Description: Générateur d'extraction de minerai, exposé au data stage sous `ritnmods.miner.data`. Pour un minerai donné, il inscrit les données de technologie (`add_data_ore`), crée les 10 recettes `<ore>-extraction-0..9` (`create_recipe_extraction`) et construit les 9 technologies `Improved-<ore>-extraction-1..9` (`create_tech_improved_ore_extraction`). Ordre d'appel : `add_data_ore` avant `create_tech_improved_ore_extraction`.
---
---⚠ Le swap de recettes runtime (`modules/update-recipes.lua`) n'est pas généré : pour un nouveau minerai, il faut y ajouter les entrées à la main.
---@class RitnMinerData
---@field ores table<string, RitnMinerOreData>    Ores registered by `add_data_ore`, keyed by ore name
---@field units table<integer, RitnMinerTechUnit>  Research cost per tier (1..9)
local flib = {
    ores = {}
}

---**EN**
---
---Description: Returns the technology icon of an ore: `graphics/technology/Improved-<ore>-extraction.png`, or the `default` icon when `ore` is nil.
---
---──────────────────────────────
---
---**FR**
---
---Description: Retourne l'icône de technologie d'un minerai : `graphics/technology/Improved-<ore>-extraction.png`, ou l'icône `default` si `ore` est nil.
---@param ore? string   Ore name; nil → `default`
---@return RitnMinerIcon
local function icons(ore)
    local ore_name = "default"
    if ore ~= nil then ore_name = ore end

    return {
        icon = "__RitnMiner__/graphics/technology/Improved-" .. ore_name .. "-extraction.png",
        icon_size = 206,
    }
end

---**EN**
---
---Description: Returns the prerequisites of the 9 technology tiers of an ore. Tier 1: `ritn-tech-miner-mk1`; each next tier requires the previous one; tier 3 also requires `sulfur-processing`, tier 9 `space-science-pack`.
---
---──────────────────────────────
---
---**FR**
---
---Description: Retourne les prérequis des 9 paliers de technologie d'un minerai. Palier 1 : `ritn-tech-miner-mk1` ; chaque palier requiert le précédent ; le palier 3 requiert aussi `sulfur-processing`, le palier 9 `space-science-pack`.
---@param ore string
---@return table<integer, string[]>  Prerequisites keyed by tier (1..9)
local function prerequisites(ore)
    return {
        [1] = { "ritn-tech-miner-mk1" },
        [2] = { "Improved-" .. ore .. "-extraction-1" },
        [3] = { "sulfur-processing", "Improved-" .. ore .. "-extraction-2" },
        [4] = { "Improved-" .. ore .. "-extraction-3" },
        [5] = { "Improved-" .. ore .. "-extraction-4" },
        [6] = { "Improved-" .. ore .. "-extraction-5" },
        [7] = { "Improved-" .. ore .. "-extraction-6" },
        [8] = { "Improved-" .. ore .. "-extraction-7" },
        [9] = { "space-science-pack", "Improved-" .. ore .. "-extraction-8" },
    }
end


local ingredients = {
    [1] = {
        { "miner-science-pack", 1 }
    },
    [2] = {
        { "miner-science-pack", 1 }
    },
    [3] = {
        { "automation-science-pack", 1 },
        { "miner-science-pack",      1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 }
    },
    [4] = {
        { "automation-science-pack", 1 },
        { "miner-science-pack",      1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 }
    },
    [5] = {
        { "automation-science-pack", 1 },
        { "miner-science-pack",      1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 }
    },
    [6] = {
        { "automation-science-pack", 1 },
        { "miner-science-pack",      1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 }
    },
    [7] = {
        { "automation-science-pack", 1 },
        { "miner-science-pack",      1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 },
        { "production-science-pack", 1 }
    },
    [8] = {
        { "automation-science-pack", 1 },
        { "miner-science-pack",      1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 },
        { "production-science-pack", 1 }
    },
    [9] = {
        { "automation-science-pack", 1 },
        { "miner-science-pack",      1 },
        { "logistic-science-pack",   1 },
        { "chemical-science-pack",   1 },
        { "production-science-pack", 1 },
        { "space-science-pack",      1 }
    },
}

flib.units = {
    [1] = { count = 50, ingredients = ingredients[1], time = 30 },
    [2] = { count = 100, ingredients = ingredients[2], time = 30 },
    [3] = { count = 200, ingredients = ingredients[3], time = 30 },
    [4] = { count = 300, ingredients = ingredients[4], time = 30 },
    [5] = { count = 400, ingredients = ingredients[5], time = 30 },
    [6] = { count = 500, ingredients = ingredients[6], time = 30 },
    [7] = { count = 800, ingredients = ingredients[7], time = 60 },
    [8] = { count = 1000, ingredients = ingredients[8], time = 60 },
    [9] = { count = 2000, ingredients = ingredients[9], time = 60 },
}

-- creation de la technologie pour débloqué la recette d'extraction

---**EN**
---
---Description: Builds the technology prototype `Improved-<ore>-extraction-<tech_value>`, which unlocks the recipe `<ore>-extraction-<tech_value>`. Returns the table only: the caller passes it to `data:extend`.
---
---⚠ Reads `ritnmods.miner.data` (the global), not the module table: works only once the module is attached to `ritnmods.miner.data`, and the ore must have been registered with `add_data_ore` first.
---
---──────────────────────────────
---
---**FR**
---
---Description: Construit le prototype de technologie `Improved-<ore>-extraction-<tech_value>`, qui débloque la recette `<ore>-extraction-<tech_value>`. Retourne seulement la table : l'appelant la passe à `data:extend`.
---
---⚠ Lit `ritnmods.miner.data` (le global) et non la table du module : ne fonctionne qu'une fois le module branché sur `ritnmods.miner.data`, et le minerai doit avoir été inscrit avec `add_data_ore` au préalable.
---@param ore string          Ore name (key of `ores`)
---@param tech_value integer  Tier (1..9)
---@return table technology   Technology prototype, not yet extended
function flib.create_tech_improved_ore_extraction(ore, tech_value)
    return {
        type = "technology",
        name = "Improved-" .. ore .. "-extraction-" .. tech_value,
        icon = ritnmods.miner.data.ores[ore].icons.icon,
        icon_size = ritnmods.miner.data.ores[ore].icons.icon_size,
        effects = {
            { type = "unlock-recipe", recipe = ore .. "-extraction-" .. tech_value },
        },
        upgrade = true,
        prerequisites = ritnmods.miner.data.ores[ore].prerequisites[tech_value],
        unit = ritnmods.miner.data.units[tech_value],
        order = "a-b" .. tech_value .. "[" .. ore .. "]",
    }
end

-- ajout d'un minerai en data pour creation

---**EN**
---
---Description: Registers an ore in `ores` (9 tiers, icon, prerequisites) for the technology generation. Icon priority: `icons_ext` > `default` icon (`icon_default = true`) > `Improved-<ore>-extraction.png`.
---
---──────────────────────────────
---
---**FR**
---
---Description: Inscrit un minerai dans `ores` (9 paliers, icône, prérequis) pour la génération des technologies. Priorité de l'icône : `icons_ext` > icône `default` (`icon_default = true`) > `Improved-<ore>-extraction.png`.
---@param ore_name string
---@param icon_default? boolean      When true, uses `Improved-default-extraction.png`
---@param icons_ext? RitnMinerIcon   External icon, overrides everything
function flib.add_data_ore(ore_name, icon_default, icons_ext)
    local iconsDefault = icons()
    local icons = icons(ore_name)
    if icon_default ~= nil and icon_default == true then icons = iconsDefault end
    if icons_ext ~= nil then icons = icons_ext end

    flib.ores[ore_name] = {
        name = ore_name,
        value = 9,
        icons = icons,
        prerequisites = prerequisites(ore_name),
    }
end

-- creation de la recette d'extraction
-- paliers 0 a 2 : broyeur (5 pierres -> 1 minerai + bonus probabilistes)
local crushing_probabilities = {
    [0] = { 0.01, 0.01, 0.01 },
    [1] = { 0.10, 0.05, 0.01 },
    [2] = { 0.20, 0.10, 0.05 },
}

---**EN**
---
---Description: Creates and extends (`data:extend`) the 10 extraction recipes of an ore. Tiers 0-2 (`ritn-crushing`): 5 stone → 1 ore + probabilistic bonus ore + 1 stone. Tiers 3-9 (`chemistry`): 10 stone + 10 sulfuric acid → `tier + 1` ore, with `allow_productivity`. All recipes start disabled (unlocked by the technologies).
---
---⚠ Requires `data.raw.fluid["sulfuric-acid"]` (indexed directly, error if absent). The icons are built from the `ore` and `stone` items (empty layers if the item is absent).
---
---──────────────────────────────
---
---**FR**
---
---Description: Crée et étend (`data:extend`) les 10 recettes d'extraction d'un minerai. Paliers 0-2 (`ritn-crushing`) : 5 pierres → 1 minerai + minerais bonus probabilistes + 1 pierre. Paliers 3-9 (`chemistry`) : 10 pierres + 10 acide sulfurique → `palier + 1` minerais, avec `allow_productivity`. Toutes les recettes démarrent désactivées (débloquées par les technologies).
---
---⚠ Requiert `data.raw.fluid["sulfuric-acid"]` (indexé directement, erreur s'il est absent). Les icônes sont construites à partir des items `ore` et `stone` (calques vides si l'item est absent).
---@param ore string                     Ore item name
---@param crafting_machine_tint? table   Recipe tints `{primary, secondary, tertiary, quaternary}`
function flib.create_recipe_extraction(ore, crafting_machine_tint)
    local RitnProtoItem = require(ritnlib.defines.class.prototype.item)

    local acid = data.raw["fluid"]["sulfuric-acid"]

    local icons_stone = RitnProtoItem(ore):getIconLayers()
    for _, layer in pairs(RitnProtoItem("stone"):getIconLayers(0.25, { 8, 8 })) do
        table.insert(icons_stone, layer)
    end

    local icons_acid = RitnProtoItem(ore):getIconLayers()
    table.insert(icons_acid, {
        icon = acid.icon,
        icon_size = acid.icon_size,
        scale = 0.25,
        shift = { 8, 8 }
    })

    local recipes = {}

    -- ORE : broyeur
    for tier = 0, 2 do
        local results = { { type = "item", name = ore, amount = 1 } }
        for _, probability in ipairs(crushing_probabilities[tier]) do
            table.insert(results, { type = "item", name = ore, amount = 1, independent_probability = probability })
        end
        table.insert(results, { type = "item", name = "stone", amount = 1 })

        table.insert(recipes, {
            --recipe
            type = "recipe",
            name = ore .. "-extraction-" .. tier,
            categories = { "ritn-crushing" },
            subgroup = "ritn-miner",
            energy_required = 3.2,
            enabled = false,
            ingredients =
            {
                { type = "item", name = "stone", amount = 5 }
            },
            results = results,
            icons = icons_stone,
            order = "a[stone-processing]-a",
            crafting_machine_tint = crafting_machine_tint
        })
    end

    -- ORE : usine chimique (paliers 3 a 9 : 4 a 10 minerais)
    for tier = 3, 9 do
        table.insert(recipes, {
            --recipe
            type = "recipe",
            name = ore .. "-extraction-" .. tier,
            categories = { "chemistry" },
            subgroup = "ritn-miner",
            energy_required = 3.2,
            enabled = false,
            ingredients =
            {
                { type = "item", name = "stone",      amount = 10 },
                { type = "fluid", name = "sulfuric-acid", amount = 10 },
            },
            results =
            {
                { type = "item", name = ore, amount = tier + 1 },
            },
            icons = icons_acid,
            order = "a[stone-processing]-a",
            crafting_machine_tint = crafting_machine_tint,
            allow_productivity = true
        })
    end

    data:extend(recipes)
end

return flib
