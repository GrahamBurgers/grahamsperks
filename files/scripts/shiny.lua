local me = GetUpdatedEntityID()
local x, y = EntityGetTransform(me)
SetRandomSeed(x + me, y + GameGetFrameNum() + 999)
if Random(1, 8192) == 8192 then
    EntityLoad("data/entities/animals/graham_fuzz_shiny.xml", x, y)
    EntityKill(me)
end