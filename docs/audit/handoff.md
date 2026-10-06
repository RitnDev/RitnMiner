---
title: Dossier de passation — RitnMiner
mod: RitnMiner
profile: consumer (+ socle léger data stage)
factorio_version: "1.1"
pinned_version: 0.8.6
audit_date: 2026-10-06
---

# Dossier de passation — RitnMiner

> Matière pour la skill 2 (annotations LuaLS) et la future doc. Faits vérifiés dans le code ou par grep ;
> `(hypothèse)` / `(à confirmer)` sinon. Audit de l'**état actuel 1.1** ; la migration 2.1 est la prochaine étape
> annoncée par Ritn — les éléments **[1.x]** sont de la matière de migration.
> Architecture : [../architecture.md](../architecture.md).

## A. Métadonnées & périmètre

- **Profil** : consumer de RitnLib (data + runtime) ; socle léger via le global data stage `ritnmods.miner`.
  Ni provider, ni extension de classes (aucun héritage inter-mod).
- **Dépendances** (`info.json`) : `base >= 1.1`, `RitnLib >= 0.8.2` ; optionnelles `RitnLumberjack`, `RitnGlass`,
  `CommuLogo`, `DiscoScience` ; incompatible `MorePlaceableTiles`. Détectés sans déclaration : `Bio_Industries`,
  `Dectorio`, `alien-biomes`, `spaceblock`, `RitnWaterfill`.
- **Référence RitnLib** utilisée pour l'audit : `RitnLib_0.8.2.zip` (mods Factorio de Ritn), car le RitnLib du repo
  (0.10.6) cible Factorio 2.1 et n'est pas chargeable avec ce mod.
- **Arborescence explorée** : intégralité (34 `.lua`, 2 locales, changelog, `info.json`, `graphics/`).
- **Exclus** : `graphics/` (assets ; `stone_crusher*.png` = images de Bio Industries d'après les commentaires),
  `README.md` (vide).
- **Arbre de travail non propre** au moment de l'audit : `prototypes/map-gen-presets.lua` modifié (TODO 2.1 ajouté
  en commentaire) — pris tel quel.

## B. Pour la skill 2 — surface d'API à annoter (LuaLS)

> Remarque : le mod n'a **aucune classe**. La surface est faite de tables de fonctions, d'une table de données et
> d'un global data stage. Les fichiers `prototypes/*` et `mods/*` sont des scripts déclaratifs (`data:extend` ou
> appels `RitnProto*`) sans symbole public.

### B.1 Table des cibles

