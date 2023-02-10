local RitnEvent = require(ritnlib.defines.class.luaClass.event)
----------------------------------------------------------------
local function updateDiscoScience()
    RitnEvent.setIngredientColor("miner-science-pack", {r = 0.592, g = 0.565, b = 0.808})
end
----------------------------------------------------------------
script.on_configuration_changed(updateDiscoScience)
script.on_init(updateDiscoScience)
----------------------------------------------------------------
