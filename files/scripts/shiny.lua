local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x + me + 2934835, y + GameGetFrameNum() + 999)
local threshold = 1
if GameHasFlagRun("PERK_PICKED_GRAHAM_LUCKY_CLOVER") then threshold = threshold * 8 end
-- dummy
if Random(1, 8192) <= threshold then
    EntityKill(me)
    me = EntityLoad("data/entities/animals/graham_fuzz_shiny.xml", x, y)
end

if Random(1, 1024) <= threshold then
    local child = EntityLoad("data/entities/misc/effect_charm.xml")
    EntityAddChild(me, child)
end