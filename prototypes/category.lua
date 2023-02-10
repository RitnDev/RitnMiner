local RitnProtoSubgroup = require(ritnlib.defines.class.prototype.subgroup)
local RitnProtoCategory = require(ritnlib.defines.class.prototype.category)

--ITEM SUBGROUPS
RitnProtoSubgroup:extend("ritn-miner", "intermediate-products", "a-a")
RitnProtoSubgroup:extend("ritn-disassemble", "intermediate-products", "z-a-a")

--RECIPE CATEGORY
RitnProtoCategory:extend("ritn-crushing")