| Fichier | Symbole | Nature | Hérite de | Accès | Miroir meta-file ? | Statut |
|---|---|---|---|---|---|---|
| `data.lua:9-18` | `ritnmods.miner` | global data stage (table) | — | global | oui → `types/ritnminer-globals.lua` (à créer) | à annoter |
| `modules/data.lua` | module `flib` (= `ritnmods.miner.data`) | table de fonctions `local … return` | — | `require("modules.data")` + global via `ritnmods.miner.data` | non (typé via le `@field data` du global) | à annoter |
| `modules/data.lua:5,15` | `icons`, `prerequisites` | fonctions locales | — | local | non | à annoter (léger) |
| `modules/miner.lua` | module `{events = {...}}` | module eventListener | — | `require` par `control.lua` | non | à annoter |
| `modules/miner.lua:5` | `on_research_finished` | fonction locale (handler) | — | local | non | à annoter |
| `modules/update-recipes.lua` | table `tech` | table de données | — | `require` | non | à annoter (`@class` d'entrée) |
| `modules/disco-science.lua:3` | `updateDiscoScience` | fonction locale | — | local | non | à annoter + ⚠ migration |
| `control.lua` | `modules`, `event_listener` | locales | — | local | non | commentaire seulement |
| `prototypes/**`, `mods/**`, `data-updates.lua`, `data-final-fixes.lua` | — | scripts data déclaratifs | — | — | — | **exclure** (pas de surface publique) ; éventuellement `---@type` sur les tables locales réutilisées (`miner1`, `crafting_machine_tint`) |

### B.2 Détail par symbole

#### `ritnmods.miner` (global data stage)
- `bio :: boolean` — `mods["Bio_Industries"]` (`data.lua:24`). Write : data.lua uniquement.
- `lumberjack :: boolean` — `true` si `ritnmods.lumberjack.enabled` (`data.lua:28-30`).
- `dectorio :: boolean` — `mods["Dectorio"]` (`data.lua:21`).
- `alienBiomes :: boolean` — `mods["alien-biomes"]` (`data.lua:22`).
- `spaceblock :: boolean` — `mods["spaceblock"]` (`data.lua:23`).
- `commuLogo :: boolean` — `mods["CommuLogo"]` (`data.lua:25`).
- `data :: RitnMinerData` — le module générateur.
- `extension` — ajouté par RitnMiner-extension-1 (`RitnMiner-extension-1/data.lua:6`). **Ne pas le typer dans
  RitnMiner** : Hors périmètre RitnMiner — géré ailleurs (décision Ritn, 2026-10-06).
- ⚠ Créé seulement `if not ritnmods.miner` (`data.lua:10`) : si un autre mod l'a créé avant, ses champs ne sont pas
  initialisés (aucun cas observé).

#### `RitnMinerData` (`modules/data.lua`)
- `ores :: table<string, RitnMinerOreData>` — registre rempli par `add_data_ore`. Entrée :
  `{name: string, value: integer (=9, nb de paliers), icons: {icon: string, icon_size: integer}, prerequisites: table<integer, string[]>}`.
- `units :: table<integer, TechnologyUnit>` — paliers 1..9 (`count` 50→2000, `time` 30/60, `ingredients` croissants).
- `add_data_ore(ore_name: string, icon_default?: boolean, icons_ext?: {icon, icon_size}) → nil` — effet : écrit `ores[ore_name]`.
  Icône : `graphics/technology/Improved-<ore>-extraction.png` (206 px) ; `icon_default=true` → `Improved-default-extraction.png` ;
  `icons_ext` prime sur tout.
- `create_recipe_extraction(ore: string, crafting_machine_tint?: table) → nil` — effets : `data:extend` de 10 recettes
  `<ore>-extraction-0..9` + insertion des paliers 3..9 dans `limitation` des 3 modules de productivité.
  Prérequis implicites : `data.raw.item[ore]`, `data.raw.item.stone`, `data.raw.fluid["sulfuric-acid"]`,
  `data.raw.module["productivity-module(-2|-3)"]` doivent exister (sinon erreur d'indexation).
- `create_tech_improved_ore_extraction(ore: string, tech_value: integer) → TechnologyPrototype` — **retourne** la
  table, n'appelle pas `data:extend`. Prérequis : `ores[ore]` déjà inscrit via `add_data_ore`.
  ⚠ Lit `ritnmods.miner.data` (global) et non `flib` (`modules/data.lua:102-109`) : ne fonctionne qu'une fois le
  module branché sur le global.
- Locales : `icons(ore?: string) → {icon, icon_size}` ; `prerequisites(ore: string) → table<integer, string[]>`
  (palier 1 : `ritn-tech-miner-mk1` ; 3 : + `sulfur-processing` ; 9 : + `space-science-pack`).
- ⚠ **[1.x]** `icon_mipmaps`, ingrédients format court `{"stone", 5}`, `module.limitation` (`modules/data.lua:136-424`).

#### Module `modules/miner.lua`
- Forme : `{ events = { [defines.events.on_research_finished] = on_research_finished } }` — contrat du
  `eventListener` RitnLib (`add_libraries`).
- `on_research_finished(e: EventData.on_research_finished)` : `RitnLibEvent(e):getTechnology()` → lookup dans
  `update-recipes` → `RitnTech:updateRecipe(name, disableTabRecipes, setRecipeName)`.

#### Table `modules/update-recipes.lua`
- `table<string, RitnMinerTechSwap>` indexée par nom de tech ; 18 entrées (fer/cuivre × paliers 1,2,4,5,6,7,8,9).
- `RitnMinerTechSwap = {name: string, disableTabRecipes: string[], setRecipeName: string}`.
- Invariant : `name` == clé ; `disableTabRecipes` = paliers inférieurs **de la même famille** (0-2 broyeur ou 3-9 chimie).

#### `modules/disco-science.lua`
- `updateDiscoScience()` — appelle `RitnLibEvent.setIngredientColor("miner-science-pack", {r=0.592,g=0.565,b=0.808})`.
- ⚠ Migration : dépend de l'interception de `script.on_init` par l'eventListener RitnLib 0.8.x (voir C.6).

## C. Matière de documentation

### C.1 Carte des « systèmes » (pas de classes)

| Système | Fichier(s) | Rôle | Accès | Description courte |
|---|---|---|---|---|
| Global de compat | `data.lua:9-30` | drapeaux de mods tiers | `ritnmods.miner` | Partage la détection de mods avec les autres mods Ritn |
| Générateur d'extraction | `modules/data.lua`, `prototypes/ore-extraction.lua` | recettes + techs par minerai | `ritnmods.miner.data` | Rend la chaîne « pierre → minerai » paramétrable par minerai |
| Broyeurs | `prototypes/entity/miner.lua`, `prototypes/items/miner.lua`, `technologies/broyeur.lua` | machines `miner_mk1/mk2` (assembling-machine, `ritn-crushing`) | prototypes | mk1 : vitesse 0.5, 170 kW ; mk2 : vitesse 1, 52 kW, 2 modules |
| Science pack Mineur | `items/miner-science-pack.lua`, `technologies/miner-science-pack.lua`, `update-technology.lua`, `data.lua:61-65` | nouveau pack + injection dans les techs vanilla | prototypes | 4 briques + 1 foreuse thermique → 2 packs |
| Pétrole de schiste | `recipes/shale-oil.lua`, `technologies/shale-oil.lua`, `update-technology.lua:5-9,61-71` | remplace le pétrole brut | prototypes | 10 pierres + 25 eau + 50 vapeur → huiles/gaz ; `advanced-oil-processing` désactivé |
| Désassemblage | `recipes/disassembler.lua`, `mods/data-ritn-lumberjack.lua` | 5 recettes de recyclage | prototypes | Seulement si RitnLumberjack inactif |
| Preset de carte | `prototypes/map-gen-presets.lua` | preset « ritn » | prototypes | Partagé avec RitnLumberjack (création ou complément) |
| Swap de recettes | `modules/miner.lua`, `modules/update-recipes.lua` | runtime | eventListener | À chaque palier, remplace l'ancienne recette dans les machines |
| Compat mods tiers | `mods/*`, `data-updates.lua` | Bio_Industries, CommuLogo, Dectorio, Waterfill, landfill/spaceblock | — | Ajustements de techs/recettes |

### C.2 Détail par système public

**Générateur (`ritnmods.miner.data`)** — seul point d'extension. Exemple réel (seul usage, dans le mod lui-même) :
```lua
-- RitnMiner/prototypes/ore-extraction.lua:20-28
for i, data_ore in pairs(data_ores) do
    ritnmods.miner.data.add_data_ore(data_ore)
    ritnmods.miner.data.create_recipe_extraction(data_ore, crafting_machine_tint[data_ore])
end
for _,ore in pairs(ritnmods.miner.data.ores) do
    for tech_value = 1, ore.value do
        data:extend({ritnmods.miner.data.create_tech_improved_ore_extraction(ore.name, tech_value)})
    end
end
```
Aucun autre mod n'appelle ces fonctions (grep `W:\git\Factorio` : RitnMiner-extension-1 ne fait qu'ajouter
`ritnmods.miner.extension`). Pièges : appeler `add_data_ore` **avant** `create_tech_…` ; le swap runtime n'est
**pas** généré — il faut ajouter les entrées à la main dans `update-recipes.lua` pour un nouveau minerai.

**Interaction avec RitnLib (classes utilisées)** — matière pour une page « dépendances » :
`RitnProtoOre:remove`, `RitnProtoItem:changePrototype/changeSubgroup`, `RitnProtoRecipe:addNewIngredient/changePrototype/disable`,
`RitnProtoTech:addPack/removePack/replacePack/multipliedPack/addPrerequisite/removePrerequisite/replacePrerequisite/addRecipe/removeRecipe/disable/setCount/setTime`,
`RitnProtoTech:addPackLab` (appelé sur la **classe**, `data.lua:62,64`), `RitnProtoSubgroup:extend`, `RitnProtoCategory:extend`,
`RitnLibEvent(e):getTechnology()`, `RitnLibTechnology:updateRecipe`, `RitnLibEvent.setIngredientColor`.
Toutes vérifiées présentes dans RitnLib 0.8.2 **et** 0.10.6. Toutes les méthodes `RitnProtoTech` ont une garde
`if self.prototype == nil then return self end` → les appels sur des techs Dectorio absentes
(`update-technology.lua:77-95`) sont sans effet.

### C.3 Interface remote

Exposée : **aucune**. Sortante : `DiscoScience.setIngredientColor` via `RitnLibEvent.setIngredientColor`
(garde `remote.interfaces` côté RitnLib).

### C.4 Event Map

| Event | Handler | Enregistrement | Chaîne |
|---|---|---|---|
| `on_research_finished` | `modules/miner.lua:5` | eventListener 0.8.2 (`module.events`) | lookup `update-recipes` → `updateRecipe` (désactive recettes de la force + `set_recipe` sur toutes les `assembling-machine` de la force, toutes surfaces) |
| `on_init` | `modules/disco-science.lua:8` | `script.on_init` intercepté → file `lost_on_init_events` (RitnLib 0.8.2 `core/eventListener.lua:228`) | `setIngredientColor` |
| `on_configuration_changed` | `modules/disco-science.lua:7` | direct | `setIngredientColor` |
| `on_load` | eventListener | interne RitnLib | ré-enregistrement des events |

Aucun `on_nth_tick`, custom event ni commande. Coût : `updateRecipe` parcourt toutes les surfaces, mais seulement à
la fin des 18 recherches listées → coût ponctuel.

### C.5 Persistence Map

**Aucune structure `global`/`storage`.** Aucun `register_metatable`. Le seul état persistant est l'état moteur
modifié par `updateRecipe` (`force.recipes[*].enabled`, recette des machines). `ritnmods.miner` n'existe qu'au data
stage (non persisté).

### C.6 Classification des défauts

**Défauts latents / points de migration confirmés en source**

| Élément | Fichier | Mécanisme | Statut |
|---|---|---|---|
| Ordre `on_init` vs event_handler | `modules/disco-science.lua:7-8`, `control.lua:12-15` | En 0.8.2, l'eventListener remplace `script.on_init` par une file → OK. Avec RitnLib 0.10 (`defines.event = "__core__/lualib/event_handler"`), `script.on_init` n'est plus intercepté : l'appel écrase l'`on_init` du core handler (qui fait `register_events()`, `core/lualib/event_handler.lua:88-95`). `on_research_finished` ne serait enregistré qu'au premier `on_load`. | **Pas un bug en 0.8.6** ; défaut **certain à la migration** si le code n'est pas adapté |
| `set_recipe` lors du swap | via `RitnLibTechnology:updateRecipe` | `set_recipe` retire les items en cours de la machine (renvoyés par l'API, non réinsérés par RitnLib) | `(hypothèse)` perte des ingrédients en cours — à vérifier en jeu |

**Effets de bord mineurs**
- Clé de locale FR `[item-name] miner-mk2` (`locale/fr/local.cfg:4`) au lieu de `miner_mk2` (EN correct). Clé
  morte ; effet visible probablement nul car un item posable se rabat sur le nom de l'entité `(hypothèse)`.
- `allowed_effects = {productivity}` (`prototypes/recipes/shale-oil.lua:30`) : `productivity` est un global
  inexistant → `{}` ; la propriété n'existe de toute façon pas sur une recette 1.1 → ignorée. La productivité
  passe réellement par `limitation` (l. 36-42).
- `local item` redéclaré 5 fois (`prototypes/recipes/disassembler.lua:20-60`) — style seulement.
- Condition incohérente : `data.lua:61` teste `ritnmods.lumberjack` (présence du mod) pour l'index du pack dans les
  labs, alors que le reste du mod teste `ritnmods.miner.lumberjack` (= `.enabled`). Effet : position du pack dans
  les labs uniquement.

**Résidus API 1.x → migration 2.1** (liste de travail pour la migration)
- `info.json` : `factorio_version = "1.1"`, `base >= 1.1`, `RitnLib >= 0.8.2`.
- Recettes `normal`/`expensive` : `prototypes/items/miner.lua:32-56,79-105`.
- `result` / `result_count` : `items/miner-science-pack.lua:27-28`, `items/miner.lua`, `recipes/stone-brick.lua:46-47`, `recipes/stone.lua:35-36`.
- Ingrédients / résultats en format court `{"x", n}` : `modules/data.lua:183,…`, `recipes/disassembler.lua:93-196`,
  `recipes/stone-processing.lua:16`, `recipes/stone-brick.lua:42-43`, `recipes/stone.lua:33`, `technologies/*` (ingrédients de tech = format encore valide en 2.0 `(à confirmer)`),
  `mods/data-updates-commu-logo.lua:11-14`.
- `icon_mipmaps` : `modules/data.lua`, `recipes/*`, `items/miner-science-pack.lua:10`, `technologies/*`.
- `data.raw.module[...].limitation` (supprimé en 2.0 → `allow_productivity` sur la recette) : `modules/data.lua:416-424`,
  `items/miner-science-pack.lua:40-48`, `recipes/shale-oil.lua:36-42`.
- Entité : `module_specification` → `module_slots`, `emissions_per_minute = 6` → table `{pollution = 6}`,
  `animation`/`working_visualisations` (format 2.0 `graphics_set`) — `prototypes/entity/miner.lua`.
- Preset de carte : `terrain_segmentation`, `water`, `control-setting:*`, `research_queue_setting` —
  `prototypes/map-gen-presets.lua` (TODO déjà rédigé, correction de référence dans RitnLumberjack).
- `upgrade = true` sur les techs générées (`modules/data.lua:107`) — `(à confirmer)` en 2.x.
- Noms vanilla à revérifier en 2.x : `advanced-oil-processing`, `kovarex-enrichment-process`, `mining-productivity-*`,
  `research-speed-*`, `steel-axe`, `artillery-shell-*`, `military-science-pack` (icône), `offshore-pump` subgroup
  `(à confirmer — non vérifié dans data/base 2.1)`.
- Ordre `on_init` (voir tableau ci-dessus).

**Ce qui n'est PAS un bug**
- Tech `Improved-*-extraction-3` absente de `update-recipes.lua` : passage broyeur → usine chimique, catégories
  différentes, aucun swap possible. Voulu.
- Appels `RitnProtoTech("dect-…")` sans test de présence de Dectorio : gardés par RitnLib (nil → no-op).
- `RitnProtoTech:addPackLab(...)` appelé sur la classe : la méthode n'utilise pas `self` hormis le retour.
- Lecture de `ritnmods.waterfill` sans dépendance déclarée : le data stage de tous les mods s'exécute avant tout
  `data-updates`, l'ordre est donc garanti.

**Tranché par Ritn — Hors périmètre RitnMiner — géré ailleurs (décision Ritn, 2026-10-06).**
- Tech `miner-science-pack` (`technologies/miner-science-pack.lua`, `enabled = false`, mêmes effets que
  `ritn-tech-miner-mk1`) : rien à faire dans RitnMiner, ne pas le signaler comme défaut.
- RitnHiladdar / RitnMechanic qui utilisent `miner-science-pack` sans dépendance déclarée : rien à faire.

### C.7 Plan de documentation recommandé

1. **Tier 0** : page concept « chaîne pierre → minerai » (paliers, broyeurs, science pack, schiste) — c'est ce qui
   change le gameplay vanilla.
2. **Tier 0** : page compatibilité (tableau mod tiers → effet).
3. **Tier 1** : référence `ritnmods.miner` / `ritnmods.miner.data` (seule API pour un mod d'extension).
4. Changelog / migration 2.1 : à écrire **après** la migration, à partir de la liste C.6.

Recommandation : faire la **migration 2.1 avant** les annotations (skill 2) et la doc — la majorité des lignes
concernées va changer. Zone la plus délicate à comprendre : le couplage implicite via les globals `ritnmods.*`
entre mods Ritn (ordre de chargement, drapeaux).

## D. Questions ouvertes pour Ritn

1. Skill 2 : annoter avant ou après la migration 2.1 (recommandé : après) ?

Résolues (2026-10-06) — Hors périmètre RitnMiner — géré ailleurs (décision Ritn, 2026-10-06). : tech `miner-science-pack` cachée ; dépendances implicites
RitnHiladdar/RitnMechanic ; typage de `ritnmods.miner.extension` (relève de RitnMiner-extension-1).
