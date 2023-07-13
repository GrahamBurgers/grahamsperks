local me = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform(me)
SetRandomSeed(me + x + 1340, y + GameGetFrameNum() + 193408)
if Random(1, 10000) == 10000 then
    -- tell no one about this
    local eid = EntityLoad("mods/grahamsperks/files/entities/books/bookbook.xml", x, y)
    EntityApplyTransform(eid, x, y, rot)
    EntityKill(me)
end