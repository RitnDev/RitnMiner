---@meta
---@diagnostic disable

-- ============================================================================
-- Type-only meta file for RitnMiner data-stage globals.
-- ============================================================================
--
-- NOT loaded at runtime by Factorio. Sole purpose: help LuaLS resolve global
-- references across source files (and across the Ritn mods that read
-- `ritnmods.miner`).
--
-- The full definitions (with bilingual descriptions) live in their source
-- files: `RitnMinerGlobal` in data.lua, `RitnMinerData` in modules/data.lua.
--
-- Discipline: when you add a @field to a class in its source file, mirror it
-- here too.
-- ============================================================================


-- ═══ data.lua (data stage) ══════════════════════════════════════════════════

---@class RitnMods
---@field miner RitnMinerGlobal
ritnmods = {}

---@class RitnMinerGlobal
---@field lumberjack boolean
---@field dectorio boolean
---@field alienBiomes boolean
---@field spaceblock boolean
---@field commuLogo boolean
---@field data RitnMinerData


-- ═══ modules/data.lua (ritnmods.miner.data) ═════════════════════════════════

---@class RitnMinerIcon
---@field icon string
---@field icon_size integer

---@class RitnMinerOreData
---@field name string
---@field value integer
---@field icons RitnMinerIcon
---@field prerequisites table<integer, string[]>

---@class RitnMinerTechUnit
---@field count integer
---@field ingredients table[]
---@field time number

---@class RitnMinerData
---@field ores table<string, RitnMinerOreData>
---@field units table<integer, RitnMinerTechUnit>
