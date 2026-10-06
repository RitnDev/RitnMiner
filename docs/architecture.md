---
title: Architecture interne RitnMiner
audience: mainteneur
status: living
last_review: 2026-10-06
pinned_version: 0.8.6
---

# Architecture interne — RitnMiner

> Document interne mainteneur. Vue d'ensemble de la structure du code, des dépendances et des choix de conception.
> Mis à jour à chaque refactor structurel — section « Historique » en bas.
>
> **Version auditée : état actuel 0.8.6, Factorio 1.1, RitnLib 0.8.2.** La migration vers Factorio 2.1 est la
> prochaine étape : tout ce qui est marqué **[1.x]** dans ce document est de la matière de migration, pas un bug.
>
> Liens GitHub épinglés sur le commit `a104a83` (commit « 0.8.6 » — aucun tag git n'existe dans le repo).

## 1. Identité

RitnMiner est un **mod de gameplay quasi entièrement data stage** (`info.json.factorio_version = "1.1"`).

**Concept** : le fer et le cuivre ne sont plus générés sur la carte. On les obtient **en broyant de la pierre**
dans un « broyeur » (`miner_mk1` / `miner_mk2`), avec 9 paliers de recherche qui améliorent le rendement.
Le mod ajoute aussi un pack de science dédié (`miner-science-pack`), injecté dans ~25 technologies vanilla,
et remplace le pétrole brut par du **pétrole de schiste** (fabriqué à partir de pierre).

| Trait | Constat |
|---|---|
| **Consumer** de RitnLib | Toutes les modifications de prototypes passent par les classes `RitnProto*` ; le runtime passe par `eventListener` + `RitnLibEvent` / `RitnLibTechnology` |
| **Socle léger (data stage)** | Expose le global `ritnmods.miner` (drapeaux de compat + générateur `ritnmods.miner.data`), lu par RitnMiner-extension-1 et testé par RitnLumberjack |
| Provider | **Non** — aucun `remote.add_interface` |

Dépendances (`info.json`) :

| Dépendance | Type | Usage réel |
|---|---|---|
| `base >= 1.1` | requise | — |
| `RitnLib >= 0.8.2` | requise | classes data + runtime, `eventListener` |
| `RitnLumberjack >= 0.8` | optionnelle | lit `ritnmods.lumberjack.enabled` |
| `RitnGlass >= 0.8` | optionnelle | lit `ritnmods.glass.enabled` |
| `CommuLogo >= 1.0` | optionnelle | modifie recette/tech `bigcommulogo` |
| `DiscoScience >= 1.0.0` | optionnelle | couleur du pack via remote |
| `MorePlaceableTiles` | **incompatible** (`!`) | — |

Mods détectés **sans** être déclarés dans `info.json` (via `mods[...]` ou `ritnmods.*`) : `Bio_Industries`,
`Dectorio`, `alien-biomes`, `spaceblock`, `RitnWaterfill`.

## 2. Vue d'ensemble — ce qui s'exécute, stage par stage

Lecture : de haut en bas = ordre de chargement Factorio. Chaque boîte = un fichier d'entrée et ce qu'il appelle.

```
┌──────────────────────────────────────────────────────────────────────
│ SETTINGS STAGE            (rien — le mod n'a aucun setting)
└──────────────────────────────────────────────────────────────────────

┌──────────────────────────────────────────────────────────────────────
│ DATA STAGE — data.lua
├──────────────────────────────────────────────────────────────────────
│ 1. Crée le global  ritnmods.miner
│      • drapeaux de compat (bio, dectorio, lumberjack, …)
│      • .data = modules/data.lua  (générateur minerai → recettes/tech)
│ 2. Supprime les minerais  iron-ore, copper-ore  (RitnProtoOre)
│ 3. Modifie des items vanilla (stack_size, icône)
│ 4. Crée les prototypes du mod :
│      prototypes/category.lua       subgroups + catégorie ritn-crushing
│      prototypes/item.lua           broyeurs mk1/mk2, science pack
│      prototypes/recipes.lua        stone-processing, shale-oil
│      prototypes/technology.lua     broyeur, science pack, shale-oil
│      prototypes/ore-extraction.lua 20 recettes + 18 techs d'extraction
│      prototypes/map-gen-presets.lua  preset de carte "ritn"
│ 5. Modifie les technologies vanilla (prototypes/update-technology)
│ 6. Compat : mods/data-landfill, mods/data-ritn-lumberjack
│ 7. Ajoute miner-science-pack aux labs
│ 8. Si RitnGlass + Bio_Industries : recettes ritn-stone(-brick)
└──────────────────────────────────────────────────────────────────────

┌──────────────────────────────────────────────────────────────────────
│ DATA-UPDATES — data-updates.lua      (compat avec d'autres mods)
├──────────────────────────────────────────────────────────────────────
│   mods/data-updates-bioIndustries.lua   si Bio_Industries
│   mods/data-updates-commu-logo.lua      si CommuLogo
│   mods/data-updates-dectorio.lua        si Dectorio
│   (inline) techs waterfill              si RitnWaterfill
└──────────────────────────────────────────────────────────────────────

┌──────────────────────────────────────────────────────────────────────
│ DATA-FINAL-FIXES — data-final-fixes.lua
├──────────────────────────────────────────────────────────────────────
│   Supprime le minerai crude-oil
└──────────────────────────────────────────────────────────────────────

┌──────────────────────────────────────────────────────────────────────
│ CONTROL STAGE — control.lua            (en jeu)
├──────────────────────────────────────────────────────────────────────
│   RitnLib eventListener  ──►  modules/miner.lua
│        on_research_finished : remplace les recettes d'extraction
│        dans les broyeurs (table modules/update-recipes.lua)
│   modules/disco-science.lua
│        on_init / on_configuration_changed : couleur du pack
│        (remote DiscoScience, via RitnLibEvent)
│   Aucun storage, aucune commande, aucune remote interface exposée
└──────────────────────────────────────────────────────────────────────
```

Répartition du code (lignes Lua) : data stage ≈ 1 850, control stage ≈ 180 (dont 139 de table de données).

## 3. Entrypoints

| Stage | Fichier | Action |
|---|---|---|
| **settings** | _aucun_ | — |
| **data** | [data.lua](https://github.com/RitnDev/RitnMiner/blob/a104a83/data.lua) | init `ritnmods.miner`, suppression fer/cuivre, require de tout `prototypes/*`, compat landfill/lumberjack, ajout pack aux labs, recettes conditionnelles RitnGlass |
| **data-updates** | [data-updates.lua](https://github.com/RitnDev/RitnMiner/blob/a104a83/data-updates.lua) | compat Bio_Industries, CommuLogo, Dectorio, RitnWaterfill |
| **data-final-fixes** | [data-final-fixes.lua](https://github.com/RitnDev/RitnMiner/blob/a104a83/data-final-fixes.lua) | `RitnProtoOre("crude-oil"):remove()` |
| **control** | [control.lua](https://github.com/RitnDev/RitnMiner/blob/a104a83/control.lua) | setup classes RitnLib, gvv optionnel, enregistrement du module `miner` dans l'eventListener, puis `modules/disco-science` |
| **migrations** | _aucun dossier_ | — |

## 4. Global data stage `ritnmods.miner`

Créé dans [data.lua:9-18](https://github.com/RitnDev/RitnMiner/blob/a104a83/data.lua#L9-L18), seulement s'il n'existe
pas déjà. Il vit **uniquement dans l'état Lua du data stage** (partagé entre tous les mods), il n'est pas persisté.

```lua
ritnmods.miner = {
    bio = false,          -- mods["Bio_Industries"]        (data.lua:24)
    lumberjack = false,   -- ritnmods.lumberjack.enabled   (data.lua:28-30)
    dectorio = false,     -- mods["Dectorio"]              (data.lua:21)
    alienBiomes = false,  -- mods["alien-biomes"]          (data.lua:22)
    spaceblock = false,   -- mods["spaceblock"]            (data.lua:23)
    commuLogo = false,    -- mods["CommuLogo"]             (data.lua:25)
    data = require("modules.data"),   -- générateur, voir §5
}
```

Globals **lus** par RitnMiner (posés par d'autres mods dans leur `data.lua`) :

| Global | Posé par | Lu dans |
|---|---|---|
| `ritnmods.lumberjack(.enabled)` | RitnLumberjack | `data.lua:28,61` |
| `ritnmods.glass(.enabled)` | RitnGlass | `data.lua:68-69`, `mods/data-updates-bioIndustries.lua:74-75` |
| `ritnmods.waterfill` | RitnWaterfill (`data.lua:7`) | `data-updates.lua:11` |

Lecteurs **externes** de `ritnmods.miner` (vérifié par grep) :
- `RitnMiner-extension-1/data.lua:6` — ajoute `ritnmods.miner.extension`.
- `RitnLumberjack/data-final-fixes.lua:10` — `not ritnmods.miner` : n'applique sa propre compat CommuLogo que si RitnMiner est absent.

## 5. Générateur d'extraction de minerai (`modules/data.lua`)

Seul « système » réutilisable du mod. C'est une table de fonctions (`local flib … return flib`), exposée via
`ritnmods.miner.data`. **Pas de classe, pas de factory.**

| Membre | Rôle |
|---|---|
| `ores` | registre `{[ore_name] = {name, value=9, icons, prerequisites}}`, rempli par `add_data_ore` |
| `units` | coûts de recherche des paliers 1 à 9 (count / ingredients / time) |
| `add_data_ore(ore_name, icon_default?, icons_ext?)` | inscrit un minerai dans `ores` (icône `Improved-<ore>-extraction.png` par défaut) |
| `create_recipe_extraction(ore, tint)` | `data:extend` de 10 recettes `<ore>-extraction-0..9` et ajout des paliers 3-9 aux `limitation` des modules de productivité |
| `create_tech_improved_ore_extraction(ore, n)` | **retourne** (n'étend pas) le prototype de tech `Improved-<ore>-extraction-<n>` |

Paliers produits par minerai :

| Palier | Catégorie | Entrée | Sortie |
|---|---|---|---|
| 0 → 2 | `ritn-crushing` (broyeur) | 5 pierres | 1 minerai + bonus probabilistes + 1 pierre |
| 3 → 9 | `chemistry` | 10 pierres + 10 acide sulfurique | 4 → 10 minerais |

Utilisation : [prototypes/ore-extraction.lua](https://github.com/RitnDev/RitnMiner/blob/a104a83/prototypes/ore-extraction.lua)
boucle sur `{"iron-ore", "copper-ore"}`, puis génère les techs 1..9 pour chaque minerai de `ores`.

## 6. Flux d'exécution

### Data stage (chaîne principale)

```
data.lua
 ├─ ritnmods.miner = {flags…, data = modules/data.lua}
 ├─ RitnProtoOre("iron-ore"/"copper-ore"):remove()   ← retire resource + autoplace + presets
 ├─ prototypes/ore-extraction.lua
 │    ├─ data.add_data_ore("iron-ore" | "copper-ore")
 │    ├─ data.create_recipe_extraction(ore, tint)      → 10 recettes / minerai
 │    └─ data.create_tech_improved_ore_extraction(ore, 1..9) → 9 techs / minerai
 └─ prototypes/update-technology.lua                    ← miner-science-pack injecté partout
data-updates.lua  → compat mods tiers
data-final-fixes.lua → crude-oil supprimé
```

### Runtime : changement de recette sur recherche

```
on_research_finished(e)                              modules/miner.lua:5
 └─ RitnLibEvent(e):getTechnology()                  → RitnLibTechnology
     └─ tech = update-recipes[tech.name]             table statique (18 entrées)
         └─ si trouvée :
            RitnTech:updateRecipe(name, disableTabRecipes, setRecipeName)
              ├─ force.recipes[r].enabled = false  pour chaque recette obsolète
              └─ pour chaque surface, chaque assembling-machine de la force :
                    si recette = une recette obsolète → set_recipe(nouvelle)
```

Les paliers 0-2 et 3-9 sont deux chaînes séparées : la tech 3 n'a pas d'entrée dans la table (passage du
broyeur à l'usine chimique, catégories différentes).

### Bootstrap control

```
control.lua
 ├─ require RitnLib defines + setup-classes     → globals RitnLib* dans _G
 ├─ gvv si actif
 ├─ eventListener.add_libraries({miner = modules/miner})
 │     (l'eventListener de RitnLib 0.8.2 remplace script.on_init / on_load
 │      par une file d'attente : core/eventListener.lua:228-235)
 └─ require modules/disco-science
       script.on_init(f)  → mis en file par l'eventListener  ✔
       script.on_configuration_changed(f) → enregistré directement
```

Le commentaire `control.lua:14` (« DiscoScience doit être placé après event_listener ») repose sur ce
comportement de l'eventListener 0.8.x. **Point de migration critique**, voir §11.

## 7. Persistance

| Aspect | Statut |
|---|---|
| `global` / `storage` | **Aucun** — le mod ne persiste rien |
| `script.register_metatable` | Aucun |
| Wrappers RitnLib (`RitnLibTechnology`) | Créés à chaque event, jamais stockés ✔ |
| État effectif persistant | Uniquement l'état moteur : `force.recipes[*].enabled` et la recette des machines, modifiés par `updateRecipe` |

C'est une caractéristique d'architecture, pas un manque.

## 8. Évènements

| Évènement | Fichier | Enregistré via | Rôle |
|---|---|---|---|
| `on_research_finished` | [modules/miner.lua:5-16](https://github.com/RitnDev/RitnMiner/blob/a104a83/modules/miner.lua#L5-L16) | eventListener RitnLib (`module.events`) | swap des recettes d'extraction |
| `on_init` | [modules/disco-science.lua:8](https://github.com/RitnDev/RitnMiner/blob/a104a83/modules/disco-science.lua#L8) | `script.on_init` (intercepté par l'eventListener) | couleur DiscoScience |
| `on_configuration_changed` | [modules/disco-science.lua:7](https://github.com/RitnDev/RitnMiner/blob/a104a83/modules/disco-science.lua#L7) | `script.on_configuration_changed` direct | couleur DiscoScience |
| `on_load` | eventListener RitnLib | — | ré-enregistre les events |

Aucun `on_nth_tick`, aucun `on_tick`, aucun custom event, aucune commande.

## 9. Interfaces remote

**Exposées : aucune.**

**Consommées :**

| Interface.fonction | Appel | Garde |
|---|---|---|
| `DiscoScience.setIngredientColor("miner-science-pack", {r=0.592,g=0.565,b=0.808})` | indirect, via `RitnLibEvent.setIngredientColor` ([modules/disco-science.lua:4](https://github.com/RitnDev/RitnMiner/blob/a104a83/modules/disco-science.lua#L4)) | RitnLib vérifie `remote.interfaces["DiscoScience"]` avant l'appel |

## 10. APIs Factorio touchées

| Surface | Where | Usage type |
|---|---|---|
| `data.raw.resource` / `autoplace-control` / `map-gen-presets` | `data.lua:33-34`, `data-final-fixes.lua:7` (via RitnProtoOre) | suppression fer, cuivre, crude-oil |
| `data.raw["map-gen-presets"].default.ritn` | `prototypes/map-gen-presets.lua` | création/màj du preset « ritn » (partagé avec RitnLumberjack) |
| `data.raw.module[productivity-module*].limitation` | `modules/data.lua:416-424`, `items/miner-science-pack.lua:40-48`, `recipes/shale-oil.lua:36-42` | autorise la productivité **[1.x]** |
| `data.raw.lab[*].inputs` | `data.lua:61-65` (via `RitnProtoTech:addPackLab`) | ajout du science pack |
| `data.raw.technology` | `prototypes/update-technology.lua`, `mods/*` | packs, prérequis, recettes débloquées |
| `data.raw.recipe` (Dectorio) | `mods/data-updates-dectorio.lua:3-8` | boucle sur toutes les recettes `dect-*-gravel` |
| `LuaForce.recipes[].enabled` | via `RitnLibTechnology:updateRecipe` | désactivation des anciennes recettes |
| `LuaSurface.find_entities_filtered` + `LuaEntity.set_recipe` | via `RitnLibTechnology:updateRecipe` | parcours de toutes les surfaces, à chaque recherche concernée (18 techs) — coût ponctuel, pas d'impact UPS continu |
| `remote.call` | via `RitnLibEvent.setIngredientColor` | DiscoScience |

## 11. Dette / erreurs résiduelles (synthèse)

Détail et classification complète : [docs/audit/handoff.md §C.6](audit/handoff.md).

- **Migration 2.1 (bloquant)** : nombreux résidus **[1.x]** au data stage (`normal`/`expensive`, `result`/`result_count`,
  ingrédients en format court, `icon_mipmaps`, `module.limitation`, `module_specification`, `emissions_per_minute`,
  `working_visualisations`, preset de carte — déjà signalé en TODO dans `map-gen-presets.lua`).
- **Migration 2.1 — control** : avec RitnLib 0.10, `ritnlib.defines.event` pointe vers le core `event_handler`, qui
  **n'intercepte plus** `script.on_init`. L'appel de `modules/disco-science.lua:8` écraserait alors l'`on_init` de
  l'event_handler, et `on_research_finished` ne serait enregistré qu'après un premier rechargement de la partie.
  Non problématique en 0.8.6.
- **Effets de bord mineurs** : clé de locale FR `miner-mk2` au lieu de `miner_mk2` ; `allowed_effects = {productivity}`
  (global inexistant → `{}`) sur `shale-oil`.
- **Hors périmètre (géré ailleurs, décision Ritn)** : tech `miner-science-pack` cachée ; dépendance implicite de
  RitnHiladdar/RitnMechanic au pack `miner-science-pack` ; typage de `ritnmods.miner.extension`.

## 12. Sortie attendue post-refactor

| Version | Vague | Contenu |
|---|---|---|
| 0.8.6 | état actuel | Factorio 1.1 / RitnLib 0.8.2 — documenté ici |
| (prochaine) | Migration 2.1 | `factorio_version = "2.1"`, `RitnLib >= 0.10`, conversion des prototypes, preset de carte, ordre `on_init` |
| (après) | Doc | annotations LuaLS (skill 2) puis doc utilisateur |

## Historique

| Date | Version pin | Changement |
|---|---|---|
| 2026-10-06 | 0.8.6 | Document initial (audit phases 1-4, état 1.1 avant migration 2.1) |
