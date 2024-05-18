local me = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform(me)
SetRandomSeed(x + 1340, y + 193408)
local rare1 = 5000
if Random(1, rare1) == 1 then
    local eid = EntityLoad("mods/grahamsperks/files/entities/books/bookbook.xml", x, y)
    EntityApplyTransform(eid, x, y, rot)
    EntityKill(me)
end
local rare2 = 500
if Random(1, rare2) == 1 then
    local eid = EntityLoad("mods/grahamsperks/files/entities/books/corrupt/0" .. Random(1,8) .. ".xml", x, y)
    EntityApplyTransform(eid, x, y, rot)
    EntityKill(me)
end