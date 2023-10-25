local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x + me + 2934835, y + GameGetFrameNum() + 999)
local threshold = 1
if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then threshold = threshold * 8 end
-- dummy
if Random(1, 8192) <= threshold then
    EntityLoad("data/entities/animals/graham_fuzz_shiny.xml", x, y)
    EntityKill(me)
end