local me = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform(me)
SetRandomSeed(me + x + 1340, y + GameGetFrameNum() + 193408)
-- tell no one about this
local rare1 = 8000
if Random(1, rare1) == 1 then
    local eid = EntityLoad("mods/grahamsperks/files/entities/books/bookbook.xml", x, y)
    EntityApplyTransform(eid, x, y, rot)
    EntityKill(me)
end
local rare2 = 800
if Random(1, rare2) == 1 then
    local eid = EntityLoad("mods/grahamsperks/files/entities/books/corrupt/0" .. Random(1,8) .. ".xml", x, y)
    EntityApplyTransform(eid, x, y, rot)
    EntityKill(me)
end